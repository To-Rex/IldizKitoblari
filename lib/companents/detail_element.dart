

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_small.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class DetailElement extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  DetailElement({super.key, required this.title, required this.subTitle, required this.icon});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.sp),
      child: Row(
        children: <Widget>[
          Icon(icon, color: AppColors.primaryColor, size: Theme.of(context).iconTheme.fill),
          SizedBox(width: 2.sp),
          TextSmall(text: title, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w600),
          SizedBox(width: 2.sp),
          TextSmall(text: subTitle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.w600)
        ]
      )
    );
  }
}