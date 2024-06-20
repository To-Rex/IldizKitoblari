import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:text_scroll/text_scroll.dart';

import '../controllers/get_controller.dart';

class BottomBarIcons extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;

  BottomBarIcons({super.key, required this.icon, required this.title,required this.isSelected});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _getController.width * 0.17,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                  icon,
                  width: 25.sp,
                  height: 25.sp,
                  colorFilter: isSelected ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : null
              ),
              SizedBox(height: 3.sp),
              Expanded(
                  child: TextScroll(
                      title,
                      fadedBorder: false,
                      //velocity: const Velocity(pixelsPerSecond: Offset(20, 0)),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: isSelected ? AppColors.primaryColor : AppColors.grey, fontSize: 14.sp, fontWeight: FontWeight.w500),
                      mode: TextScrollMode.endless,
                      pauseBetween: const Duration(milliseconds: 10000),
                      selectable: true,
                      delayBefore: const Duration(milliseconds: 10000))
              ),
            ]
        )
    );
    /*return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: SizedBox(
        width: _getController.width * 0.15,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                icon,
                width: 25.sp,
                height: 25.sp,
                colorFilter: isSelected ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : null
              ),
              SizedBox(height: 3.sp),
              Expanded(
                  child: TextScroll(
                      title,
                      fadedBorder: false,
                      velocity: const Velocity(pixelsPerSecond: Offset(20, 0)),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(color: isSelected ? AppColors.primaryColor : AppColors.grey, fontSize: _getController.width * 0.035, fontWeight: FontWeight.w500),
                      mode: TextScrollMode.endless,
                      pauseBetween: const Duration(milliseconds: 10000),
                      selectable: true,
                      delayBefore: const Duration(milliseconds: 10000))
              ),
            ]
        )
      )
    );*/
  }
}
