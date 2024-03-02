part of '../add_new_transaction_screen.dart';

class _AddButton extends StatelessWidget {
  const _AddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.add_box,
            size: 42.r,
          ),
          SizedBox(width: 5),
          Text(
            KeyWork.add.tr,
            style: TextStyleUtils.regular(16),
          ),
        ],
      ),
    );
  }
}
