import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class StoreBookEvent extends Equatable {
  final Book book;

  StoreBookEvent(this.book);

  @override
  List<Object?> get props => [];
}
