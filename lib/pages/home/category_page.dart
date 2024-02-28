import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../companents/app_bar.dart';
import '../../controllers/get_controller.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_getController.height.value * 0.06),
        child: MyAppBar(title: 'Kategoriya'),
      ),

      body: Center(
        child: Text('Category Page'),
      ),
    );
  }
}