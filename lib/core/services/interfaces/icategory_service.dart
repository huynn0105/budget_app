import 'package:budget_app/core/entities/category_entity.dart';

abstract class ICategoryService {
  List<Category> getCategories();
  Category? findCategoryById(int id);
  int insertCategory(Category category);
  void deleteCategory(Category category);
  void clear();
}
