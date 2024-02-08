import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';

import '../companents/acc_item.dart';
import '../controllers/get_controller.dart';

class AccauntPage extends StatelessWidget {
  AccauntPage({super.key});
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
                        top: _getController.height.value * 0.04,
                        left: _getController.width.value * 0.03,
                        child: Text('Sahifam'.tr,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: _getController.width.value * 0.07,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Positioned(
                        width: _getController.width.value,
                        top: _getController.height.value * 0.11,
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
                                Row(
                                  children: [
                                    //circle avatar and name
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: _getController.width.value * 0.05,
                                            top: _getController.width.value * 0.05
                                        ),
                                        child: CircleAvatar(
                                            radius: _getController.width.value * 0.07,
                                            backgroundImage: const AssetImage('assets/images/oo4.png')
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: _getController.width.value * 0.05,
                                            top: _getController.width.value * 0.05
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dilshodjon Haydarov'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontSize: _getController.width.value * 0.05
                                                )
                                            ),
                                            Text('ID 644a520d1d9b3384ec163d1b'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontSize: _getController.width.value * 0.04
                                                )
                                            )
                                        ]
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                    height: _getController.width.value * 0.04
                                ),
                                //button profile edit
                                SizedBox(
                                    width: _getController.width.value * 0.91,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed('/myInfo');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                        ),
                                        child: Text('Profilni tahrirlash'.tr,
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: _getController.width.value * 0.04
                                            )
                                        )
                                    )
                                ),

                                AccItem(
                                    title: 'Mening ma\'lumotlarim'.tr,
                                    subTitle: 'Ma\'lumotlaringizni o\'zgartiring'.tr,
                                    icon: Icons.person,
                                    onTap: () {
                                      Get.toNamed('/myInfo');
                                    }
                                ),
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