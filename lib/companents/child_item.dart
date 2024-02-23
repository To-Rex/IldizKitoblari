import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class ChildItem extends StatelessWidget {
  String title;
  Function function;

  ChildItem({super.key, required this.title, required this.function});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _getController.width.value,
        margin: EdgeInsets.only(
            left: _getController.width.value * 0.04,
            right: _getController.width.value * 0.01),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold,)),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                function();
              },
              child: Text(
                'Barchasi',
                style: TextStyle(
                  fontSize: _getController.width.value * 0.04,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ));
  }
}
