import 'dart:io';

import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/account_bloc/account_bloc.dart';
import 'package:budget_app/core/entities/account_entity.dart';
import 'package:budget_app/translation/keyword.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNewAccountScreen extends StatefulWidget {
  const AddNewAccountScreen({super.key});

  @override
  State<AddNewAccountScreen> createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends State<AddNewAccountScreen> {
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  late TextEditingController controller;

  String emojiText = '❤';
  _onEmojiSelected(Emoji emoji) {
    setState(() {
      emojiText = emoji.emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          KeyWork.newAccount.tr,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[50],
        actions: [
          TextButton(
              onPressed: () {
                context.read<AccountBloc>().add(
                      AccountAdded(
                        account: Account(
                          name: controller.text,
                          emoji: emojiText,
                        ),
                      ),
                    );
                Navigator.of(context).pop();
              },
              child:  Text(KeyWork.done.tr)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => EmojiPicker(
                    onEmojiSelected: (Category category, Emoji emoji) {
                      _onEmojiSelected(emoji);
                    },
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      skinToneDialogBgColor: Colors.white,
                      skinToneIndicatorColor: Colors.grey,
                      enableSkinTones: true,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      replaceEmojiOnLimitExceed: false,
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.CUPERTINO,
                    ),
                  ),
                );
              },
              child: DottedBorder(
                borderType: BorderType.Circle,
                dashPattern: const [5, 5, 5, 5, 5, 5, 5],
                padding: EdgeInsets.all(20.r),
                color: Colors.grey,
                child: Text(
                  emojiText,
                  style: TextStyleUtils.regular(50),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              textAlign: TextAlign.center,
              controller: controller,
              decoration: InputDecoration(
                hintText: KeyWork.enterAccountName.tr,
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
