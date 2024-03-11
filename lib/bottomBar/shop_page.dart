import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../companents/child_item.dart';
import '../companents/product_item.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';
import '../pages/home/cat_detail_page.dart';
import '../resource/colors.dart';

class ShopPage extends StatelessWidget {

  ShopPage({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {
    _getController.changeItemPage(2);
    return Scaffold(
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
              print('onLoading');
              _getController.addItemPage();
              _refreshController.loadComplete();
            },
            onRefresh: () async {
              _refreshController.refreshCompleted();
            },
            controller: _refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                    width: _getController.width.value,
                    decoration: const BoxDecoration(color: AppColors.backgroundApp),
                    child: Obx(() => Column(
                        children: [
                          SizedBox(
                            height: _getController.height.value * 0.19,
                            child: Stack(
                              children: [
                                Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                                Positioned(
                                    height: _getController.height.value * 0.2,
                                    top: _getController.height.value * 0.062,
                                    left: _getController.width.value * 0.03,
                                    child: Text('Do\'kon'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: _getController.width.value * 0.061, fontWeight: FontWeight.bold))
                                ),
                                Positioned(top: _getController.height.value * 0.0675, left: 0, right: 0, child: SearchFields())
                              ]
                            )
                          ),
                          Container(
                              width: _getController.width.value,
                              padding: EdgeInsets.only(top: _getController.height.value * 0.01),
                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),),
                              child:Column(
                                  children: [
                                    if (_getController.menuModel.value.data != null)
                                      for (var i in _getController.menuModel.value.data!.result!.length > _getController.itemPage.value ? _getController.menuModel.value.data!.result!.sublist(0, _getController.itemPage.value) : _getController.menuModel.value.data!.result!)
                                        Column(
                                            children: [
                                              ChildItem(title: 'uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, function: (){}),
                                              if (_getController.productModel.value.data != null)
                                                SizedBox(
                                                    height: _getController.height.value * 0.35,
                                                    width: _getController.width.value,
                                                    child: ListView.builder(
                                                        padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                                        itemCount: _getController.productModel.value.data!.result!.length,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return ProductItem(
                                                            imageUrl: _getController.productModel.value.data!.result![index].image,
                                                            title: _getController.productModel.value.data!.result![index].name,
                                                            price: _getController.productModel.value.data!.result![index].price.toString(),
                                                            function: () {
                                                              Get.to(() => CatDetailPage(title: _getController.productModel.value.data!.result![index].name!, menuSlug: _getController.productModel.value.data!.result![index].slug!));
                                                            },
                                                            id: _getController.productModel.value.data!.result![index].sId,
                                                            deck: _getController.productModel.value.data!.result![index].name,
                                                          );
                                                        }))
                                            ]
                                        )
                                  ]
                              )
                          )
                        ]
                    ))
                )
            )
        )
    );
  }
}

