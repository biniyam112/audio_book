import 'package:audio_books/models/models.dart';

class FetchChaptersEvent {
  final Book book;

  FetchChaptersEvent({required this.book});
}
