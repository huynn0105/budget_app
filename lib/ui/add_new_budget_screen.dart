import 'dart:io';

import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/budget_bloc/budget_bloc.dart';
import 'package:budget_app/core/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:budget_app/core/entities/budget_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNewBudgetArgument {
  final Budget budget;
  const AddNewBudgetArgument({required this.budget});
}

class AddNewBudgetScreen extends StatefulWidget {
  const AddNewBudgetScreen({
    super.key,
    this.argument,
  });
  final AddNewBudgetArgument? argument;

  @override
  State<AddNewBudgetScreen> createState() => _AddNewBudgetScreenState();
}

class _AddNewBudgetScreenState extends State<AddNewBudgetScreen> {
  @override
  void initState() {
    controller = TextEditingController(text: widget.argument?.budget.name.tr);
    emojiText = widget.argument?.budget.image ?? '🧍';
    super.initState();
  }

  late TextEditingController controller;

  late String emojiText = '🧍';
  _onEmojiSelected(Emoji emoji) {
    setState(() {
      emojiText = emoji.emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.argument == null
              ? KeyWork.newBudget.tr
              : KeyWork.editBudget.tr,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                context.read<BudgetBloc>().add(
                      BudgetAdded(
                        budget: widget.argument?.budget == null
                            ? Budget(
                                name: controller.text,
                                image: emojiText,
                              )
                            : widget.argument!.budget.copyWith(
                                name: controller.text,
                                image: emojiText,
                              ),
                      ),
                    );
                context.read<TransactionBloc>().add(TransactionStarted());
                Navigator.of(context).pop();
              },
              child: Text(KeyWork.done.tr)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            // InkWell(
            //   onTap: () {
            //     showModalBottomSheet(
            //       context: context,
            //       builder: (context) => EmojiPicker(
            //         onEmojiSelected: (Category category, Emoji emoji) {
            //           _onEmojiSelected(emoji);
            //         },
            //         config: Config(
            //           columns: 7,
            //           emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
            //           verticalSpacing: 0,
            //           horizontalSpacing: 0,
            //           gridPadding: EdgeInsets.zero,
            //           initCategory: Category.RECENT,
            //           bgColor: const Color(0xFFF2F2F2),
            //           indicatorColor: Colors.blue,
            //           iconColor: Colors.grey,
            //           iconColorSelected: Colors.blue,
            //           progressIndicatorColor: Colors.blue,
            //           backspaceColor: Colors.blue,
            //           skinToneDialogBgColor: Colors.white,
            //           skinToneIndicatorColor: Colors.grey,
            //           enableSkinTones: true,
            //           showRecentsTab: true,
            //           recentsLimit: 28,
            //           replaceEmojiOnLimitExceed: false,
            //           tabIndicatorAnimDuration: kTabScrollDuration,
            //           categoryIcons: const CategoryIcons(),
            //           buttonMode: ButtonMode.CUPERTINO,
            //         ),
            //       ),
            //     );
            //   },
            //   child: DottedBorder(
            //     borderType: BorderType.Circle,
            //     dashPattern: const [5, 5, 5, 5, 5, 5, 5],
            //     padding: EdgeInsets.all(20.r),
            //     color: Colors.grey,
            //     child: Text(
            //       emojiText,
            //       style: TextStyleUtils.regular(50),
            //     ),
            //   ),
            // ),
            SizedBox(height: 10.h),
            TextField(
              textAlign: TextAlign.center,
              controller: controller,
              decoration: InputDecoration(
                hintText: KeyWork.enterBudget.tr,
                hintStyle: TextStyleUtils.regular(20),
                border: InputBorder.none,
              ),
              style: TextStyleUtils.regular(20),
            ),
          ],
        ),
      ),
    );
  }
}
