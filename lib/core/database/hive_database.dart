import 'package:budget_app/core/entities/base_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_constants.dart';

class HiveDatabase {
  HiveDatabase();

  Future<void> init() async {
    /// Initial Hive DB
    await Hive.initFlutter();
    await _initBox();
  }

  Future<void> _initBox() async {
    for (final key in HiveBoxMap.hiveBoxMap.keys) {
      HiveBoxMap.hiveBoxMap[key]?.registerAdapterFunction();
      await HiveBoxMap.hiveBoxMap[key]?.openBoxFunction();
    }
  }

  Box<T> getMyBox<T extends BaseEntity>() {
    return Hive.box<T>(HiveBoxMap.hiveBoxMap[T]!.boxName);
  }
}
