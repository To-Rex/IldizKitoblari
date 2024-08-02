import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../controllers/get_controller.dart';

class TextFieldsAuth extends StatelessWidget {
  final TextInputAction? next;
  final TextInputType? inputType;
  final TextEditingController nameController;
  TextFieldsAuth({super.key, required this.nameController, this.next, this.inputType});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getController.width.value * 0.92,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3))),
      child: Obx(() => TextField(
        controller: nameController,
        keyboardType: inputType,
        textInputAction: next,
        obscureText: inputType == TextInputType.visiblePassword ? _getController.obscureText.value : false,
        focusNode: FocusNode(),
        style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Kiriting'.tr,
          filled: true,
          isDense: true,
          fillColor: Theme.of(context).colorScheme.surface,
          hintStyle: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
          suffixIcon: inputType == TextInputType.visiblePassword ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: () {_getController.obscureText.value = !_getController.obscureText.value;},
              child: Icon(_getController.obscureText.value ? Icons.visibility_off : Icons.visibility, size: Theme.of(context).iconTheme.fill)
            )
          ) : null
        )
      ))
    );
  }
}