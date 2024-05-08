import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../resource/colors.dart';

class WrapChip extends StatelessWidget {
  List title;

  WrapChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.01),
        child: Wrap(
            spacing: Get.width * 0.02,
            runSpacing: Get.height * 0.006,
            children: [
              /*for (var i in _getController.menuModel.value.data!.result![menuIndex].children!)
                InkWell(
                    onTap: () {},
                    child: Chip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
                        padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01, vertical: _getController.height.value * 0.008),
                        labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02),
                        side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                    )
                )*/
              for (var i in title)
                InkWell(
                    onTap: () {},
                    child: Chip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        label: Text(i),
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                        labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                    )
                )
            ]
        )
    );
  }
}