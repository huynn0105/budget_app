part of '../chart_screen.dart';

class _CustomLegend extends StatelessWidget {
  const _CustomLegend({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: 5.r,
          backgroundColor: color,
        ),
        SizedBox(
          width: 8.0.w,
        ),
        Text(
          title,
          style: TextStyleUtils.regular(16),
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
