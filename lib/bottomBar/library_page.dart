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
                        child: SearchFields()
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
                              ],
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