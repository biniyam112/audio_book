import 'package:audio_books/feature/fetch_advertisement/data_provider/advertisement_data_provider.dart';
import 'package:audio_books/models/advertisement.dart';

class AdvertisementRepo {
  final AdvertisementDP advertisementDP;

  AdvertisementRepo({required this.advertisementDP});

  Future<List<Advertisement>> fetchAdverts(String token) async {
    return await advertisementDP.fetchAdverts(token);
  }
}
