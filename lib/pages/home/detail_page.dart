import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import '../../companents/app_bar.dart';
import '../../controllers/get_controller.dart';

class DetailPage extends StatelessWidget {
  var title;
  var menuSlug;
  DetailPage({super.key, required this.title, required this.menuSlug});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getProduct(1,menuSlug);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_getController.height.value * 0.06),
        child: MyAppBar(title: title),
      ),
      body: const Center(
        child: Text('Detail Page'),
      ),
    );
  }
}