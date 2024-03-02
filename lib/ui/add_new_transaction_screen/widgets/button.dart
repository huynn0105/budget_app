part of '../add_new_transaction_screen.dart';

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.emoji,
    required this.name,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  final String emoji;
  final String name;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: TextStyleUtils.medium(30),
              maxLines: 1,
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: TextStyleUtils.medium(18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
