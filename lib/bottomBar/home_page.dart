import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
    ApiController().getBanner();
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
                                Container(
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.018, bottom: _getController.height.value * 0.02
                                  ),
                                  height: _getController.height.value * 0.173,
                                  width: _getController.width.value * 0.93,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(seconds: 5),
                                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    /*items: _getController.bannerModel.value.data!.result!.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          //'uz_UZ' == Get.locale.toString() && i.imageUz != ''
                                          // ? i.imageUz! : 'oz_UZ' == Get.locale.toString() && i.imageOz != ''
                                          // ? i.imageOz! : 'ru_RU' == Get.locale.toString() && i.imageRu != ''
                                          // ? i.imageRu! : null)

                                          return Container(
                                            width: _getController.width.value * 0.93,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: Theme.of(context).colorScheme.onBackground,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    'uz_UZ' == Get.locale.toString() && i.imageUz != ''
                                                        ? i.imageUz! : 'oz_UZ' == Get.locale.toString() && i.imageOz != ''
                                                        ? i.imageOz! : 'ru_RU' == Get.locale.toString() && i.imageRu != ''
                                                        ? i.imageRu! : i.image!),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),*/
                                      items: [
                                        for (var i in _getController.bannerModel.value.data!.result!)
                                          if ('uz_UZ' == Get.locale.toString() && i.imageUz != '')
                                            Container(
                                              width: _getController.width.value * 0.93,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: Theme.of(context).colorScheme.onBackground,
                                                image: DecorationImage(
                                                  image: NetworkImage(i.imageUz!),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                          else if ('oz_UZ' == Get.locale.toString() && i.imageOz != '')
                                            Container(
                                              width: _getController.width.value * 0.93,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: Theme.of(context).colorScheme.onBackground,
                                                image: DecorationImage(
                                                  image: NetworkImage(i.imageOz!),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                          else if ('ru_RU' == Get.locale.toString() && i.imageRu != '')
                                            Container(
                                              width: _getController.width.value * 0.93,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: Theme.of(context).colorScheme.onBackground,
                                                image: DecorationImage(
                                                  image: NetworkImage(i.imageRu!),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            )
                                      ],
                                  ),
                                ),
                                ChildItem(
                                    title: _getController.fullCheck == true ? _getController.menuModel.value.data!.result![_getController.fullIndex.value].title!.uz! : 'Kategoriya',
                                    function: (){
                                  print('Barchasi');
                                }),
                                SizedBox(
                                  width: _getController.width.value * 0.93,
                                  child: Wrap(
                                    spacing: _getController.width.value * 0.02,
                                    children: [
                                      if (_getController.fullCheck.isFalse && _getController.menuModel.value.data!.result != null)
                                        for (var i in _getController.menuModel.value.data!.result!)
                                          InkWell(
                                          onTap: () {
                                            _getController.fullCheck.value = true;
                                            _getController.fullIndex.value = _getController.menuModel.value.data!.result!.indexOf(i);
                                          },
                                          child: Chip(
                                            visualDensity: VisualDensity.compact,
                                            label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_UZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
                                            padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01,
                                                vertical: _getController.height.value * 0.007),
                                            labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                            side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                                            backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                            labelStyle: TextStyle(
                                                color: Theme.of(context).colorScheme.onBackground,
                                                fontSize: _getController.width.value * 0.04,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      if (_getController.fullCheck.isTrue && _getController.menuModel.value.data!.result![_getController.fullIndex.value].children != null && _getController.menuModel.value.data!.result![_getController.fullIndex.value].children!.isNotEmpty)
                                        for (var i in _getController.menuModel.value.data!.result![_getController.fullCheck.value ? _getController.fullIndex.value : _getController.index.value].children!)
                                          InkWell(
                                            onTap: () {
                                               _getController.indexSub.value = _getController.menuModel.value.data!.result![_getController.fullCheck.value ? _getController.fullIndex.value : _getController.index.value].children!.indexOf(i);
                                            },
                                            child: Chip(
                                              label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_UZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!,),
                                              visualDensity: VisualDensity.compact,
                                              padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                              labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                              side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                                              backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04),
                                              /*onDeleted: _getController.indexSub.value == _getController.menuModel.value.data!.result![_getController.fullCheck.value ? _getController.fullIndex.value : _getController.index.value].children!.indexOf(i) ? () {
                                                _getController.indexSub.value = 0;
                                              } : null,
                                              deleteButtonTooltipMessage: 'Belgilash',
                                              deleteIcon: Icon(
                                                TablerIcons.check,
                                                size: _getController.width.value * 0.05,
                                                color: Theme.of(context).colorScheme.onBackground,
                                              ),*/
                                            )
                                          )
                                      else if (_getController.fullCheck.isTrue && _getController.menuModel.value.data!.result![_getController.fullIndex.value].children == null)
                                        SizedBox(
                                          width: _getController.width.value * 0.93,
                                          height: _getController.height.value * 0.1,
                                          child: Center(
                                            child: Text(
                                              'Ma\'lumotlar yo\'q!'.tr,
                                              style: TextStyle(
                                                fontSize: _getController.width.value * 0.035,
                                                color: Theme.of(context).colorScheme.onBackground,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                ),
                                ChildItem(title: 'Elektron kitoblar', function: (){
                                  print('Barchasi');
                                }),
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