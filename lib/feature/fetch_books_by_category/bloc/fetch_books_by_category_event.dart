import 'package:audio_books/models/category.dart';

class FetchBooksByCategoryEvent {
  final Category category;

  FetchBooksByCategoryEvent({required this.category});
}
