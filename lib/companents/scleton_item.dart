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
            width: 190.sp,
            height: 330.sp,
            margin: EdgeInsets.only(right: 12.sp,left: 12.sp),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: AppColors.grey.withOpacity(0.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 185.sp,
                    height: 190.sp,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColors.grey.withOpacity(0.2))
                ),
                Row(
                  children: [
                    Expanded(child: Text('Muvaffaqiyatli'.tr)),
                    Icon(Icons.ice_skating, size: 10.sp),
                    SizedBox(width: 5.sp),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.ice_skating, size: 10.sp),
                    SizedBox(width: 5.sp),
                    Expanded(child: Text('Muvaffaqiyatli'.tr))
                  ],
                ),
                Container(
                  width: _getController.width.value,
                  padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                  margin: EdgeInsets.only(right: 5.sp, left: 5.sp, top: 5.sp),
                  child: Text('Xatolik'.tr),
                ),
                SizedBox(height: 5.sp),
                Container(
                    margin: EdgeInsets.only(top: 2.sp, left:  2.sp, right:  2.sp, bottom:  2.sp),
                    height: 30.sp,
                    width: 180.sp,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text('Xarid'.tr,
                            style: TextStyle(fontSize: _getController.width.value * 0.04,
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