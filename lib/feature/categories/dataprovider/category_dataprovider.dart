import 'dart:convert';

import 'package:audio_books/models/models.dart';
import 'package:http/http.dart' as http;

class CategoryDataProvider {
  final http.Client client;

  CategoryDataProvider({required this.client});

  Future<List<Category>> fetchCategories(String token) async {
    final response = await client.get(
      Uri.parse('http://www.marakigebeya.com.et/api/Books/GetCategory'),
    );
    if (response.statusCode == 200) {
      var categories = jsonDecode(response.body)['items'] as List;
      return categories.map((category) => Category.fromMap(category)).toList();
    } else {
      throw Exception('unable to get book categories');
    }
  }
}
