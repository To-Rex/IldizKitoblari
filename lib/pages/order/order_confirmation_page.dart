import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../companents/orders/indicator_order.dart';
import '../../controllers/get_controller.dart';
import '../../models/orders/region_model.dart';
import '../../resource/colors.dart';
import '../../services/uni_services.dart';

class OrderConfirmationPage extends StatelessWidget {
  OrderConfirmationPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    //ApiController().getCountry();
    ApiController().getOrderDetail();
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
                                    Text('${'Yetkazib berish narxi'.tr}:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8))),
                                    SizedBox(height: 5.sp),
                                    Text('${_getController.orderDetailModel.value.data?.deliveryPrice == null || _getController.orderDetailModel.value.data?.deliveryPrice == 0 ?'Bu manzilga yetkazib berish narxi operator tomonidan xabar beriladi!'.tr : _getController.orderDetailModel.value.data?.deliveryPrice} ${'so‘m'.tr}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onBackground)),
                                    Padding(padding: EdgeInsets.only(top: Get.height * 0.01), child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), thickness: 1.sp)),
                                    Text('${'Jami xizmatlar bilan'.tr}:',  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8))),
                                    SizedBox(height: 5.sp),
                                    Text('${int.parse(_getController.orderDetailModel.value.data?.price.toString() ?? '0') + int.parse(_getController.orderDetailModel.value.data?.deliveryPrice.toString() ?? '0')} ${'so‘m'.tr}',
                                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,color: AppColors.primaryColor2))
                                  ]
                                )
                            ),
                            Row(
                                children: [
                                  Text('Mahsulotlar'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                  Text('(${_getController.orderDetailModel.value.data?.orderProducts?.length})'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))
                                ]
                            ),
                            SizedBox(height: 10.sp)
                          ]
                        )
                      ),
                      if (_getController.orderDetailModel.value.data != null && _getController.orderDetailModel.value.data!.orderProducts != null && _getController.orderDetailModel.value.data!.orderProducts!.isNotEmpty)
                        for (int i = 0; i < _getController.orderDetailModel.value.data!.orderProducts!.length; i++)
                          Row(children: [
                            Checkbox(
                                value: _getController.checkBoxCardList[i],
                                activeColor: AppColors.primaryColor,
                                onChanged: (value) {
                                  _getController.changeCheckBoxCardList(i);
                                }),
                            Container(
                                width: Get.width * 0.3,
                                height: Get.height * 0.14,
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
                                          ? _getController.orderDetailModel.value.data!.orderProducts![i].product!.name!.uz!
                                          : 'oz_OZ' == Get.locale.toString()
                                          ? _getController.orderDetailModel.value.data!.orderProducts![i].product!.name!.oz!
                                          : _getController.orderDetailModel.value.data!.orderProducts![i].product!.name!.ru!,
                                          style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 16.sp, fontWeight: FontWeight.w500)
                                      ),
                                      Row(
                                        children: [
                                          Text('${_getController.orderDetailModel.value.data!.orderProducts![i].orderCount} ${'dona'.tr}', style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), fontSize: 15.sp, fontWeight: FontWeight.w400)),
                                          Container(height: 5.h, width: 5.w, decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)), margin: EdgeInsets.only(right: 5.sp, left: 5.sp)),
                                          Text('${_getController.orderDetailModel.value.data!.orderProducts![i].orderPrice} ${'so‘m'.tr}', style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), fontSize: 15.sp, fontWeight: FontWeight.w400))
                                        ]
                                      ),
                                      Text('${int.parse(_getController.orderDetailModel.value.data!.orderProducts![i].orderCount.toString()) * int.parse(_getController.orderDetailModel.value.data!.orderProducts![i].orderPrice.toString())} ${'so‘m'.tr}', style: TextStyle(color: AppColors.primaryColor2, fontSize: 15.sp, fontWeight: FontWeight.bold)),
                                    ]
                                )
                            )
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
                          //m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=Aziz Kuchkarov;ac.phone=+998 (93) 556-57-41;a=5000000;
                          //var data = base64.encode(utf8.encode('m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=${int.parse(_getController.orderDetailModel.value.data!.price.toString()) + int.parse(_getController.orderDetailModel.value.data!.deliveryPrice.toString())}00;c=https://ildizkitoblari.uz/ok'));
                          //var data = base64.encode(utf8.encode('m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=10000;'));
                          //var data = base64.encode(utf8.encode('m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=10000;c=https://encryptpy.onrender.com/api/count'));
                          var data = base64.encode(utf8.encode('m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=10000;c=https://ildizkitoblari.uz'));
                          debugPrint('suuuuu:m=664c890b70ee2ef365a80e85;ac.order_id=TESTORDER;ac.full_name=${_getController.meModel.value.data!.result?.fullName};ac.phone=${_getController.meModel.value.data!.result?.phone};a=10000;');
                          debugPrint('https://checkout.paycom.uz/$data');
                          //debugPrint(ApiController.baseUrl);
                          launchUrl(Uri.parse('https://checkout.paycom.uz/$data'));

                          //Get.to(PaymentPage());
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