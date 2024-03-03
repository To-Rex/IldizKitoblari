import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/get_controller.dart';

class DetailPage extends StatelessWidget {


  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiController().getProductDetail('aldanganlar').then((value) => {
      print('counts: ${_getController.productDetailModel.value.data?.name?.uz}')
    });
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detail Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: const Expanded(
          child: Column(
            children: [
              Text('Detail Page'),
            ],
          )
      ),
    );
  }
}