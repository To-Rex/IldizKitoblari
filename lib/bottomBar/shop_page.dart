import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../companents/child_item.dart';
import '../companents/product_item.dart';
import '../companents/search_fild.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';
import '../pages/home/cat_detail_page.dart';
import '../pages/home/detail_page.dart';
import '../resource/colors.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  final GetController _getController = Get.put(GetController());

  void _getData() {
    _getController.clearBannerModel();
    ApiController().getBanner(1,1);
    _getController.clearProductModelList();
    _getController.changeItemPage(0);
    if (_getController.menuModel.value.data != null) {
      ApiController().getItemsProductSearch(1, true,_getController.searchController.text);
      //_refreshController.refreshCompleted();
      _getController.refreshController.refreshCompleted();
    } else {
      //_refreshController.refreshCompleted();
      _getController.refreshController.refreshCompleted();
    }
  }

  void _onLoading() async {
    if (_getController.menuModel.value.data!.result!.length > _getController.itemPage.value && _getController.searchController.text.isEmpty) {
      ApiController().getItemsProductSearch(1,  true,_getController.searchController.text).then((value) =>
          //_refreshController.loadComplete()
          _getController.refreshController.loadComplete()
      );
    } else {
      //_refreshController.loadComplete();
      _getController.refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    _getController.clearProductModelList();
    _getController.changeItemPage(0);
    _getData();
    return Scaffold(
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            physics: const BouncingScrollPhysics(),
            header: const ClassicHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                print(mode);
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const SizedBox();
                } else if (mode == LoadStatus.loading) {
                  body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
                } else if (mode == LoadStatus.canLoading) {
                  body = const SizedBox();
                } else if ( mode == LoadStatus.noMore) {
                  //_refreshController.loadComplete();
                  _getController.refreshController.loadComplete();
                    body = const Text("Ma`lumotlar tugadi", style: TextStyle(fontSize: 14, color: Colors.white));
                } else {
                  //_refreshController.loadComplete();
                  _getController.refreshController.loadComplete();
                  body = const Text("Ma`lumotlar yangilandi", style: TextStyle(fontSize: 14, color: Colors.white));
                }
                return SizedBox(
                  height: _getController.height.value * 0.1,
                  child: Center(child: body),
                );
              },
            ),
            onLoading: _onLoading,
            onRefresh: _getData,
            //controller: _refreshController,
            controller: _getController.refreshController,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                    width: _getController.width.value,
                    decoration: const BoxDecoration(color: AppColors.backgroundApp),
                    child: Obx(() =>
                        Column(
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
                                Positioned(top: _getController.height.value * 0.0675, left: 0, right: 0,
                                    child: SearchFields(onChanged: (String value) {
                                      if (value.isEmpty && _getController.searchController.text == '') {
                                        _getData();
                                      }
                                      if (value.isNotEmpty && _getController.menuModel.value.data != null && value.length >= 3 ) {
                                        _getController.clearProductModelList();
                                        _getController.changeItemPage(0);
                                        ApiController().getItemsProductSearch(1, true,_getController.searchController.text);
                                      }
                                    })
                                )
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
                                              if (i.children != null && _getController.productModelList.isNotEmpty || _getController.menuModel.value.data!.result!.indexOf(i) == 0)
                                              ChildItem(title: 'uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, function: (){
                                                _getController.page.value = 1;
                                                _getController.productModelLength.value = 0;
                                                _getController.clearProductModel();
                                                Get.to(() => CatDetailPage(title: 'uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, menuSlug: i.slug!, parent: true));
                                              }),
                                              if (_getController.productModelList.isNotEmpty || _getController.menuModel.value.data!.result!.indexOf(i) == 0)
                                                SizedBox(
                                                    height: _getController.height.value * 0.37,
                                                    width: _getController.width.value,
                                                    child: ListView.builder(
                                                        padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                                        itemCount: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result!.length,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return ProductItem(
                                                            imageUrl: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].image!,
                                                            title: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].name!,
                                                            price: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].price.toString(),
                                                            function: () {
                                                              _getController.page.value = 1;
                                                              _getController.productModelLength.value = 0;
                                                              _getController.clearProductModel();
                                                              _getController.clearProductDetailModel();
                                                              _getController.clearProductDetailList();
                                                              Get.to(() => DetailPage(
                                                                slug: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].slug!,
                                                                pageIndex: _getController.menuModel.value.data!.result!.indexOf(i),
                                                              ));
                                                            },
                                                            id: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].sId,
                                                            deck: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].name,
                                                            count: _getController.productModelList[_getController.menuModel.value.data!.result!.indexOf(i)].data!.result![index].count,
                                                          );
                                                        })),

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

