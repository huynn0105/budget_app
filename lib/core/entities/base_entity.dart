import 'package:hive/hive.dart';

class BaseEntity extends HiveObject {
  @HiveField(0)
  final String id;
  BaseEntity({required this.id});
}
