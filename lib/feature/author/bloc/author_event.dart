import 'package:audio_books/models/models.dart';
import 'package:equatable/equatable.dart';

class AuthorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAuthor extends AuthorEvent {
  final Book book;

  FetchAuthor({required this.book});
}
