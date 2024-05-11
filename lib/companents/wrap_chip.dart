import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../models/menu_model.dart';
import '../resource/colors.dart';

class WrapChip extends StatelessWidget {
  List title;
  final Function(int) function;
  var select;
  bool more;
  var icon;
  final GetController _getController = Get.put(GetController());

  WrapChip({super.key, required this.title, required this.function, required this.select, this.more = false, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: EdgeInsets.only(
            left: Get.width * 0.03,
            right: Get.width * 0.01,
            top: Get.height * 0.02,
            bottom: Get.height * 0.02
        ),
        child: Wrap(
            spacing: Get.width * 0.02,
            runSpacing: Get.height * 0.006,
            children: [
              for (var i in title)
                InkWell(
                    onTap: () {
                      function(title.indexOf(i));
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Chip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        label: Text(i, style: TextStyle(color: title.indexOf(i) == select ? AppColors.white : Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                        labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        deleteIcon: title.indexOf(i) == select && icon != null ? Icon(icon, color: title.indexOf(i) == select ? AppColors.white : Theme.of(context).colorScheme.onBackground, size: 17.sp) : null,
                        deleteIconColor: title.indexOf(i) == select ? Theme.of(context).colorScheme.onBackground : null,
                        deleteButtonTooltipMessage: title.indexOf(i) == select ? 'Selected' : null,
                        onDeleted: title.indexOf(i) == select && icon != null ? () {
                          function(title.indexOf(i));
                        } : null,
                        backgroundColor: select != null ? title.indexOf(i) == select ? AppColors.primaryColor : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2) : Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                    )
                ),
              if (more)
                InkWell(
                    onTap: () {},
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Chip(
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        label: Text('Ko\'proq', style: TextStyle(color: AppColors.white, fontSize: 17.sp, fontWeight: FontWeight.w400)),
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.01, vertical: Get.height * 0.008),
                        deleteIcon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.white, size: 25.sp),
                        deleteIconColor: AppColors.white,
                        deleteButtonTooltipMessage: 'Selected',
                        onDeleted: () {},
                        labelPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        backgroundColor: AppColors.primaryColor,
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                    )
                )
            ]
        )
    );
  }
}