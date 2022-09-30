part of '../add_new_transaction_screen.dart';

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h)),
          minimumSize: MaterialStateProperty.all(
            const Size(20, 30),
          ),
          textStyle: MaterialStateProperty.all(TextStyleUtils.medium(14))),
      child: const Text('Save'),
    );
  }
}
