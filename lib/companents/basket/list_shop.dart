import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class ListShop extends StatelessWidget {
  ListShop({super.key});

  final GetController _getController = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        for (int i = 0; i < _getController.basketModel.value.data!.result!.length; i++)
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {}
              ),
              Container(
                  width: Get.width * 0.3,
                  height: Get.height * 0.15,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(_getController.basketModel.value.data!.result![i].image!),))
              ),
              SizedBox(
                  width: Get.width * 0.4,
                  child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_getController.basketModel.value.data!.result![i].name!.uz!),
                        Text(_getController.basketModel.value.data!.result![i].price.toString()),
                      ]
                  )
              ),

            ],
          ),
      ],
    ));
  }

}