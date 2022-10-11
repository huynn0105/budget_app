import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  int get id;
  set id(int value);
}
