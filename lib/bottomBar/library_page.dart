import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.tabController = TabController(length: 2, vsync: Navigator.of(context) as TickerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: _getController.height.value,
          width: _getController.width.value,
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                      height: 177.h,
                      width: _getController.width.value,
                      child: Stack(
                          children: [
                            Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg',fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                            Positioned(
                                height: 200.h,
                                top: 58.w,
                                left: 15.sp,
                                child: Text('Kutubxona'.tr, style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 27.sp, fontWeight: FontWeight.bold))
                            ),
                            Positioned(
                                top: 61.h, left: 0, right: 0,
                                child: SearchFields(onChanged: (String value) {})
                            )
                          ]
                      )
                  ),
                  Container(
                      width: _getController.width.value,
                      padding: EdgeInsets.only(top: _getController.height.value * 0.01),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                      child: Column(
                          children: [
                            Container(
                                width: Get.width,
                                height: Get.height * 0.055,
                                margin: EdgeInsets.only(top: Get.height * 0.01),
                                decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                                child: Container(
                                    constraints: BoxConstraints.expand(height: Get.height * 0.06),
                                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                                    padding: EdgeInsets.all(Get.width * 0.01),
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                                    child: TabBar(
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        dividerColor: Colors.transparent,
                                        controller: _getController.tabController,
                                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18.sp, fontWeight: FontWeight.w500),
                                        unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                        indicator: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(11), boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.surface.withOpacity(0.1), spreadRadius: 2, blurRadius: 2, offset: const Offset(0, 2))]),
                                        tabs: [
                                          Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Elektron kitoblar'.tr)))),
                                          Tab(child: SizedBox(width: Get.width * 0.6, child: Center(child: Text('Audio kitoblar'.tr))))
                                        ]
                                    )
                                )
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: _getController.height.value * 0.2),
                                  Text('Savat bo‘sh'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: _getController.height.value * 0.01),
                                  SizedBox(width: _getController.width.value * 0.65, child: Text('Savatga mahsulotlarni qo‘shish uchun xarid qilishni boshlang.'.tr, textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400))),
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
                                              child: Text('Xaridni boshlash'.tr, style: TextStyle(color: Colors.white, fontSize: 16.sp))
                                          )
                                      )
                                  )
                                ]
                            )
                          ]
                      )
                  )
                ]
              )
            )
        )
      )
    );
  }
}
