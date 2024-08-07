import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class SkeletonItem extends StatefulWidget {

  const SkeletonItem({super.key});

  @override
  State<SkeletonItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<SkeletonItem> {
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: Container(
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: AppColors.grey.withOpacity(0.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: Get.width, height: 195.sp,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColors.grey.withOpacity(0.2))
                ),
                Row(
                  children: [
                    SizedBox(width: Get.width * 0.01),
                    Expanded(child: Text('Muvaffaqiyatli'.tr)),
                    Icon(Icons.ice_skating, size: 10.sp),
                    SizedBox(width: Get.width * 0.01),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: Get.width * 0.01),
                    Icon(Icons.ice_skating, size: 10.sp),
                    SizedBox(width: Get.width * 0.01),
                    Expanded(child: Text('Muvaffaqiyatli'.tr))
                  ],
                ),
                Container(
                  width: _getController.width.value,
                  padding: EdgeInsets.only(left: Get.width * 0.01, right:Get.width * 0.01),
                  margin: EdgeInsets.only(right: Get.width * 0.01, left: Get.width * 0.01, top: Get.height * 0.01),
                  child: Text('Xatolik'.tr),
                ),
                SizedBox(height: 5.h),
                Container(
                    margin: EdgeInsets.only(top: Get.height * 0.01, left:  Get.width * 0.01, right:  Get.width * 0.01),
                    height: 30.sp,
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text('Xarid'.tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.w600)
                        )
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top: Get.height * 0.01, left:  Get.width * 0.01, right:  Get.width * 0.01,bottom: Get.height * 0.01),
                    height: 30.sp,
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text('Savatga qo‘shish'.tr,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.w600)
                        )
                    )
                )
              ]
            )
        )
    );
  }
}