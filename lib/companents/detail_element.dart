

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class DetailElement extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;

  DetailElement({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: _getController.width.value * 0.03,
        right: _getController.width.value * 0.03,
      ),
      child: Row(
        children: <Widget>[
          Icon(icon,
            color: AppColors.primaryColor,
            size: _getController.width.value * 0.05,
          ),
          Text(' $title ',
            style: TextStyle(
              fontSize: _getController.width.value * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(subTitle,
            style: TextStyle(
              fontSize: _getController.width.value * 0.035,
              fontWeight: FontWeight.bold
            )
          ),
        ],
      ),
    );
  }
}