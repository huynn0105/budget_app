part of '../add_new_transaction_screen.dart';

class _MoneyTextField extends StatelessWidget {
  const _MoneyTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: controller,
      style: TextStyleUtils.regular(35),
      textAlign: TextAlign.center,
      maxLength: 16,
      keyboardType: TextInputType.number,
      autofocus: true,
      inputFormatters: [
        CurrencyInputFormatter(
          thousandSeparator: ThousandSeparator.Comma,
          mantissaLength: 0,
          trailingSymbol: 'đ',
        )
      ],
      decoration: const InputDecoration(
        counter: SizedBox.shrink(),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

