import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/core/services/interfaces/icategory_service.dart';
import 'package:budget_app/global/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final _categoryService = locator<ICategoryService>();

  CategoryBloc() : super(const CategoryInitial()) {
    on<CategoryStarted>((event, emit) async {
      final categories = await _categoryService.getCategories();
      emit(CategoryLoaded(
          categories: categories, categorySelected: categories.first));
    });
    on<CategoryAdded>((event, emit) async {
      final state = this.state;
      if (state is CategoryLoaded) {
        _categoryService.insertCategory(event.category);
        final categories = await _categoryService.getCategories();

        emit(CategoryLoaded(
            categories: categories, categorySelected: event.category));
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
    on<CategoryDeleted>((event, emit) async {
      final state = this.state;
      if (state is CategoryLoaded) {
        _categoryService.deleteCategory(event.category);
        final categories = await _categoryService.getCategories();
        emit(
          CategoryLoaded(
            categorySelected: state.categorySelected.id == event.category.id
                ? categories.first
                : state.categorySelected,
            categories: categories,
          ),
        );
      }
    });
    on<CategoryClear>((event, emit) async {
      await _categoryService.clear();
      final categories = await _categoryService.getCategories();
      CategoryLoaded(
          categories: categories, categorySelected: categories.first);
    });

    var a = '0'.obs;
  }
}
