import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../companents/app_bar.dart';
import '../../controllers/get_controller.dart';

class DetailPage extends StatelessWidget {

  var title;
  DetailPage({super.key, required this.title});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_getController.height.value * 0.06),
        child: MyAppBar(title: title),
      ),
      body: Center(
        child: Text('Detail Page'),
      ),
    );
  }
}