import 'package:coinwise/pages/models/article.dart';

enum Category { health, general, technology, science }

abstract class NewsRepository {
  Future<List<Article>> fetchAllNews();
  Future<List<Article>> fetchCategory(Category category);
}
