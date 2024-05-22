import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import '../../companents/orders/indicator_order.dart';
import '../../controllers/get_controller.dart';
import '../../models/orders/region_model.dart';
import '../../resource/colors.dart';

class OrderConfirmationPage extends StatelessWidget {
  OrderConfirmationPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getCountry();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.96),
        body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();},),
              title: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
              centerTitle: false
            ),
            const IndicatorOrder(index: 2),
            Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 10.sp),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                    boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: Get.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Buyurtmani tasdiqlash'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                            Container(
                                width: Get.width,
                                height: Get.height * 0.21,
                                margin: EdgeInsets.only(top: Get.height * 0.02, bottom: Get.height * 0.02),
                                decoration: BoxDecoration(color: _getController.paymentTypeIndex.value == 1 ? AppColors.primaryColor2.withOpacity(0.2) : Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(10.r), border: Border.all(color: _getController.paymentTypeIndex.value == 1 ? AppColors.primaryColor2 : Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
                                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Yetkazib berish narxi:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8))),
                                    SizedBox(height: 5.sp),
                                    Text('Bu manzilga yetkazib berish narxi operator tomonidan xabar beriladi!', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onBackground)),
                                    Padding(padding: EdgeInsets.only(top: Get.height * 0.01), child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), thickness: 1.sp)),
                                    Text('Jami xizmatlar bilan:',  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8))),
                                    SizedBox(height: 5.sp),
                                    Text('120 000 so‘m', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,color: AppColors.primaryColor2))
                                  ]
                                )
                            ),
                            Row(
                                children: [
                                  Text('Mahsulotlar'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                  Text('(${_getController.listCartCreate.length})'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))
                                ]
                            ),
                            SizedBox(height: 10.sp)
                          ]
                        )
                      ),
                      if (_getController.basketModel.value.data != null && _getController.basketModel.value.data!.result != null && _getController.basketModel.value.data!.result!.isNotEmpty)
                        for (int i = 0; i < _getController.basketModel.value.data!.result!.length; i++)
                          Row(children: [
                            Checkbox(
                                value: _getController.checkBoxCardList[i],
                                activeColor: AppColors.primaryColor,
                                onChanged: (value) {
                                  _getController.changeCheckBoxCardList(i);
                                }),
                            Container(
                                width: Get.width * 0.3,
                                height: Get.height * 0.15,
                                margin: EdgeInsets.only(right: Get.width * 0.02, bottom: Get.height * 0.015),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(_getController.basketModel.value.data!.result![i].image != null || _getController.basketModel.value.data!.result![i].image != '' ? _getController.basketModel.value.data!.result![i].image! : 'https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740')))
                            ),
                            SizedBox(
                                width: Get.width * 0.5,
                                height: Get.height * 0.15,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('uz_UZ' == Get.locale.toString()
                                          ? _getController.basketModel.value.data!.result![i].name!.uz!
                                          : 'oz_OZ' == Get.locale.toString()
                                          ? _getController.basketModel.value.data!.result![i].name!.oz!
                                          : _getController.basketModel.value.data!.result![i].name!.ru!,
                                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 15.sp, fontWeight: FontWeight.w400)),
                                      Text('${_getController.basketModel.value.data!.result![i].price} ${'so‘m'.tr}', style: TextStyle(color: AppColors.primaryColor2, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          InkWell(
                                              child: Text('O‘chirish'.tr, style: TextStyle(color: AppColors.red, fontSize: 15.sp, fontWeight: FontWeight.w400)),
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
                                                      }},
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
                                              ]
                                            )
                                          )
                                        ]
                                      )
                                    ]))
                          ])
                    ]
                )
            )
          ]
        ))
      ),
        bottomNavigationBar: BottomAppBar(
            height: _getController.height.value * 0.09,
            surfaceTintColor: Theme.of(context).colorScheme.background,
            elevation: 20,
            shadowColor: Theme.of(context).colorScheme.error,
            color: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.016, horizontal: Get.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: Get.width * 0.45,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.grey.withOpacity(0.5)), elevation: MaterialStateProperty.all(0), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)))),
                      onPressed: (){Get.back();},
                      child: Text('Orqaga'.tr, style: TextStyle(fontSize: 16.sp, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w500))
                    )
                ),
                SizedBox(
                    width: Get.width * 0.45,
                    child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor2), shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)))),
                        onPressed: (){
                          Get.to(() => OrderConfirmationPage(), transition: Transition.rightToLeft);
                        },
                        child: Text('Tasdiqlash'.tr, style: TextStyle(fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.w500))
                    )
                )
              ]
            )
        )
    );
  }
}