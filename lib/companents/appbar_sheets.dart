import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class AppBarSheets extends StatelessWidget {
  var title;
  AppBarSheets({Key? key, required this.title}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getController.height.value * 0.085,
      width: _getController.width.value * 0.95,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(TablerIcons.arrow_left,
              color: Theme.of(context).colorScheme.onSurface,
              size: _getController.width.value * 0.06,
            ),
          ),
          SizedBox(width: _getController.width.value * 0.02),
          Text(
            title,
            style: TextStyle(
              fontSize: _getController.width.value * 0.045,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
