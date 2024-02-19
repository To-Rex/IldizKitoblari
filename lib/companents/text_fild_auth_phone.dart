import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../controllers/get_controller.dart';

class TextFieldPhoneAuth extends StatelessWidget {
  var next;
  var enabled;
  TextEditingController nameController;

  TextFieldPhoneAuth({Key? key, required this.nameController, this.next, this.enabled}) : super(key: key);

  final GetController _getController = Get.put(GetController());

  final mackFormater = MaskTextInputFormatter(
      mask: '+998 (##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy
  );

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
        enabled: enabled,
        controller: nameController,
        keyboardType: TextInputType.phone,
        textInputAction: next,
        focusNode: FocusNode(),
        style: TextStyle(
          fontSize: _getController.width.value * 0.04,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        maxLength: 19,
        buildCounter: (BuildContext context, {required int currentLength, required int? maxLength, required bool isFocused}) => null,
        inputFormatters: [mackFormater],
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
        ),
      )),
    );
  }
}