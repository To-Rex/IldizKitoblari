import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';

import '../../controllers/get_controller.dart';

class FilterPage extends StatelessWidget{
  int menuIndex;
  FilterPage({super.key, required this.menuIndex});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    if (_getController.menuModel.value.data!.result![menuIndex].children == null) {
      ApiController().getMenuDetail('${_getController.menuModel.value.data!.result![menuIndex].slug}');
    }else {
      ApiController().getMenuDetail('${_getController.menuModel.value.data!.result![menuIndex].children?[0].slug}');
    }
    return Scaffold(
        appBar: AppBar(
            title: Text('Filter'.tr, style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
              onPressed: () {
                Get.back();
              }
            ),
          actions: [
            Text('Filterlarni o\'chirish'.tr, style: TextStyle(color: AppColors.red, fontSize: 18.sp, fontWeight: FontWeight.w500)),
            SizedBox(width: 10.sp)
          ]
        ),
      body: Obx(() => Column(
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04, top: _getController.width.value * 0.04),
              child: Text('Janrlar', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500))
          ),
          Container(
            margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04)
          ),
          if (_getController.menuModel.value.data != null)
            Container(
                width: _getController.width.value,
                padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
                child: Wrap(
                    spacing: _getController.width.value * 0.02,
                    runSpacing: _getController.height.value * 0.006,
                    children: [
                      for (var i in _getController.menuModel.value.data!.result![menuIndex].children!)
                        InkWell(
                            onTap: () {},
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                              label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
                              padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01, vertical: _getController.height.value * 0.008),
                              labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02),
                              side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                              backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400),
                            )
                        )
                    ]
                )
            ),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04, top: _getController.width.value * 0.04,bottom: _getController.width.value * 0.01),
              child: Text('Narx', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500))
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02, vertical: _getController.height.value * 0.008),
                        hintText: '0 dan'.tr,
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400),
                      )
                    )
                  )
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                      child: TextField(
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02, vertical: _getController.height.value * 0.008),
                            hintText: '0 gacha'.tr,
                            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400),
                          )
                      )
                  )
              ),
            ]
          ),
          SizedBox(height: _getController.height.value * 0.01),
          if (_getController.menuModel.value.data != null && _getController.menuDetailModel.value.data != null)
            /*Container(
                width: _getController.width.value,
                padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
                child: Wrap(
                    spacing: _getController.width.value * 0.02,
                    runSpacing: _getController.height.value * 0.006,
                    children: [
                      for (var i in _getController.menuDetailModel.value.data!.options!)
                        InkWell(
                            onTap: () {},
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                              label: Text('uz_UZ' == Get.locale.toString() ? i.optionId!.name!.uz! : 'oz_OZ' == Get.locale.toString() ? i.optionId!.name!.oz! : i.optionId!.name!.ru!),
                              padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01, vertical: _getController.height.value * 0.008),
                              labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02),
                              side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                              backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400),
                            )
                        )
                    ]
                )
            ),*/
            for (var i in _getController.menuDetailModel.value.data!.options!)
              Container(
                width: _getController.width.value,
                padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
                child: Text('uz_UZ' == Get.locale.toString() ? i.optionId!.name!.uz! : 'oz_OZ' == Get.locale.toString() ? i.optionId!.name!.oz! : i.optionId!.name!.ru!, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400)
                )
              )
        ]
      ))
    );
  }
}