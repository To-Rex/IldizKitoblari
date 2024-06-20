import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../companents/basket/list_shop.dart';
import '../controllers/get_controller.dart';
import '../pages/order/order_cauntry_page.dart';
import '../resource/colors.dart';

class BasketPage extends StatelessWidget {
  BasketPage({super.key});
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    _getController.tabController = TabController(length: 2, vsync: Navigator.of(context));
    ApiController().getBasket().then((value) => {
      _getController.allCheckBoxCard.value = true,
      _getController.changeAllCheckBoxCardList()
    });
    return Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: CustomHeader(
            builder: (BuildContext context, RefreshStatus? mode) {
              Widget body;
              if (mode == RefreshStatus.idle) {
                body = const Text("Ma`lumotlarni yangilash uchun tashlang");
              } else if (mode == RefreshStatus.refreshing) {
                body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
              } else if (mode == RefreshStatus.failed) {
                body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
              } else if (mode == RefreshStatus.canRefresh) {
                body = const Text("Ma`lumotlarni yangilash uchun tashlang");
              } else {
                body = const Text("Ma`lumotlar yangilandi");
              }
              return SizedBox(height: _getController.height.value * 0.1, child: Center(child: body),);
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
          onLoading: () async {
            //_getController.clearBasketModel();
            _refreshController.loadComplete();},
          onRefresh: () async {
            _getController.clearBasketModel();
            ApiController().getBasket().then((value) => {
              _getController.allCheckBoxCard.value = true,
              _getController.changeAllCheckBoxCardList(),
              _refreshController.refreshCompleted()
            });
          },
          controller: _refreshController,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                  width: _getController.width.value,
                  decoration: const BoxDecoration(color: AppColors.backgroundApp),
                  child: Obx(() => Column(
                      children: [
                        SizedBox(
                            height: 112.h,
                            width: double.infinity,
                            child: Stack(
                                children: [
                                  Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                                  Positioned(
                                      height: _getController.height.value * 0.2,
                                      top: 60.h,
                                      left: _getController.width.value * 0.03,
                                      child: Text('Savatcha'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 27.sp, fontWeight: FontWeight.bold)))
                                ]
                            )
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                            child: Column(
                                children: [
                                  Container(
                                      width: Get.width,
                                      height: Get.height * 0.051,
                                      margin: EdgeInsets.only(top: 16.h),
                                      child: Container(
                                          constraints: BoxConstraints.expand(height:  Get.height * 0.06),
                                          margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                                          padding: EdgeInsets.all(5.sp),
                                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), borderRadius: BorderRadius.circular(11.r)),
                                          child: TabBar(
                                              indicatorSize: TabBarIndicatorSize.tab,
                                              dividerColor: Colors.transparent,
                                              controller: _getController.tabController,
                                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                              unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                              indicator: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(9.r), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(0.1), spreadRadius: 2, blurRadius: 2, offset: const Offset(0, 2))]),
                                              tabs: [
                                                Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Do‘kon'.tr)))),
                                                Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Kutubxona'.tr))))
                                              ]
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: _getController.calculateTotalHeight(),
                                    child: TabBarView(
                                        controller: _getController.tabController,
                                        children: [
                                          if (_getController.basketModel.value.data?.result?.isNotEmpty == true)
                                            ListShop()
                                          else
                                            Center(child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Savat bo‘sh'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                                SizedBox(height: _getController.height.value * 0.01),
                                                SizedBox(
                                                  width: _getController.width.value * 0.65,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                      'Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.'.tr, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))
                                                ),
                                                SizedBox(height: _getController.height.value * 0.01),
                                                SizedBox(
                                                  width: _getController.width.value * 0.5,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors.primaryColor,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                                                    ),
                                                    onPressed: () {
                                                      _getController.index.value = 1;
                                                    },
                                                    child: Center(
                                                      child: Text('Xaridni boshlash'.tr, style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.sp)
                                                      )
                                                    )
                                                  )
                                                )
                                              ],
                                            )),
                                          Center(child: Text('Ma‘lumotlar yo‘q!'.tr))
                                        ]
                                    )
                                  )
                                ]
                            )
                        )
                      ]
                  ))
              )
          )
        ),
        bottomNavigationBar: Obx(() => _getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty && _getController.checkBoxCardList.contains(true)
            ? BottomAppBar(
            height: 85.h,
            surfaceTintColor: Theme.of(context).colorScheme.onSecondary,
            elevation: 20,
            shadowColor: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.background,
            child: Obx(() => Container(
                margin: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Jami miqdor:'.tr, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                                Text('${_getController.getPriceModel.value.data?.totalPrice} ''${'so‘m'.tr}', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface))
                              ]
                          )
                      ),
                      SizedBox(
                          width: _getController.width.value * 0.38,
                          height: _getController.height.value * 0.055,
                          child: ElevatedButton(
                              onPressed: () {
                                ApiController().orderCreate();
                                Get.to(() => OrderCountryPage(), transition: Transition.native);
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              child: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface))
                          )
                      )
                    ]
                )
            ))
        ) : const SizedBox())
    );
  }
}