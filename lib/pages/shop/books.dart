import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_large.dart';
import 'package:ildiz/companents/filds/text_small.dart';
import 'package:ildiz/controllers/get_controller.dart';
import 'package:ildiz/resource/colors.dart';
import '../../book_custom_lib/src/book_controller.dart';
import '../../book_custom_lib/src/e_book.dart';
import '../../book_custom_lib/src/ebook_controller.dart';

class BookPages extends StatefulWidget {
  final String url;
  final String title;

  const BookPages({super.key, required this.url, required this.title});

  @override
  State<BookPages> createState() => _BookState();
}

class _BookState extends State<BookPages> {
  final GetController _getController = Get.put(GetController());
  String data = '''''';
  TextEditingController textEditingController = TextEditingController();

  EBookController eBookController = EBookController();
  BookController bookController = BookController();

  @override
  void initState() {
    rootBundle.loadString('assets/ok.txt').then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    eBookController.changFontSize(_getController.fontSize.value);
    _getController.whileApi.value = true;
    rootBundle.loadString('assets/ok.txt').then((value) {
      setState(() {
        data = value;
      });
    });

    return Scaffold(
      backgroundColor: _getController.backgroundColor.value,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.06),
          child: AppBar(
              backgroundColor: AppColors.blackTransparent,
              surfaceTintColor: AppColors.blackTransparent,
              title: Obx(() => TextLarge(text: widget.title, color: _getController.textColor.value, fontWeight: FontWeight.w400)),
              centerTitle: false,
              leading: IconButton(icon: Icon(Icons.arrow_back,color: _getController.textColor.value), onPressed: () => Get.back()),
              actions: [
                PopupMenuButton<String>(
                    icon: Icon(TablerIcons.settings, size: Theme.of(context).iconTheme.fill, color: _getController.textColor.value),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
                    color: Theme.of(context).colorScheme.surface,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Theme.of(context).colorScheme.onSurface,
                    elevation: 4,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                            height: Get.height * 0.03,
                            value: 'fontSize',
                            child: Obx(() => Row(
                                children: [
                                  Icon(Icons.format_size, color: _getController.textColor.value),
                                  Text(' ${_getController.fontSize.value.toString().split('.').first} px', style: TextStyle(color: _getController.textColor.value)),
                                  Expanded(child: Slider(
                                      value: _getController.fontSize.value,
                                      activeColor: AppColors.grey,
                                      inactiveColor: AppColors.grey.withOpacity(0.5),
                                      onChanged: (value) {
                                        eBookController.changFontSize(value);
                                        _getController.fontSize.value = value;
                                      },
                                      min: 10, max: 30
                                  ))
                                ]
                            ))
                        ),
                        const PopupMenuItem(
                            height: 0,
                            padding: EdgeInsets.all(0),
                            value: 'watcher',
                            child: Divider()
                        ),
                        PopupMenuItem(
                            height: Get.height * 0.03,
                            value: 'backgroundColor',
                            child:Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _getController.backgroundColor.value = AppColors.white;
                                      _getController.textColor.value = AppColors.black;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      minimumSize: const Size(40, 40),
                                      maximumSize: const Size(40, 40),
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                          color: AppColors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    child: const Text('', style: TextStyle(color: AppColors.black)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _getController.backgroundColor.value =
                                          AppColors.trueToneColor;
                                      _getController.textColor.value =
                                          AppColors.black;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.trueToneColor,
                                      minimumSize: const Size(40, 40),
                                      maximumSize: const Size(40, 40),
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                          color: AppColors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    child: const Text('',
                                        style:
                                        TextStyle(color: AppColors.black)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _getController.backgroundColor.value =
                                          AppColors.grey;
                                      _getController.textColor.value =
                                          AppColors.black;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.grey,
                                      minimumSize: const Size(40, 40),
                                      maximumSize: const Size(40, 40),
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                          color: AppColors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    child: const Text('',
                                        style:
                                        TextStyle(color: AppColors.black)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _getController.backgroundColor.value =
                                          AppColors.midnightBlack;
                                      _getController.textColor.value =
                                          AppColors.grey;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.midnightBlack,
                                      minimumSize: const Size(40, 40),
                                      maximumSize: const Size(40, 40),
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                          color: AppColors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    child: const Text('',
                                        style:
                                        TextStyle(color: AppColors.black)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _getController.backgroundColor.value =
                                          AppColors.black;
                                      _getController.textColor.value =
                                          AppColors.grey;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.black,
                                      minimumSize: const Size(40, 40),
                                      maximumSize: const Size(40, 40),
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                          color: AppColors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    child: const Text('',
                                        style:
                                        TextStyle(color: AppColors.black)),
                                  )
                                ])
                        ),
                        const PopupMenuItem(
                            height: 0,
                            padding: EdgeInsets.all(0),
                            value: 'watcher',
                            child: Divider()),
                        PopupMenuItem(
                            height: 0,
                            padding: const EdgeInsets.all(0),
                            value: 'switch',
                            child: Obx(() => Padding(
                                padding: EdgeInsets.only(
                                    left: 20.w, right: 20.w),
                                child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextSmall(
                                          text: 'Vertical',
                                          color: _getController
                                              .textColor.value,
                                          fontWeight: FontWeight.w400),
                                      CupertinoSwitch(
                                        value:
                                        _getController.isVertical.value,
                                        onChanged: (value) {
                                          _getController.isVertical.value =
                                              value;
                                        },
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ]))))
                      ];
                    })
              ]
          )
        ),
        body: data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Container(
          margin: const EdgeInsets.only(bottom: 0, top: 0),
          child: EBook(
            //maxWidth: MediaQuery.of(context).size.width,
              maxWidth: Get.width,
              eBookController: eBookController,
              bookController: bookController,
              duration: const Duration(milliseconds: 400),
              fontHeight: 1.6,
              data: data,
              fontSize: eBookController.fontSize,
              padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
              maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQueryData.fromView(window).padding.top - 5
          )
        )
    );
  }
}