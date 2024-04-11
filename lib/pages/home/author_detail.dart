import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/get_controller.dart';

class AuthorDetail extends StatelessWidget {
  String sId;
  int index;
  AuthorDetail({super.key, required this.sId, required this.index});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    if (index == 0) _getController.clearAuthorDetailList();
    ApiController().getAuthorDetail(sId);
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: const Center(
          child: Text('AuthorDetail'),
        ),
      ),
    );
  }
}