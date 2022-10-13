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
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            emoji,
            style: TextStyleUtils.medium(30),
            maxLines: 1,
          ),
          Text(
            name,
            style: TextStyleUtils.regular(16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
