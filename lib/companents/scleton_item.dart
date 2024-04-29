import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class SkeletonItem extends StatefulWidget {

  SkeletonItem({super.key});

  @override
  State<SkeletonItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<SkeletonItem> {
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: Container(
            width: 190.w,
            height: 330.h,
            margin: EdgeInsets.only(right: 12.w,left: 12.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: AppColors.grey.withOpacity(0.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 185.w,
                    height: 190.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColors.grey.withOpacity(0.2))
                ),
                Row(
                  children: [
                    Expanded(child: Text('Muvaffaqiyatli'.tr)),
                    Icon(Icons.ice_skating, size: 10.sp),
                    SizedBox(width: 5.w),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.ice_skating, size: 10.sp),
                    SizedBox(width: 5.w),
                    Expanded(child: Text('Muvaffaqiyatli'.tr))
                  ],
                ),
                Container(
                  width: _getController.width.value,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  margin: EdgeInsets.only(right: 5.w, left: 5.w, top: 5.h),
                  child: Text('Xatolik'.tr),
                ),
                SizedBox(height: 5.h),
                Container(
                    margin: EdgeInsets.only(top: 2.h, left:  2.w, right:  2.w, bottom:  2.h),
                    height: 30.h,
                    width: 180.h,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text('Xarid'.tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.background,
                                fontWeight: FontWeight.w600)
                        )
                    )
                ),
              ],
            )
        )
    );
  }
}