import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../companents/user/scleton_orders.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class OrdersDetailPage extends StatelessWidget{
  OrdersDetailPage({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    print(Get.arguments.toString());
    print(Get.arguments[0].toString());
    List list = Get.arguments;
    ApiController().getOrderListDetail(list.isNotEmpty ? list.first.toString() : '');
    return Scaffold(
        body: SingleChildScrollView(
            child: Obx(()=> Column(
                children: [
                  AppBar(
                      title: _getController.orderListDetailModel.value.data == null || _getController.orderListDetailModel.value.data!.uid == null
                          ? const SizedBox(width: 0, height: 0)
                          : Text('№${_getController.orderListDetailModel.value.data!.uid.toString()}', style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
                      centerTitle: false,
                      surfaceTintColor: Colors.transparent,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
                          onPressed: () {
                            Get.back();
                          }
                      )
                  ),
                  SizedBox(height: _getController.height.value * 0.02),
                  SizedBox(height: _getController.height.value * 0.02),
                  _getController.orderListDetailModel.value.data == null
                      ? SizedBox(width: Get.width, height: Get.height * 0.8, child: Center(child: Text('Ma‘lumotlar yo‘q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500))))
                      : Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10.sp),
                      margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.background, boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.orderListDetailModel.value.data!.uid != null)
                              Text('${'Buyurtma raqami'.tr}:', style: TextStyle(fontSize: _getController.width.value * 0.03, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                            if (_getController.orderListDetailModel.value.data!.uid != null)
                              Text(_getController.orderListDetailModel.value.data!.uid.toString(), style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500)),
                            SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.orderListDetailModel.value.data!.uid != null)
                              Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1)),
                            //Buyurtma sanasi
                            if (list[1] != null && list[1] != '')
                              Text('${'Buyurtma sanasi'.tr}:', style: TextStyle(fontSize: _getController.width.value * 0.03, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                            if (list[1] != null && list[1] != '')
                              Text(DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(list[1]).toLocal().toString().substring(0, 10).replaceAll('-', '.'), style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500)),
                            SizedBox(height: _getController.height.value * 0.01),
                            if (list[1] != null && list[1] != '')
                              Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1)),
                            if (_getController.orderListDetailModel.value.data!.type != null)
                              Text('${'To‘lov turi'.tr}:', style: TextStyle(fontSize: _getController.width.value * 0.03, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                            if (_getController.orderListDetailModel.value.data!.type != null)
                              Text(_getController.orderListDetailModel.value.data!.type == 1 ? 'Click'.tr : 'PayMe'.tr, style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500)),
                            SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.orderListDetailModel.value.data!.price != null && _getController.orderListDetailModel.value.data!.deliveryPrice != null)
                              Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1)),
                            if (_getController.orderListDetailModel.value.data!.price != null && _getController.orderListDetailModel.value.data!.deliveryPrice != null)
                              Text('${'To‘lov miqdori'.tr}:', style: TextStyle(fontSize: _getController.width.value * 0.03, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                            if (_getController.orderListDetailModel.value.data!.price != null && _getController.orderListDetailModel.value.data!.deliveryPrice != null)
                              Text('${int.parse(_getController.orderListDetailModel.value.data!.price.toString())+int.parse(_getController.orderListDetailModel.value.data!.deliveryPrice.toString())} ${'so‘m'.tr}', style: TextStyle(color: AppColors.primaryColor2, fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500)),
                            SizedBox(height: _getController.height.value * 0.01),
                          ]
                      )
                  ),
                  SizedBox(height: _getController.height.value * 0.02),
                  _getController.orderListDetailModel.value.data != null
                  ? Row(
                    children: [
                      SizedBox(width: _getController.width.value * 0.03),
                      Text('Mahsulotlar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground)),
                      Text(' (${_getController.orderListDetailModel.value.data!.orderProducts!.length})', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                    ],
                  )
                  : const SizedBox.shrink(),
                  _getController.orderListDetailModel.value.data != null
                  ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _getController.orderListDetailModel.value.data!.orderProducts!.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03,bottom: _getController.height.value * 0.015),
                              width: _getController.width.value * 0.25,
                              child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network('https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {if (loadingProgress == null) return child;return SizedBox(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, color: AppColors.grey)));}, errorBuilder: (context, error, stackTrace) {return Text(error.toString());}))
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: _getController.width.value * 0.67, child: Text(_getController.orderListDetailModel.value.data!.orderProducts![index].product!.name!.uz.toString(),maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500))),
                              SizedBox(height: _getController.height.value * 0.01),
                              Row(
                                children: [
                                  Text('${_getController.orderListDetailModel.value.data!.orderProducts![index].orderCount} ', style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                                  Text('dona'.tr, style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                                  Container(
                                      width: 6.sp,
                                      height: 6.sp,
                                      margin: EdgeInsets.symmetric(horizontal: 5.sp),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                  ),
                                  Text('${int.parse(_getController.orderListDetailModel.value.data!.orderProducts![index].orderPrice.toString())*int.parse(_getController.orderListDetailModel.value.data!.orderProducts![index].orderCount.toString())} ${'so‘m'.tr}', style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))),
                                ]
                              ),
                              SizedBox(height: _getController.height.value * 0.01),
                              SizedBox(width: _getController.width.value * 0.67, child: Text('${_getController.orderListDetailModel.value.data!.orderProducts![index].orderPrice.toString()} ${'so‘m'.tr}', style: TextStyle(fontSize: _getController.width.value * 0.042, fontWeight: FontWeight.bold,color: AppColors.primaryColor2))),
                            ],
                          )
                        ],
                      );
                    },
                  )
                  : const SizedBox.shrink(),
                ]
            ))
        )
    );
  }
}