import 'package:budget_app/core/database/daos/category_dao.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/global/locator.dart';

class CategoryService implements ICategoryService {
  final _categoryDao = locator<CategoryDao>();
  @override
  Future<List<Category>> getCategories() async {
    final categories = _categoryDao.getAll();
    if (categories.isEmpty) {
      await _categoryDao.insertAll(Category.cetegoriesDefault);
    }
    return _categoryDao.getAll().where((x) => x.active).toList();
  }

  @override
  Future<void> insertCategory(Category category) async {
    _categoryDao.insert(category);
  }

  @override
  Category? findCategoryById(String id) {
    return _categoryDao.findById(id);
  }

  @override
  Future<void> deleteCategory(Category category) async {
    // _categoryDao.delete(category.id);
    // active = false => Soft Delete
    _categoryDao.update(category.id, category.copyWith(active: false));
  }

  @override
  Future<void> updateCategory(Category category) async {
    _categoryDao.update(category.id, category);
  }

  @override
  Future<void> clear() async {
    await _categoryDao.clear();
  }
}
