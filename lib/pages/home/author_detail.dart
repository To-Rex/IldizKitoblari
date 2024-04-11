import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/get_controller.dart';

class AuthorDetail extends StatelessWidget {
  String sId;
  String title;
  int index;
  AuthorDetail({super.key, required this.sId, required this.index, required this.title});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    if (index == 0) _getController.clearAuthorDetailList();
    ApiController().getAuthorDetail(sId);
    return Scaffold(
      appBar: AppBar(
          title: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
            onPressed: () {
              Get.back();
            },
          )),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: const Center(
          child: Text('AuthorDetail'),
        ),
      ),
    );
  }
}