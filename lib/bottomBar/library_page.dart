import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';

class LibraryPage extends StatelessWidget {

  LibraryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    _getController.tabController = TabController(length: 2, vsync: Navigator.of(context));
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              height: _getController.height.value,
              width: _getController.width.value,
              child: Obx(() => Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                        height: _getController.height.value * 0.24,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          child: SvgPicture.asset('assets/svgImages/shap.svg',
                              fit: BoxFit.fitWidth,
                              width: _getController.width.value,
                              height: _getController.height.value * 0.3),
                        )),
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: _getController.height.value * 0.062,
                        left: _getController.width.value * 0.03,
                        child: Text('Kutubxona'.tr,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: _getController.width.value * 0.061,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: _getController.height.value * 0.02,
                        left: 0,
                        right: 0,
                        child: SearchFields(onChanged: (String ) {  },)
                    ),
                    Positioned(
                        width: _getController.width.value,
                        top: _getController.height.value * 0.19,
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
                                Container(
                                    width: Get.width,
                                    height: Get.height * 0.055,
                                    margin: EdgeInsets.only(top: Get.height * 0.02),
                                    child: Container(
                                        constraints: BoxConstraints.expand(height:  Get.height * 0.06),
                                        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                                        padding: EdgeInsets.all(Get.width * 0.01),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: TabBar(
                                            onTap: (index) {
                                              _getController.tabController.animateTo(index);
                                              _getController.tabController.index = index;
                                              print('index: $index');
                                            },
                                            indicatorSize: TabBarIndicatorSize.tab,
                                            dividerColor: Colors.transparent,
                                            controller: _getController.tabController,
                                            labelStyle: TextStyle(
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).colorScheme.onBackground
                                            ),
                                            unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                            indicator: BoxDecoration(
                                                color: Theme.of(context).colorScheme.background,
                                                borderRadius: BorderRadius.circular(11),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.withOpacity(0.3),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: const Offset(0, 2)
                                                  )
                                                ]
                                            ),
                                            tabs: [
                                              Tab(
                                                  child: SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Center(
                                                          child: Text('Elektron kitoblar'.tr, style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w500))
                                                      )
                                                  )
                                              ),
                                              Tab(
                                                  child: SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Center(
                                                          child: Text('Audio kitoblar'.tr, style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w500))
                                                      )
                                                  )
                                              )
                                            ]
                                        )
                                    )
                                ),
                                Expanded(
                                    child: Center(
                                        child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: Get.width * 0.04, fontWeight: FontWeight.w500))
                                    )
                                )
                              ]
                            )
                        )
                    )
                  ]
              ))
          ),
        )
    );
  }
}