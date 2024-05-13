import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../companents/acc_item.dart';
import '../companents/child_item.dart';
import '../companents/product_item.dart';
import '../companents/scleton_item.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';
import '../pages/home/cat_detail_page.dart';
import '../pages/home/detail_page.dart';
import '../pages/profile/edit_user.dart';
import '../resource/colors.dart';

class BasketPage extends StatelessWidget {
  BasketPage({super.key});
  final GetController _getController = Get.put(GetController());


  void _getData() {

  }

  void _onLoading() async {

  }
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              height: _getController.height.value,
              width: _getController.width.value,
              child: Obx(() => Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          child: SvgPicture.asset('assets/svgImages/shap.svg',
                              fit: BoxFit.fitWidth,
                              height: _getController.height.value * 0.2),
                        )),
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: _getController.height.value * 0.06,
                        left: _getController.width.value * 0.03,
                        child: Text('Savatcha'.tr,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: _getController.width.value * 0.06,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Positioned(
                        width: _getController.width.value,
                        top: _getController.height.value * 0.12,
                        bottom: 0,
                        child: Container(
                            width: _getController.width.value,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              children: [
                              ],
                            )
                        )
                    )
                  ]
              ))
          ),
        )
    );*/

    return Scaffold(
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                width: _getController.width.value,
                decoration: const BoxDecoration(color: AppColors.backgroundApp),
                child: Obx(() => Column(
                    children: [
                      SizedBox(
                          height: 112.h,
                          width: _getController.width.value,
                          child: Stack(
                              children: [
                                Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                                Positioned(
                                    height: _getController.height.value * 0.2,
                                    top: _getController.height.value * 0.062,
                                    left: _getController.width.value * 0.03,
                                    child: Text('Savatcha'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: _getController.width.value * 0.061, fontWeight: FontWeight.bold))
                                )
                              ]
                          )
                      ),
                      Container(
                          width: _getController.width.value,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                          child: Column(
                              children: [

                                SizedBox(height: _getController.width.value * 0.1)
                              ]
                          )
                      )
                    ]
                ))
            )
        )
    );
  }
}