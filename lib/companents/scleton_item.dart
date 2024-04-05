import 'package:flutter/material.dart';
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
            width: _getController.width.value * 0.45,
            height: _getController.width.value * 0.5,
            margin: EdgeInsets.all(_getController.width.value * 0.02),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey.withOpacity(0.2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: _getController.width.value,
                    height: _getController.width.value * 0.35,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.grey.withOpacity(0.2))
                ),
                Row(
                  children: [
                    Expanded(child: Text('Muvaffaqiyatli'.tr)),
                    Icon(Icons.ice_skating, size: _getController.width.value * 0.04),
                    SizedBox(width: _getController.width.value * 0.02)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.ice_skating, size: _getController.width.value * 0.04),
                    SizedBox(width: _getController.width.value * 0.02),
                    Expanded(child: Text('Muvaffaqiyatli'.tr))
                  ],
                ),
                Container(
                  width: _getController.width.value,
                  padding: EdgeInsets.only(left: _getController.width.value * 0.02),
                  margin: EdgeInsets.only(right: _getController.width.value * 0.02),
                  child: Text('Xatolik'.tr),
                ),
                SizedBox(height: _getController.height.value * 0.01),
                Container(
                    margin: EdgeInsets.only(top: _getController.height.value * 0.01, left: _getController.width.value * 0.02, right: _getController.width.value * 0.02, bottom: _getController.height.value * 0.01),
                    height: _getController.height.value * 0.05,
                    width: _getController.width.value * 1.0,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text('Xarid'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w600))
                    )
                ),
              ],
            )
        )
    );
  }
}