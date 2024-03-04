import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
        child:InkWell(
            onTap: () {
              _getController.fullCheck.value = false;
            },
            child:Row(
              children: [
                if (_getController.fullCheck.value == true)
                  Icon(TablerIcons.arrow_left,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: _getController.width.value * 0.06,
                  ),
                if (_getController.fullCheck.value == true)
                  SizedBox(width: _getController.width.value * 0.02),
                Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w600,)),
                const Expanded(child: SizedBox()),
                TextButton(
                  onPressed: () {
                    function();
                  },
                  child: Text(
                    'Barchasi'.tr,
                    style: TextStyle(
                      fontSize: _getController.width.value * 0.04,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ))
        );
  }
}
