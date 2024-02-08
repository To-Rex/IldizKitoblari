

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';

import '../controllers/get_controller.dart';

class AccItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  var onTap;

  AccItem({super.key, required this.title, required this.subTitle, required this.icon, required this.onTap});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      leading: Container(
        padding: EdgeInsets.all(_getController.width.value * 0.018),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(_getController.width.value * 0.03),
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        ),
        child: Icon(icon),
      ),
      onTap: onTap,
    );
  }
}