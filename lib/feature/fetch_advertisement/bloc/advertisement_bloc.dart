import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_event.dart';
import 'package:audio_books/feature/fetch_advertisement/bloc/advertisement_stata.dart';
import 'package:audio_books/feature/fetch_advertisement/repository/advertisement_repo.dart';
import 'package:audio_books/feature/podcast/podcast.dart';
import 'package:audio_books/models/models.dart';
import 'package:audio_books/services/audio/service_locator.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  AdvertisementBloc({required this.advertisementRepo}) : super(IdleState());

  final AdvertisementRepo advertisementRepo;

  @override
  Stream<AdvertisementState> mapEventToState(AdvertisementEvent event) async* {
    if (event is FetchAdvertEvent) {
      yield AdvertFetching();
      try {
        var user = getIt.get<User>();
        var ads = await advertisementRepo.fetchAdverts(user.token!);
        yield AdvertFetched(ads: ads);
      } catch (e) {
        yield AdvertFetchingFailed(errorMessage: e.toString());
      }
    }
  }
}
