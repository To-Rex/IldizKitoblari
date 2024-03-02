import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/get_controller.dart';

class QuotesPage extends StatelessWidget {
  QuotesPage({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ApiController().getBanner(1,3);
    return Scaffold(
      appBar: AppBar(
          title: Text('Quotes',
              style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
            onPressed: () {
              Get.back();
            },
          )),
      body: Expanded(
          child: Obx(
            () => _getController.productModelLength.value > 0
                ? SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const ClassicHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = const CircularProgressIndicator();
                    } else if (mode == LoadStatus.loading) {
                      body = const CircularProgressIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
                    } else if (mode == LoadStatus.canLoading) {
                      body = const SizedBox();
                    } else {
                      body = const Text("Ma`lumotlar yangilandi", style: TextStyle(fontSize: 14, color: Colors.black));
                    }
                    return SizedBox(
                      height: _getController.height.value * 0.1,
                      child: Center(child: body),
                    );
                  },
                ),
                onLoading: () async {
                  _refreshController.loadComplete();
                },
                onRefresh: () async {
                  _getController.page.value = 1;
                  _refreshController.refreshCompleted();
                },
                physics: const BouncingScrollPhysics(),
                controller: _refreshController,
                child: ListView.builder(
                    itemCount: _getController.quotesModel.value.data!.result!.count!,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_getController.quotesModel.value.data!.result!.name!.uz!));
                    }
                )
            )
                : Center(child: Text('Ma`lumotlar yo`q!', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600))),
          )
      )
    );
  }
}
