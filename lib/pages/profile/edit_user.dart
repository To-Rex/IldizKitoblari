import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';

class EditUser extends StatelessWidget {
  EditUser({super.key});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shaxsiy ma\'lumotlar'.tr),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();})
      ),
      body: Center(child: Text('Profilni tahrirlash')),
    );
  }
}