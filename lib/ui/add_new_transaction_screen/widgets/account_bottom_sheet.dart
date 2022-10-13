part of '../add_new_transaction_screen.dart';

class _AccountBottomSheet extends StatelessWidget {
  const _AccountBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Account',
              style: TextStyleUtils.medium(18).copyWith(color: Colors.black54),
            ),
            SizedBox(height: 10.h),
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountInitial) {
                  return const CircularProgressIndicator();
                }
                if (state is AccountLoaded) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.accounts.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) => index !=
                            state.accounts.length
                        ? _Button(
                            emoji: state.accounts[index].emoji,
                            name: state.accounts[index].name,
                            onLongPress: () {
                              context.read<AccountBloc>().add(AccountDeleted(
                                  account: state.accounts[index]));
                            },
                            onTap: () {
                              context.read<AccountBloc>().add(AccountSelected(
                                  account: state.accounts[index]));
                            },
                          )
                        : _AddButton(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AddNewAccountScreen()));
                            },
                          ),
                  );
                }
                return const Text('Something went wrong!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
