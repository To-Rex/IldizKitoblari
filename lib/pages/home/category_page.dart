import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: _getController.height.value * 0.04,
        toolbarTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: _getController.width.value * 0.05,
          fontWeight: FontWeight.w600,
        ),
        title: Text('Kategoriya'.tr),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.onBackground,
              size: _getController.width.value * 0.06,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Text('Category Page'),
      ),
    );
  }
}