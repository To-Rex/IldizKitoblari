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
      width: _getController.width.value * 0.92,
      height: _getController.height.value * 0.056,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        ),
      ),
      child: Obx(() => TextField(
        keyboardType: inputType,
        obscureText: inputType == TextInputType.visiblePassword ? _getController.obscureText.value : false,
        focusNode: FocusNode(),
        style: TextStyle(
          fontSize: _getController.width.value * 0.04,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Kiriting'.tr,
          filled: true,
          isDense: true,
          fillColor: Theme.of(context).colorScheme.surface,
          hintStyle: TextStyle(
            fontSize: _getController.width.value * 0.04,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,              // No border
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: inputType == TextInputType.visiblePassword ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: () {
                _getController.obscureText.value = !_getController.obscureText.value;
              },
              child: Icon(
                _getController.obscureText.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: 24,
              ),
            ),
          ) : null,
        ),
      )),
    );
  }
}