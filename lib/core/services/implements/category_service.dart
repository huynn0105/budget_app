import 'package:budget_app/core/database/daos/category_dao.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/global/locator.dart';

class CategoryService implements ICategoryService {
  final _categoryDao = locator<CategoryDao>();
  @override
  List<Category> getCategoris() {
    final categories = _categoryDao.getAll();
    if (categories.isEmpty) {
      _categoryDao.insertAll(Category.cetegoriesDefault);
    }
    return _categoryDao.getAll();
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
    _categoryDao.delete(category.id);
  }
}
