import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
              child: TextField(
                controller: _getController.searchController,
                onChanged: onChanged,
                textInputAction: TextInputAction.search,
                onSubmitted: (onChanged),
                decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(13)),
                    fillColor: Theme.of(context).colorScheme.surface,
                    hintText: 'Kitoblarni izlash'.tr,
                    hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), fontSize: 18.sp),
                    prefixIcon: Padding(padding: EdgeInsets.all(12.sp), child: SvgPicture.asset('assets/icon/search.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface.withOpacity(0.6), BlendMode.srcIn))),
                    suffixIcon: _getController.searchController.text.isNotEmpty ? IconButton(
                      onPressed: () {
                        _getController.searchController.clear();
                        onChanged('');
                        },
                      icon: Icon(TablerIcons.x, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), size: 15.sp),
                    ) : const SizedBox(height: 0, width: 0)
                )
              )
            )
          ),
          SizedBox(width: 10.sp),
          Container(
            height: 52.sp,
            width: 52.sp,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Theme.of(context).colorScheme.surface.withOpacity(0.2))
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