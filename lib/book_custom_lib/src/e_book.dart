import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_small.dart';
import 'package:ildiz/resource/colors.dart';
import '../../controllers/get_controller.dart';
import 'book_controller.dart';
import 'book_fx.dart';
import 'ebook_controller.dart';
import 'utils/text.dart';

class EBook extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final String data;
  final double fontSize;
  final double fontHeight;
  final EdgeInsetsGeometry padding;
  final EBookController? eBookController;
  final BookController bookController;
  final Duration? duration;

  const EBook({super.key, required this.maxWidth, required this.data, required this.maxHeight, this.fontSize = 16.0, this.padding = const EdgeInsetsDirectional.all(20), this.eBookController, required this.bookController, this.fontHeight = 1.4, this.duration});

  @override
  State<EBook> createState() => _EBookState();
}

class _EBookState extends State<EBook> {
  final GetController _getController = Get.put(GetController());

  String data = "";
  double textHeight = 10;
  double maxTextHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data = widget.data.replaceAll('\r\n', '\n');
      textHeight = TextUtil.calculateTextHeight(
        'La-la-la...',
        widget.fontSize,
        fontHeight: widget.fontHeight,
        maxWidth: widget.maxWidth,
        padding: widget.padding
      );
      maxTextHeight = (widget.maxHeight - widget.padding.vertical) ~/ textHeight * textHeight;
      _getController.startLoadingPages(data, widget.fontSize, widget.fontHeight, widget.maxWidth, widget.padding, maxTextHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _getController.whileApi.value = false;
        if (didPop) return;
        Get.back();
      },
      child: Obx(() {
        if (!_getController.isOver.value) {
          return const CupertinoActivityIndicator();
        }
        //final maxLines = (maxTextHeight ~/ textHeight).clamp(1, double.infinity).toInt();
        final maxLines = (maxTextHeight ~/ textHeight).clamp(1, Get.height).toInt();
        if (!_getController.isVertical.value) {
          return BookFx(
              size: Size(MediaQuery.of(context).size.width, widget.maxHeight),
              //size: Size(Get.width, Get.height),
              pageCount: _getController.allPages.length - 1,
              currentBgColor: _getController.backgroundColor.value,
              nextCallBack: (index) => _getController.setCurrentIndex(index),
              lastCallBack: (index) => _getController.setCurrentIndex(index),
              duration: widget.duration,
              nextPage: (index) =>index >= _getController.allPages.length - 1 && maxTextHeight == 0 && textHeight == 0
                  ? const SizedBox()
                  : Stack(children: [
                    Container(
                        width: Get.width,
                        height: Get.height,
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: widget.padding,
                        color: _getController.backgroundColor.value,
                        child: Text(
                            data.isNotEmpty ? data.substring(_getController.allPages[index], _getController.allPages[index + 1]) : "",
                            maxLines: maxLines,
                            strutStyle: StrutStyle(forceStrutHeight: true, height: widget.fontHeight, fontSize: widget.fontSize),
                            style: TextStyle(height: widget.fontHeight, fontSize: widget.fontSize, color: _getController.textColor.value)
                        )
                    ),
                    Positioned(
                        width: Get.width,
                        bottom: 0,
                        child: SizedBox(width: Get.width, child: Center(child: TextSmall(text: "${index + 1}",color: _getController.textColor.value, textAlign: TextAlign.center, fontSize: _getController.fontSize.value)))
                    )
                  ]
              ),
              currentPage: (int index) => _getController.whileApi.value && maxTextHeight != 0 && textHeight != 0
                ? Stack(children: [
                  Container(
                      width: Get.width,
                      height: Get.height,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: widget.padding,
                      color: _getController.backgroundColor.value,
                      child: Text(
                          data.isNotEmpty ? data.substring(_getController.allPages[index], _getController.allPages[index + 1]) : "",
                          maxLines: maxLines,
                          strutStyle: StrutStyle(forceStrutHeight: true, height: widget.fontHeight, fontSize: widget.fontSize),
                          style: TextStyle(height: widget.fontHeight, fontSize: widget.fontSize, color: _getController.textColor.value)
                      )
                  ),
                  Positioned(
                      width: Get.width,
                      bottom: 0,
                      child: SizedBox(
                          width: Get.width,
                          child: Center(child: TextSmall(text: "${index + 1}",color: _getController.textColor.value, textAlign: TextAlign.center, fontSize: _getController.fontSize.value))
                      )
                  )])
                  : const CupertinoActivityIndicator(),
                controller: widget.bookController
          );
        } else {
          return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: _getController.scrollController,
              child: Column(
                  children: [
                    for (int index = 0; index < _getController.allPages.length - 1; index++)
                      Container(
                          width: Get.width,
                          padding: widget.padding,
                          decoration: BoxDecoration(border: Border.all(color: AppColors.grey), color: _getController.backgroundColor.value),
                          child: Column(
                              children: [
                                Text(
                                    data.isNotEmpty ? data.substring(_getController.allPages[index], _getController.allPages[index + 1]) : "",
                                    strutStyle: StrutStyle(forceStrutHeight: true, height: widget.fontHeight, fontSize: widget.fontSize),
                                    style: TextStyle(height: widget.fontHeight, fontSize: widget.fontSize, color: _getController.textColor.value)
                                ),
                                SizedBox(height: 5.h),
                                SizedBox(width: Get.width, child: Center(child: TextSmall(text: "${index + 1}",color: _getController.textColor.value, textAlign: TextAlign.center, fontSize: _getController.fontSize.value)))
                              ]
                          )
                      )
                  ]
              )
          );
        }
      })
    );
  }
}
