import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../companents/orders/indicator_order.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class OrderCountryPage extends StatelessWidget {
  OrderCountryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();},),
        title: Text('Buyurtma'.tr, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IndicatorOrder(
              index: 3,
            )
          ],
        )
      )
    );
  }
}