import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class TextFildsAuth extends StatelessWidget {
  TextEditingController nameController;
  var next;
  var inputType;

  final GetController _getController = Get.put(GetController());

  TextFildsAuth({Key? key, required this.nameController, this.next, this.inputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getController.width.value * 0.95,
      height: _getController.height.value * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        ),
      ),
      child: TextFormField(
        controller: nameController,
        style: TextStyle(
          fontSize: _getController.width.value * 0.035,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        textInputAction: next,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: 'Kiriting'.tr,
          hintStyle: TextStyle(
            fontSize: _getController.width.value * 0.035,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          contentPadding: EdgeInsets.only(left: _getController.width.value * 0.05),
          border: InputBorder.none,
        ),
      ),
    );
  }
}