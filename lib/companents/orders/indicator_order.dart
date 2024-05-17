import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';

class IndicatorOrder extends StatelessWidget {
  final int index;
  const IndicatorOrder({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: Get.width * 0.28,
                height: Get.width * 0.012,
                decoration: BoxDecoration(color: index == 0 ? AppColors.primaryColor3 : index == 1 || index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2, borderRadius: BorderRadius.circular(10.r))
              ),
              Container(
                width: Get.width * 0.28,
                margin: EdgeInsets.only(top: 5.sp),
                child: Text('Yetkazib berish manzili'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: index == 0 ? AppColors.primaryColor3 : index == 1 || index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2), textAlign: TextAlign.left)
              )
            ]
          ),
          Column(
            children: [
              Container(
                width: Get.width * 0.28,
                height: Get.width * 0.012,
                decoration: BoxDecoration(color: index == 1 ? AppColors.primaryColor3 : index == 0 ? AppColors.grey : index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2, borderRadius: BorderRadius.circular(10.r))
              ),
              Container(
                width: Get.width * 0.28,
                margin: EdgeInsets.only(top: 5.sp),
                child: Text('To‘lov turi'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: index == 1 ? AppColors.primaryColor3 : index == 0 ? AppColors.grey : index == 2 ? AppColors.primaryColor2 : AppColors.primaryColor2), textAlign: TextAlign.left)
              )
            ]
          ),
          Column(
            children: [
              Container(
                width: Get.width * 0.28,
                height: Get.width * 0.012,
                decoration: BoxDecoration(color: index == 2 ? AppColors.primaryColor3 : index == 0 || index == 1 ? AppColors.grey : AppColors.primaryColor2, borderRadius: BorderRadius.circular(10.r))
              ),
              Container(
                width: Get.width * 0.28,
                margin: EdgeInsets.only(top: 5.sp),
                child: Text('Buyurtmani tasdiqlash'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: index == 2 ? AppColors.primaryColor3 : index == 0 || index == 1 ? AppColors.grey : AppColors.primaryColor2), textAlign: TextAlign.left)
              )
            ]
          )
        ]
      )
    );
  }
}