import 'package:expense_manager/core/database/daos/base_dao.dart';
import 'package:expense_manager/core/entities/budget_entity.dart';
import 'package:expense_manager/core/entities/setting_entity.dart';
import 'package:expense_manager/translation/keyword.dart';
import 'package:get/get.dart';

class SettingDao extends BaseDao<SettingEntity> {
  SettingEntity getCurrentSetting() {
    if (this.getAll().isEmpty) {
      this.insert(SettingEntity()
        ..budget.target = Budget(
          name: KeyWork.myBudget.tr,
          image: '🧍',
        ));
    }
    return this.getAll().first;
  }
}
