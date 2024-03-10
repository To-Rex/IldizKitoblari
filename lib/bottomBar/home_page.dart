import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/home/category_page.dart';
import 'package:ildiz/resource/colors.dart';
import '../companents/child_item.dart';
import '../companents/product_item.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../pages/home/cat_detail_page.dart';

class HomePage extends StatelessWidget {

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiController().getBanner(1,1);
    ApiController().getProduct(1, 'badiiy-kitoblar',false);
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
                        height: _getController.height.value * 0.14,
                        child: Stack(
                          children: [
                            Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                            Positioned(top: _getController.height.value * 0.018, left: 0, right: 0, child: SearchFields())
                          ],
                        ),
                      ),
                      Container(
                        width: _getController.width.value,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),),
                        child:Column(
                          children: [
                            if (_getController.bannerModel.value.data != null)
                              Container(
                                margin: EdgeInsets.only(top: _getController.height.value * 0.018, bottom: _getController.height.value * 0.02),
                                height: _getController.height.value * 0.173,
                                width: _getController.width.value,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context).colorScheme.background,
                                ),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 5),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: [
                                    for (var i in _getController.bannerModel.value.data!.result!)
                                      if ('uz_UZ' == Get.locale.toString() && i.imageUz != '')
                                        Container(
                                          width: _getController.width.value * 0.93,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: Theme.of(context).colorScheme.onBackground,
                                            image: DecorationImage(
                                              image: NetworkImage(i.imageUz!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      else if ('oz_OZ' == Get.locale.toString() && i.imageOz != '')
                                        Container(
                                          width: _getController.width.value * 0.93,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: Theme.of(context).colorScheme.onBackground,
                                            image: DecorationImage(
                                              image: NetworkImage(i.imageOz!),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      else if ('ru_RU' == Get.locale.toString() && i.imageRu != '')
                                          Container(
                                            width: _getController.width.value * 0.93,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: Theme.of(context).colorScheme.onBackground,
                                              image: DecorationImage(
                                                image: NetworkImage(i.imageRu!),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ChildItem(
                                title: _getController.fullCheck == true ? _getController.menuModel.value.data!.result![_getController.fullIndex.value].title!.uz! : 'Kategoriya'.tr,
                                function: (){}),
                            if (_getController.menuModel.value.data != null)
                              SizedBox(
                                  width: _getController.width.value * 0.93,
                                  child: Wrap(
                                    spacing: _getController.width.value * 0.02,
                                    children: [
                                      for (var i in _getController.menuModel.value.data!.result!)
                                        InkWell(
                                          onTap: () {
                                            if (i.children == null) {
                                              Get.to(() => CatDetailPage(title: 'uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!, menuSlug: i.slug!));
                                            }else {
                                              Get.to(() => CategoryPage(menuIndex: _getController.menuModel.value.data!.result!.indexOf(i)));
                                            }
                                          },
                                          child: Chip(
                                            visualDensity: VisualDensity.compact,
                                            label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
                                            padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01, vertical: _getController.height.value * 0.007),
                                            labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                            side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                                            backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                    ],
                                  )
                              ),
                            ChildItem(title: 'Elektron kitoblar'.tr, function: (){}),
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
                                    }
                                ),
                              ),
                            ChildItem(title: 'Iqtiboslar'.tr, function: (){}),
                            //swiper view for quotes
                            SizedBox(
                              height: _getController.height.value * 0.2,
                              width: _getController.width.value,
                              child: Swiper(
                                itemCount: 10,
                                loop: true,
                                layout: SwiperLayout.STACK,
                                itemHeight: _getController.height.value * 0.2,
                                itemWidth: _getController.width.value * 0.93,
                                scrollDirection: Axis.horizontal,
                                axisDirection: AxisDirection.right,
                                curve: Curves.decelerate,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(left: _getController.width.value * 0.01),
                                    width: _getController.width.value * 0.93,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).colorScheme.background,
                                      border: Border.all(color: AppColors.grey, width: 0.9),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.03, vertical: _getController.height.value * 0.01),
                                          child: Text(
                                            'salom',
                                            style: TextStyle(fontSize: _getController.width.value * 0.04, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))
              ),
            )
        )
    );
  }
}