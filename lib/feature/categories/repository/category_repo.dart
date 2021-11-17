import 'package:audio_books/feature/categories/dataprovider/category_dataprovider.dart';
import 'package:audio_books/models/models.dart';

class CategoryRepo {
  final CategoryDataProvider categoryDataProvider;

  CategoryRepo({required this.categoryDataProvider});

  Future<List<Category>> fetchCategories(String token) async {
    return await categoryDataProvider.fetchCategories(token);
  }
}
