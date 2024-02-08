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
    return Container(
      margin: EdgeInsets.only(bottom: _getController.height.value * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: _getController.width.value * 0.04),
          Text(hintText,
            style: TextStyle(
              fontSize: _getController.width.value * 0.04,
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    );
  }
}
