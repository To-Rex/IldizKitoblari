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
          child: Obx(() => Stack(
            fit: StackFit.loose,
            children: [
              Positioned(
                height: _getController.height.value * 0.24, top: 0, left: 0, right: 0,
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/svgImages/shap.svg',
                    fit: BoxFit.fitWidth,
                    width: _getController.width.value,
                    height: _getController.height.value * 0.3
                  )
                )
              ),
              Positioned(
                height: _getController.height.value * 0.2,
                top: _getController.height.value * 0.062,
                left: _getController.width.value * 0.03,
                child: Text(
                  'Kutubxona'.tr,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: _getController.width.value * 0.061,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
              Positioned(
                height: _getController.height.value * 0.2,
                top: _getController.height.value * 0.015,
                left: 0,
                right: 0,
                child: SearchFields(
                  onChanged: (String value) {
                    // Implement your search logic here
                  }
                )
              ),
              Positioned(
                width: _getController.width.value,
                top: _getController.height.value * 0.19,
                bottom: 0,
                child: Container(
                  width: _getController.width.value,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)
                    )
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * 0.055,
                        margin: EdgeInsets.only(top: Get.height * 0.02),
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
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                        )
                      )
                    ]
                  )
                )
              )
            ]
          ))
        )
      )
    );
  }
}
