import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';
import '../companents/child_item.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';

class HomePage extends StatelessWidget {

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getMenu();
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
                        height: _getController.height.value * 0.12,
                        top: _getController.height.value * 0.01,
                        left: 0,
                        right: 0,
                        child: SearchFields()
                    ),
                    Positioned(
                        width: _getController.width.value,
                        top: _getController.height.value * 0.14,
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
                                //image
                                Container(
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.023),
                                  height: _getController.height.value * 0.2,
                                  width: _getController.width.value * 0.93,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(context).colorScheme.onBackground,
                                    image: const DecorationImage(
                                      image: NetworkImage('https://ildizkitoblari.uz/public/files/2024-01-29T17-52-27.321Z_photo_2024-01-29_22-51-35.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                ChildItem(title: 'Kategoriya', function: (){
                                  print('Barchasi');
                                }),
                                Wrap(
                                  spacing: _getController.width.value * 0.02,
                                  children: [
                                    for (var i in _getController.menuModel.value.data!.result!)
                                      Chip(
                                        label: Text(i.title!.uz!),
                                        visualDensity: VisualDensity.compact,
                                        padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                        labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                        side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                                        backgroundColor: Theme.of(context).brightness == Brightness.dark
                                            ? AppColors.grey.withOpacity(0.5)
                                            : AppColors.grey.withOpacity(0.2),
                                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground,
                                            fontSize: _getController.width.value * 0.03),
                                      ),
                                  ],
                                )
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