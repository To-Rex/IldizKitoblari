import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';

import '../../companents/orders/indicator_order.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class OrderCountryPage extends StatelessWidget {
  OrderCountryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getCountry();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.94),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();},),
        title: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const IndicatorOrder(index: 0),
            Container(
              width: Get.width,
              height: Get.height * 0.8,
              margin: EdgeInsets.only(top: 10.sp),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
                  boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 0))]
              ),
              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: Get.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Yetkazib berish manzili'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
                  SizedBox(height: Get.height * 0.02),
                  Text('${'Davlat'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),


                  //Text('${'Tuman / shahar'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                  //Text('${'Manzil'.tr}: ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                ],
              )
            )
          ],
        )
      )
    );
  }
}