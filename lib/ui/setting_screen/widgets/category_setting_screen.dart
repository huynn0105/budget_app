import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/entities/category_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:budget_app/ui/add_new_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CategorySettingScreen extends StatelessWidget {
  const CategorySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyWork.category.tr),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Card(
          margin: EdgeInsets.all(16.r),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      index != state.categories.length
                          ? _CategoryItem(
                              category: state.categories[index],
                            )
                          : AddItem(
                              onTap: () {
                                Get.to(() => AddNewCategoryScreen());
                              },
                              name: KeyWork.newCategory.tr,
                            ),
                  itemCount: state.categories.length + 1,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.h,
                    color: Colors.grey.shade300,
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => AddNewCategoryScreen(
            argument: AddNewCategoryArgument(category: category),
          ),
        );
      },
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.23,
          key: const ValueKey(1),
          children: [
            SlidableAction(
              onPressed: (context) {
                context
                    .read<CategoryBloc>()
                    .add(CategoryDeleted(category: category));
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              Text(
                category.emoji,
                style: TextStyleUtils.regular(18),
              ),
              SizedBox(width: 10.w),
              Text(category.name.tr, style: TextStyleUtils.regular(14)),
            ],
          ),
        ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  const AddItem({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 26.r,
            ),
            SizedBox(width: 10.w),
            Text(name, style: TextStyleUtils.regular(14))
          ],
        ),
      ),
    );
  }
}
