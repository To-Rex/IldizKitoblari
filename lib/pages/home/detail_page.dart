import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/get_controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Text('Detail Page'),
      ),
    );
  }
}