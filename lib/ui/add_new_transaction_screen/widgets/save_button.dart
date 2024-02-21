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
      child: Text(
        KeyWork.save.tr,
        style: TextStyleUtils.medium(30),
      ),
    );
  }
}
