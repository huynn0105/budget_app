part of '../add_new_transaction_screen.dart';

class CategoriesBottomSheet extends StatelessWidget {
  const CategoriesBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 0.5.sh,
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Categories',
                style:
                    TextStyleUtils.medium(16).copyWith(color: Colors.black54),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryInitial) {
                      return const CircularProgressIndicator();
                    }
                    if (state is CategoryLoaded) {
                      return GridView.builder(
                        itemCount: state.categories.length + 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) => index !=
                                state.categories.length
                            ? _Button(
                                emoji: state.categories[index].emoji,
                                name: state.categories[index].name,
                                onLongPress: () {
                                  context.read<CategoryBloc>().add(
                                      CategoryDeleted(
                                          category: state.categories[index]));
                                },
                                onTap: () {
                                  context.read<CategoryBloc>().add(
                                      CategorySelected(
                                          category: state.categories[index]));
                                },
                              )
                            : _AddButton(onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const AddNewCategoryScreen()));
                              }),
                      );
                    }
                    return const Text('Something went wrong!');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

