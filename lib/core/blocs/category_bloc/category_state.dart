part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final Category categorySelected;
  const CategoryLoaded({
    required this.categories,
    required this.categorySelected,
  });
  @override
  List<Object> get props => [categories, categorySelected];
}

class CategoryError extends CategoryState {
  const CategoryError();
  @override
  List<Object> get props => [];
}
