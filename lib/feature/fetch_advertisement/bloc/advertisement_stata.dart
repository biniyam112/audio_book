import 'package:audio_books/models/advertisement.dart';
import 'package:equatable/equatable.dart';

class AdvertisementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleState extends AdvertisementState {}

class AdvertFetched extends AdvertisementState {
  final List<Advertisement> ads;

  AdvertFetched({required this.ads});
}

class AdvertFetching extends AdvertisementState {}

class AdvertFetchingFailed extends AdvertisementState {
  final String errorMessage;

  AdvertFetchingFailed({required this.errorMessage});
}
