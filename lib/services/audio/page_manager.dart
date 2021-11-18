import 'package:audio_books/models/api_podcast_episode.dart';
import 'package:audio_books/models/downloaded_episode.dart';
import 'package:audio_books/models/episode.dart';
import 'package:audio_books/services/audio/play_button_notifier.dart';
import 'package:audio_books/services/audio/playlist_repository.dart';
import 'package:audio_books/services/audio/service_locator.dart';
import 'package:flutter/foundation.dart';

import 'package:audio_service/audio_service.dart';

import 'notifiers/progress_notifier.dart';
import 'notifiers/repeat_button_notifier.dart';

class PageManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final currentIndexNotifier = ValueNotifier<int>(0);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();

  // Events: Calls coming from the UI
  void init({
    List<Episode>? chapters,
    List<DownloadedEpisode>? downloadedEpisodes,
    List<APIPodcastEpisode>? podcastEpisodes,
  }) async {
    if (chapters != null) await _loadPlaylist(chapters);
    if (downloadedEpisodes != null)
      await _laodDownloadedPlaylist(downloadedEpisodes);
    if (podcastEpisodes != null) await _loadPodcastPlaylist(podcastEpisodes);
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  Future<void> _loadPlaylist(List<Episode> chapters) async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = songRepository.fetchInitialPlaylist(chapters);
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              title: song['title'] ?? '',
              album: song['album'] ?? '',
              extras: {'url': song['url']},
            ))
        .toList();
    print('the media item is $mediaItems');
    _audioHandler.addQueueItems(mediaItems);
  }

  Future<void> _laodDownloadedPlaylist(
      List<DownloadedEpisode> downloadedEpisodes) async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist =
        songRepository.fetchInitialPlaylistFromDownloaded(downloadedEpisodes);
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              extras: {'url': song['url']},
            ))
        .toList();

    _audioHandler.addQueueItems(mediaItems);
  }

  Future<void> _loadPodcastPlaylist(
      List<APIPodcastEpisode> podcastEpisodes) async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist =
        songRepository.fetchInitialPlaylistFromPoscast(podcastEpisodes);
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              extras: {'url': song['url']},
            ))
        .toList();
    _audioHandler.addQueueItems(mediaItems);
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = '';
      } else {
        final newList = playlist.map((item) => item.title).toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem?.title ?? '';
      if (mediaItem != null)
        currentIndexNotifier.value =
            _audioHandler.queue.value.indexOf(mediaItem);
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  Future<void> add(Episode episode) async {
    final songRepository = getIt<PlaylistRepository>();
    final song = songRepository.fetchAnotherSong(episode);
    final mediaItem = MediaItem(
      id: song['id'] ?? '',
      album: song['album'] ?? '',
      title: song['title'] ?? '',
      extras: {'url': song['url']},
    );
    _audioHandler.addQueueItem(mediaItem);
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }

  void playSpeed(double d) {
    _audioHandler.setSpeed(d);
  }
}
