import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/get_controller.dart';

class FilterPage extends StatelessWidget{
  FilterPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Filter'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
              onPressed: () {
                Get.back();
              },
            )),
      body: const Center(child: Text('FilterPage'))
    );
  }
}