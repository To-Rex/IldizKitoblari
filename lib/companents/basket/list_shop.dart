import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/resource/colors.dart';

import '../../controllers/get_controller.dart';

class ListShop extends StatelessWidget {
  ListShop({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
          if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
            Row(children: [
              Checkbox(
                  value: _getController.allCheckBoxCard.value,
                  onChanged: (value) {
                    _getController.allCheckBoxCard.value = value!;
                    _getController.changeAllCheckBoxCardList();
              }),
              Text('${'Barchasini tanlash'.tr} (${_getController.basketModel.value.data!.result!.length}) ')
            ]),
          if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
            Container(
                margin: EdgeInsets.only(bottom: Get.height * 0.02),
                padding: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                child: Divider(height: 1, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2))),
          if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
            for (int i = 0; i < _getController.basketModel.value.data!.result!.length; i++)
              Row(children: [
                Checkbox(
                    value: _getController.checkBoxCardList[i],
                    onChanged: (value) {
                      _getController.changeCheckBoxCardList(i);
                    }),
                Container(
                    width: Get.width * 0.3,
                    height: Get.height * 0.15,
                    margin: EdgeInsets.only(right: Get.width * 0.02, bottom: Get.height * 0.015),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(_getController.basketModel.value.data!.result![i].image != null || _getController.basketModel.value.data!.result![i].image != '' ? _getController.basketModel.value.data!.result![i].image! : 'https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740'),))
                ),
                SizedBox(
                    width: Get.width * 0.5,
                    height: Get.height * 0.15,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_getController.basketModel.value.data!.result![i].name!.uz!),
                          Text('${_getController.basketModel.value.data!.result![i].price} ${'so‘m'.tr}', style: TextStyle(color: AppColors.primaryColor2, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              InkWell(
                                child: Text('O\'chirish'.tr),
                                onTap: () {
                                  ApiController().addToBasket('0', _getController.basketModel.value.data!.result![i].productId!,'deleted');
                                }
                              ),
                              const Spacer(),
                              Container(
                                height: Get.height * 0.05,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.grey.withOpacity(0.2)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        color: Theme.of(context).colorScheme.onBackground,
                                        onPressed: () {
                                          if (_getController.basketModel.value.data!.result![i].cartCount! > 1) {
                                            ApiController().addToBasket('${_getController.basketModel.value.data!.result![i].cartCount! - 1}', _getController.basketModel.value.data!.result![i].productId!, 'active');
                                          } else {
                                            ApiController().addToBasket('0', _getController.basketModel.value.data!.result![i].productId!,'deleted');
                                          }
                                        },
                                        icon: Icon(TablerIcons.minus, color: Theme.of(context).colorScheme.onBackground, size: Get.height * 0.025)),
                                    Text(_getController.basketModel.value.data!.result![i].cartCount.toString()),
                                    IconButton(
                                        color: Theme.of(context).colorScheme.onBackground,
                                        onPressed: () {
                                          if (_getController.basketModel.value.data!.result![i].count! >= _getController.basketModel.value.data!.result![i].cartCount!) {
                                            ApiController().addToBasket('${_getController.basketModel.value.data!.result![i].cartCount! + 1}', _getController.basketModel.value.data!.result![i].productId!, 'active');
                                          } else {
                                            ApiController().showToast(context, 'Error', 'The number of products in the basket cannot be less than 1', true, 2);
                                          }},
                                        icon: Icon(TablerIcons.plus, color: Theme.of(context).colorScheme.onBackground, size: Get.height * 0.025)),
                                  ],
                                ),
                              )
                            ],
                          )
                        ]))
              ])
        ]));
  }
}
