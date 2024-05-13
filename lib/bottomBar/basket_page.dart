import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
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
        ),
        bottomNavigationBar: BottomAppBar(
          height: _getController.height.value * 0.09,
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
                            Text('Jami miqdor:'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground)),
                            Text('25 000 so\'m'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground))
                          ],
                        )
                    ),
                    SizedBox(
                          width: _getController.width.value * 0.35,
                          height: _getController.height.value * 0.06,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              child: Text('Xarid'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.background))
                          )),
                    Container(
                          width: _getController.width.value * 0.13,
                          height: _getController.height.value * 0.06,
                          margin: EdgeInsets.only(left: _getController.width.value * 0.02),
                          child: IconButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              icon: Icon(TablerIcons.shopping_bag, color: Theme.of(context).colorScheme.background, size: _getController.width.value * 0.07),
                              onPressed: () {}
                          )
                      )
                  ]
              )
          ),
          ),
        )
    );
  }
}