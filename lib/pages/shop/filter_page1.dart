import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/get_controller.dart';

class FilterPage1 extends StatelessWidget{
  int menuIndex;
  FilterPage1({super.key, required this.menuIndex});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    var optionId ;
    if (_getController.menuModel.value.data!.result![menuIndex].children != null) {
      _getController.clearMenuOptionsModelList();
      /*ApiController().getMenuDetail('${_getController.menuModel.value.data!.result![menuIndex].children?[0].slug}').then((value) => {
        *//*for (int i = 0; i < _getController.menuDetailModel.value.data!.options!.length; i++) {
          if (_getController.menuDetailModel.value.data!.options![i].optionId != null) {
            //ApiController().getMenuOptions(page, optionId, slug, limit, add)
            ApiController().getMenuOptions(
                1,
                _getController.menuDetailModel.value.data!.options![i].optionId?.sId,
                _getController.menuModel.value.data!.result![menuIndex].children![i].slug,
                10,
                true
            ).then((value) => {
              print('menuOptions: ${_getController.menuOptionsModelList.length}')
            })
          }
        }*/
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
        body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: CustomHeader(
          builder: (BuildContext context, RefreshStatus? mode) {
            Widget body;
            if (mode == RefreshStatus.idle) {
              body = const Text("Ma`lumotlarni yangilash uchun tashlang");
            } else if (mode == RefreshStatus.refreshing) {
              body = const CircularProgressIndicator(
                color: Colors.blue,
                backgroundColor: Colors.white,
                strokeWidth: 2,
              );
            } else if (mode == RefreshStatus.failed) {
              body = const Text("Ex nimadir xato ketdi",
                  style: TextStyle(fontSize: 14, color: Colors.red));
            } else if (mode == RefreshStatus.canRefresh) {
              body = const Text("Ma`lumotlarni yangilash uchun tashlang");
            } else {
              body = const Text("Ma`lumotlar yangilandi");
            }
            return SizedBox(
              height: _getController.height.value * 0.1,
              child: Center(child: body),
            );
          },
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const SizedBox();
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
            } else if (mode == LoadStatus.failed) {
              body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
            } else if (mode == LoadStatus.canLoading) {
              body = const SizedBox();
            } else {
              body = const Text("Ma`lumotlar yangilandi", style: TextStyle(fontSize: 14, color: Colors.black));
            }
            return SizedBox(
              height: _getController.height.value * 0.1,
              child: Center(child: body),
            );
          },
        ),
        onLoading: () async {_refreshController.loadComplete();},
        onRefresh: () async {_refreshController.refreshCompleted();},
        controller: _refreshController,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => Column(
                children: [
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04, top: _getController.width.value * 0.04),
                      child: Text('Janrlar', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500))
                  ),
                  Container(margin: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04)),
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
                      margin: EdgeInsets.only(top: _getController.width.value * 0.04,left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                      child: Divider(height: 1, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2))
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
                  Container(
                      margin: EdgeInsets.only(top: _getController.width.value * 0.04,bottom: _getController.width.value * 0.02,left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                      child: Divider(height: 1, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2))
                  ),
                  if (_getController.menuModel.value.data != null && _getController.menuDetailModel.value.data != null && _getController.menuOptionsModelList.isNotEmpty)
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
                    //for (var i in _getController.menuDetailModel.value.data!.options!)
                    for (var i = 0; i < _getController.menuDetailModel.value.data!.options!.length; i++)
                      Column(
                          children: [
                            //if (_getController.menuOptionsModelList[i].data != null)
                            if (_getController.menuDetailModel.value.data!.options != null && _getController.menuOptionsModelList[i].data != null)
                            Container(
                                width: _getController.width.value,
                                padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
                                child: Text(
                                'uz_UZ' == Get.locale.toString() ? _getController.menuDetailModel.value.data!.options != null? _getController.menuDetailModel.value.data!.options![i].optionId!.name!.uz! : 'oz_OZ' == Get.locale.toString() ? _getController.menuDetailModel.value.data!.options![i].optionId!.name!.oz! : 'ru_RU' == Get.locale.toString() ? _getController.menuDetailModel.value.data!.options![i].optionId!.name!.ru! : '' : '',
                                style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 20.sp, fontWeight: FontWeight.w500),
                                )
                            ),
                            if (_getController.menuOptionsModelList[i].data != null)
                              Container(
                                width: _getController.width.value,
                                padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01, top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.01),
                                child: Wrap(
                                    spacing: _getController.width.value * 0.02,
                                    runSpacing: _getController.height.value * 0.006,
                                    children: [
                                      for (int index = 0; index < _getController.menuOptionsModelList[i].data!.result!.length; index++)
                                        InkWell(
                                            onTap: () {},
                                            child: Chip(
                                              visualDensity: VisualDensity.compact,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                              //label: Text('uz_UZ' == Get.locale.toString() ? i.optionId!.name!.uz! : 'oz_OZ' == Get.locale.toString() ? i.optionId!.name!.oz! : i.optionId!.name!.ru!),
                                              label: Text(_getController.menuOptionsModelList[i].data!.result![index].name!.uz!),
                                              padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01, vertical: _getController.height.value * 0.008),
                                              labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02),
                                              side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                                              backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 16.sp, fontWeight: FontWeight.w400),
                                            )
                                        )
                                    ]
                                )
                            )
                          ]
                      )
                ]
            ))
        )
    )
    );
  }
}