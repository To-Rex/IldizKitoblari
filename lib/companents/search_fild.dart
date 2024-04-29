import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class SearchFields extends StatelessWidget {
  final Function(String) onChanged;
  SearchFields({super.key, required this.onChanged});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 47.sp, left: 15.sp, right: 15.sp),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52.sp,
              padding: EdgeInsets.only(right: 5.sp),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(13)),
              child: TextField(
                controller: _getController.searchController,
                onChanged: onChanged,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                  hintText: 'Kitoblarni izlash'.tr,
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), fontSize: 18.sp),
                  prefixIcon: Padding(padding: EdgeInsets.all(12.sp), child: SvgPicture.asset('assets/icon/search.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface.withOpacity(0.6), BlendMode.srcIn))),
                  border: InputBorder.none
                )
              )
            )
          ),
          SizedBox(width: 10.sp),
          Container(
            height: 52.sp,
            width: 52.sp,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background.withOpacity(0.2),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Theme.of(context).colorScheme.background.withOpacity(0.2))
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icon/bell.svg',
                height: 25.sp,
                width: 25.sp,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn)
              )
            )
          )
        ]
      )
    );
  }
}