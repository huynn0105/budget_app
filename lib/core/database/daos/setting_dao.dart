import 'package:budget_app/core/database/daos/base_dao.dart';
import 'package:budget_app/core/entities/budget_entity.dart';
import 'package:budget_app/core/entities/setting_entity.dart';
import 'package:budget_app/translation/keyword.dart';
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
