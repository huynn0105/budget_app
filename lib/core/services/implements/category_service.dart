import 'package:expense_manager/core/database/daos/category_dao.dart';
import 'package:expense_manager/core/entities/category_entity.dart';
import 'package:expense_manager/core/services/interfaces/icategory_service.dart';
import 'package:expense_manager/global/locator.dart';

class CategoryService implements ICategoryService {
  final _categoryDao = locator<CategoryDao>();
  @override
  List<Category> getCategories() {
    final categories = _categoryDao.getAll();
    if (categories.isEmpty) {
      _categoryDao.insertAll(Category.cetegoriesDefault);
    }
    return _categoryDao.getAll().where((x) => x.active).toList();
  }

  @override
  int insertCategory(Category category) {
    return _categoryDao.insert(category);
  }

  @override
  Category? findCategoryById(int id) {
    return _categoryDao.findById(id);
  }

  @override
  void deleteCategory(Category category) {
    // _categoryDao.delete(category.id);
    // active = false => Soft Delete
    _categoryDao.update(category.copyWith(active: false));
  }

  @override
  void updateCategory(Category category) {
    _categoryDao.update(category);
  }

  @override
  void clear() {
    _categoryDao.deleteAll();
  }
}
