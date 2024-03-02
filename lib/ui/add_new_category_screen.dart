import 'dart:io';

import 'package:budget_app/constants.dart';
import 'package:budget_app/core/blocs/category_bloc/category_bloc.dart';
import 'package:budget_app/core/entities/category_entity.dart' as app;
import 'package:budget_app/translation/keyword.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:budget_app/core/entities/category_entity.dart' as entity;
import 'package:uuid/uuid.dart';

class AddNewCategoryArgument {
  final entity.Category category;
  const AddNewCategoryArgument({required this.category});
}

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({
    super.key,
    this.argument,
  });
  final AddNewCategoryArgument? argument;

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  @override
  void initState() {
    controller = TextEditingController(text: widget.argument?.category.name.tr);
    emojiText = widget.argument?.category.emoji ?? '❤';
    super.initState();
  }

  late TextEditingController controller;

  late String emojiText = '❤';
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
              ? KeyWork.newCategory.tr
              : KeyWork.editCategory.tr,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                context.read<CategoryBloc>().add(
                      CategoryAdded(
                        category: widget.argument?.category == null
                            ? app.Category(
                                name: controller.text,
                                emoji: emojiText,
                                 id: Uuid().v4(),
                              )
                            : widget.argument!.category.copyWith(
                                name: controller.text,
                                emoji: emojiText,
                              ),
                      ),
                    );
                Navigator.of(context).pop();
              },
              child: Text(KeyWork.done.tr)),
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
                hintText: KeyWork.enterCategoryName.tr,
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
