part of '../add_new_transaction_screen.dart';

class CategoriesBottomSheet extends StatelessWidget {
  const CategoriesBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select " + KeyWork.category.tr,
            style: TextStyleUtils.medium(24),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryInitial) {
                return const CircularProgressIndicator();
              }
              if (state is CategoryLoaded) {
                return GridView.builder(
                    itemCount: state.categories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    itemBuilder: (context, index) => _Button(
                          emoji: state.categories[index].emoji,
                          name: state.categories[index].name.tr,
                          onLongPress: () {},
                          onTap: () {
                            context.read<CategoryBloc>().add(CategorySelected(
                                category: state.categories[index]));
                                Get.back();
                          },
                        ));
              }
              return const Text('Something went wrong!');
            },
          ),
        ],
      ),
    );
  }
}
