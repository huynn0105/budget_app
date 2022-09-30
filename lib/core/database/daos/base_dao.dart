// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_app/core/database/object_box.dart';
import 'package:budget_app/core/entities/base_entity.dart';
import 'package:budget_app/global/locator.dart';
import 'package:budget_app/objectbox.g.dart';
import 'package:flutter/foundation.dart';

abstract class BaseDao<T extends BaseEntity> {
  @protected
  late Box<T> _box;
  BaseDao() {
    _box = locator<ObjectBox>().getMyBox<T>();
  }

  T? findById(int id) => _box.get(id);
  int insert(T entity) => _box.put(entity);
  bool delete(int id) => _box.remove(id);
  void deleteAll() => _box.removeAll();
  List<int> insertAll(List<T> entities) => _box.putMany(entities);
  List<T> getAll() => _box.getAll();
  Stream<List<T>> getAllStream() =>
      _box.query().watch(triggerImmediately: true).map((event) => event.find());
}
