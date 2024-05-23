import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import '../../controllers/get_controller.dart';

class OrdersPage extends StatelessWidget{
  OrdersPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getOrderList();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                  title: Text('Buyurtmalar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
                  centerTitle: false,
                  surfaceTintColor: Colors.transparent,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
                      onPressed: () {
                        Get.back();
                      }
                  )
              ),
              SizedBox(
                height: Get.height * 2,
                width: Get.width,
              )
            ]
          )
        )
    );
  }
}