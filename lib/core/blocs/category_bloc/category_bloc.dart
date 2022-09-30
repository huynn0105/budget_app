import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final _categoryService = locator<ICategoryService>();

  CategoryBloc() : super(const CategoryInitial()) {
    on<CategoryStarted>((event, emit) {
      final categories = _categoryService.getCategoris();
      emit(CategoryLoaded(
          categories: categories, categorySelected: categories.first));
    });
    on<CategoryAdded>((event, emit) {
      final state = this.state;
      if (state is CategoryLoaded) {
        _categoryService.insertCategory(event.category);

        emit(CategoryLoaded(
            categories: [...state.categories, event.category],
            categorySelected: event.category));
      }
    });
    on<CategorySelected>((event, emit) {
      final state = this.state;
      if (state is CategoryLoaded) {
        emit(
          CategoryLoaded(
            categorySelected: event.category,
            categories: state.categories,
          ),
        );
      }
    });
    on<CategoryDeleted>((event, emit) {
      final state = this.state;
      if (state is CategoryLoaded) {
        _categoryService.deleteCategory(event.category);

        emit(
          CategoryLoaded(
            categorySelected: state.categorySelected.id == event.category.id
                ? state.categories.first
                : state.categorySelected,
            categories: [...state.categories]..remove(event.category),
          ),
        );
      }
    });
  }
}
