import 'package:budget_app/core/entities/category_entity.dart';

abstract class ICategoryService {
  Future<List<Category>> getCategories();
  Category? findCategoryById(String id);
  Future<void> insertCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(Category category);
  Future<void> clear();
}
