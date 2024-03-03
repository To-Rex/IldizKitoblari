import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class DetailPage extends StatelessWidget {

  var slug;

  DetailPage({super.key, required this.slug});
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ApiController().getProductDetail(slug);
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        actions: [
          IconButton(
            icon: Icon(Icons.share,
                color: Theme.of(context).colorScheme.onBackground, size: 20),
            onPressed: () {
              print('Share');
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark,
                color: Theme.of(context).colorScheme.onBackground, size: 20),
            onPressed: () {
              print('Collection');
            },
          ),],
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const ClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const SizedBox();
              } else if (mode == LoadStatus.loading) {
                body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
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
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() => Column(
                children: [
                  Container(
                    width: _getController.width.value,
                    height: _getController.height.value * 0.4,
                    margin: EdgeInsets.only(
                      left: _getController.width.value * 0.03,
                      right: _getController.width.value * 0.03,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      image: DecorationImage(
                        image: NetworkImage(
                          _getController.productDetailModel.value.data?.images![0].file ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]
            ))
          )
      )
    );
  }
}