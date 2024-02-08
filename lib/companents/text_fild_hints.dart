import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';

class TextFildHints extends StatelessWidget {
  var hintText;
  TextFildHints({Key? key, required this.hintText}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getController.width.value * 0.93,
      height: _getController.height.value * 0.03,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(hintText,
            style: TextStyle(
              fontSize: _getController.width.value * 0.035,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
