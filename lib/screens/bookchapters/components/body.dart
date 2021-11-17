import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_bloc.dart';
import 'package:audio_books/feature/fetch_downloaded_book/bloc/fetch_down_book_state.dart';
import 'package:audio_books/models/downloaded_book.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'episode_tile_for_downloaded.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.downloadedBook,
  }) : super(key: key);
  final DownloadedBook downloadedBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<FetchBookEpisodesBloc, FetchEpisodesState>(
              builder: (context, state) {
            if (state is EpisodesFetchedState) {
              return Column(
                children: [
                  ...List.generate(
                    state.downloadedEpisodes.length,
                    (index) {
                      return EpisodeTileForDownload(
                        chapterNumber: index + 1,
                        episode: state.downloadedEpisodes[index],
                        book: downloadedBook,
                      );
                    },
                  ),
                ],
              );
            }
            return Container(
              height: SizeConfig.screenHeight! * .9,
            );
          }),
        ),
      ),
    );
  }
}
