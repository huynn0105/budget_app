part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryStarted extends CategoryEvent {
  const CategoryStarted();
  @override
  List<Object> get props => [];
}

class CategoryAdded extends CategoryEvent {
  final Category category;
  const CategoryAdded({required this.category});
  @override
  List<Object> get props => [category];
}

class CategorySelected extends CategoryEvent {
  final Category category;
  const CategorySelected({required this.category});
  @override
  List<Object> get props => [category];
}

class CategoryDeleted extends CategoryEvent {
  final Category category;
  const CategoryDeleted({required this.category});
  @override
  List<Object> get props => [category];
}
