import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/home/category_page.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../companents/author_item.dart';
import '../companents/child_item.dart';
import '../companents/product_item.dart';
import '../companents/search_fild.dart';
import '../companents/skleton_child_item.dart';
import '../controllers/get_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../pages/home/author_category.dart';
import '../pages/home/author_detail.dart';
import '../pages/home/cat_detail_page.dart';
import '../pages/home/category.dart';
import '../pages/home/detail_page.dart';

class HomePage extends StatelessWidget {

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiController().getBanner(1,1);
    //ApiController().getProduct(1, 'badiiy-kitoblar',false);
    ApiController().getQuotation(1);
    ApiController().getTopProduct(1,false);
    ApiController().getAuthors(30,1,'Shayx muhammad sodiq',false);
    return Scaffold(
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: CustomHeader(
              builder: (BuildContext context, RefreshStatus? mode) {
                Widget body;
                if (mode == RefreshStatus.idle) {
                  body = const Text("Ma`lumotlarni yangilash uchun tashlang");
                } else if (mode == RefreshStatus.refreshing) {
                  body = const CircularProgressIndicator(color: Colors.blue, backgroundColor: Colors.white, strokeWidth: 2);
                } else if (mode == RefreshStatus.failed) {
                  body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
                } else if (mode == RefreshStatus.canRefresh) {
                  body = const Text("Ma`lumotlarni yangilash uchun tashlang");
                } else {
                  body = const Text("Ma`lumotlar yangilandi");
                }
                return SizedBox(height: _getController.height.value * 0.1, child: Center(child: body));
              }
            ),
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
                return SizedBox(height: _getController.height.value * 0.1, child: Center(child: body));
              }
            ),
            onLoading: () async {_refreshController.loadComplete();},
            onRefresh: () async {_refreshController.refreshCompleted();},
            controller: _refreshController,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                  width: _getController.width.value,
                  decoration: const BoxDecoration(color: AppColors.backgroundApp),
                  child: Obx(() => Column(
                    children: [
                      SizedBox(
                        height: 130.h,
                        child: Stack(
                          children: [
                            Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                            Positioned(top: 18.h, left: 0, right: 0, child: SearchFields(onChanged: (String ) {  },))
                          ]
                        )
                      ),
                      Container(
                        width: _getController.width.value,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                        child:Column(
                          children: [
                            if (_getController.bannerModel.value.data != null)
                              Container(
                                margin: EdgeInsets.only(top: 18.h, bottom: 25.h),
                                height: _getController.height.value * 0.17,
                                width: _getController.width.value,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: Theme.of(context).colorScheme.background),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 5),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal
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
                                )
                              )
                            else
                              Container(
                                margin: EdgeInsets.only(top: 18.h, bottom: 25.h),
                                height: _getController.height.value * 0.173,
                                width: _getController.width.value,
                                padding: EdgeInsets.all(_getController.width.value * 0.02),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                child: Skeletonizer(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), image: const DecorationImage(image: AssetImage('assets/images/oo1.png'), fit: BoxFit.fill))))
                              ),
                            if (_getController.menuModel.value.data != null)
                              ChildItem(
                                title: _getController.fullCheck == true ? _getController.menuModel.value.data!.result![_getController.fullIndex.value].title!.uz! : 'Kategoriya'.tr,
                                function: (){
                                  Get.to(() => Category());
                                })
                            else
                              SkeletonChildItem(),
                            if (_getController.menuModel.value.data != null)
                              Container(
                                  width: _getController.width.value,
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.01),
                                  child: Wrap(
                                    spacing: _getController.width.value * 0.02,
                                    runSpacing: _getController.height.value * 0.006,
                                    children: [
                                      for (var i in _getController.menuModel.value.data!.result!)
                                        InkWell(
                                          onTap: () {
                                            if (i.children == null) {
                                              Get.to(() => CatDetailPage(
                                                title: 'uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!,
                                                menuSlug: i.slug!,
                                                parent: false,
                                                menuIndex: _getController.menuModel.value.data!.result!.indexOf(i),
                                              ));
                                            }else {
                                              Get.to(() => CategoryPage(menuIndex: _getController.menuModel.value.data!.result!.indexOf(i)));
                                            }
                                          },
                                          child: Chip(
                                            visualDensity: VisualDensity.compact,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                            label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_OZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
                                            padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01, vertical: _getController.height.value * 0.008),
                                            labelPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.02),
                                            side: BorderSide(color: Theme.of(context).colorScheme.background, width: 0),
                                            backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.grey.withOpacity(0.5) : AppColors.grey.withOpacity(0.2),
                                            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 17.sp, fontWeight: FontWeight.w400),
                                          )
                                        )
                                    ]
                                  )
                              ),
                            if (_getController.menuModel.value.data != null)
                              SizedBox(height: _getController.height.value * 0.026),
                            if (_getController.menuModel.value.data != null)
                              ChildItem(title: 'Elektron kitoblar'.tr, function: (){
                                _getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                _getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                    title: 'Kitoblar'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                    parent: true,
                                    menuIndex: _getController.menuModel.value.data!.result!.indexOf(_getController.menuModel.value.data!.result![0]),
                                ));
                              }),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              SizedBox(
                                  height: 370.h,
                                  width: _getController.width.value,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.04),
                                      itemCount: _getController.productModel.value.data!.result!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ProductItem(
                                          imageUrl: _getController.productModel.value.data!.result![index].image,
                                          title: _getController.productModel.value.data!.result![index].name,
                                          price: _getController.productModel.value.data!.result![index].price.toString(),
                                          function: () {
                                            _getController.page.value = 1;
                                            _getController.productModelLength.value = 0;
                                            _getController.clearProductDetailModel();
                                            _getController.clearProductDetailList();
                                            Get.to(() => DetailPage(
                                              slug: _getController.productModel.value.data!.result![index].slug!,
                                              pageIndex: 0,
                                            ));
                                          },
                                          id: _getController.productModel.value.data!.result![index].sId,
                                          deck: _getController.productModel.value.data!.result![index].name,
                                          count: _getController.productModel.value.data!.result![index].count
                                      );
                                    })),
                            if (_getController.menuModel.value.data != null)
                              ChildItem(title: 'Audio kitoblar'.tr, function: (){
                                _getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                _getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                  title: 'Kitoblar'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                  parent: true,
                                  menuIndex: _getController.menuModel.value.data!.result!.indexOf(_getController.menuModel.value.data!.result![0]),
                                ));
                              }),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              SizedBox(
                                  height: 370.h,
                                  width: _getController.width.value,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.04),
                                      itemCount: _getController.productModel.value.data!.result!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ProductItem(
                                            imageUrl: _getController.productModel.value.data!.result![index].image,
                                            title: _getController.productModel.value.data!.result![index].name,
                                            price: _getController.productModel.value.data!.result![index].price.toString(),
                                            function: () {
                                              _getController.page.value = 1;
                                              _getController.productModelLength.value = 0;
                                              _getController.clearProductDetailModel();
                                              _getController.clearProductDetailList();
                                              Get.to(() => DetailPage(
                                                slug: _getController.productModel.value.data!.result![index].slug!,
                                                pageIndex: 0,
                                              ));
                                            },
                                            id: _getController.productModel.value.data!.result![index].sId,
                                            deck: _getController.productModel.value.data!.result![index].name,
                                            count: _getController.productModel.value.data!.result![index].count
                                        );
                                      })),
                            if (_getController.menuModel.value.data != null)
                              SizedBox(height: _getController.height.value * 0.02),
                            if (_getController.quotesModel.value.data != null && _getController.quotesModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: 'Iqtiboslar'.tr, function: (){})
                            else
                              SkeletonChildItem(),
                            if (_getController.quotesModel.value.data != null && _getController.quotesModel.value.data!.result!.isNotEmpty)
                              Container(
                              height: _getController.height.value * 0.23,
                              margin: EdgeInsets.only(top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.02),
                              width: _getController.width.value,
                              child: Swiper(
                                itemCount: _getController.quotesModel.value.data != null ? _getController.quotesModel.value.data!.result!.length : 0,
                                loop: true,
                                layout: SwiperLayout.STACK,
                                itemHeight: _getController.height.value * 0.3,
                                itemWidth: _getController.width.value * 0.93,
                                containerHeight: _getController.height.value * 0.3,
                                containerWidth: _getController.width.value * 0.93,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                axisDirection: AxisDirection.right,
                                curve: Curves.decelerate,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(left: _getController.width.value * 0.01,right: _getController.width.value * 0.01),
                                    width: _getController.width.value * 0.93,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.background, border: Border.all(color: AppColors.grey, width: 0.9)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, top: _getController.height.value * 0.01),
                                          child: Text('uz_UZ' == Get.locale.toString() ? _getController.quotesModel.value.data!.result![index].name!.uz! : 'oz_OZ' == Get.locale.toString() ? _getController.quotesModel.value.data!.result![index].name!.oz! : _getController.quotesModel.value.data!.result![index].name!.ru!, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600)),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        if (_getController.quotesModel.value.data!.result![index].product != null && _getController.quotesModel.value.data!.result![index].product!.name != null)
                                        Padding(
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, top: _getController.height.value * 0.01,bottom: _getController.height.value * 0.01),
                                          child: Text('uz_UZ' == Get.locale.toString() ? _getController.quotesModel.value.data!.result![index].product!.name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.quotesModel.value.data!.result![index].product!.name!.oz! : _getController.quotesModel.value.data!.result![index].product!.name!.ru!, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold)),
                                        )
                                      ]
                                    )
                                  );
                                }
                              )
                            ),
                            if (_getController.authorModel.value.data != null && _getController.authorModel.value.data!.result!.isNotEmpty)
                              ChildItem(title: 'Mualliflar'.tr, function: (){
                                _getController.clearAuthorModel();
                                Get.to(() => AuthorCategory());
                              }),
                            if (_getController.authorModel.value.data != null && _getController.authorModel.value.data!.result!.isNotEmpty)
                              SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.authorModel.value.data != null && _getController.authorModel.value.data!.result!.isNotEmpty)
                              for (int i = 0; i < _getController.authorModel.value.data!.result!.length; i++)
                                if (i < 3)
                                  AuthorItem(
                                      sId: _getController.authorModel.value.data!.result![i].sId.toString(),
                                      title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.oz.toString() : _getController.authorModel.value.data!.result![i].name!.ru.toString(),
                                      subTitle: _getController.authorModel.value.data!.result![i].productCount!.toString(),
                                      image: _getController.authorModel.value.data!.result![i].image!.toString(),
                                      onTap: () {
                                        debugPrint(_getController.authorModel.value.data!.result![i].name!.uz.toString());
                                        _getController.clearAuthorDetailList();
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetail(title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.oz.toString() : _getController.authorModel.value.data!.result![i].name!.ru.toString(), sId: _getController.authorModel.value.data!.result![i].sId.toString(), index: 0)));
                                        Get.to(
                                            () => AuthorDetail(
                                              sId: _getController.authorModel.value.data!.result![i].sId.toString(),
                                              title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![i].name!.oz.toString() : _getController.authorModel.value.data!.result![i].name!.ru.toString(),
                                              index: 0
                                            )
                                        );
                                      },
                                      index: 0
                                  ),
                            if (_getController.menuModel.value.data != null)
                              SizedBox(height: _getController.height.value * 0.015),
                            if (_getController.menuModel.value.data != null)
                              ChildItem(title: '${'Top'.tr} ${'Kitoblar'.tr}', function: (){
                                _getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                _getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                  title: 'Kitoblar'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                  parent: true,
                                  menuIndex: 0
                                ));
                              }),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  _getController.page.value = 1;
                                  _getController.productModelLength.value = 0;
                                  _getController.clearProductDetailModel();
                                  _getController.clearProductDetailList();
                                  Get.to(() => DetailPage(
                                      slug: _getController.productModel.value.data!.result![0].slug!,
                                      pageIndex: 0
                                  ));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: 8.h, bottom: 15.h, left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                    height: _getController.height.value * 0.158,
                                    width: _getController.width.value,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).colorScheme.onBackground),
                                    child: Stack(
                                        children: [
                                          Positioned(
                                              left: 0,
                                              width: _getController.width.value * 0.6,
                                              height: _getController.height.value * 0.158,
                                              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), bottomLeft: Radius.circular(10.r)), color: AppColors.primaryColor))
                                          ),
                                          Positioned(
                                              right: 0,
                                              width: _getController.width.value * 0.42,
                                              height: _getController.height.value * 0.158,
                                              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r)), image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![0].image!), fit: BoxFit.cover))
                                              )
                                          ),
                                          Positioned(
                                            left: _getController.width.value * 0.47,
                                            width: _getController.width.value * 0.1,
                                            height: _getController.height.value * 0.158,
                                            child: Image.asset('assets/images/rectangle.png', fit: BoxFit.fill),
                                          ),
                                          Positioned(
                                              width: _getController.width.value * 0.96,
                                              height: _getController.height.value * 0.158,
                                              child: Center(
                                                  child: Container(
                                                      margin: EdgeInsets.only(left: _getController.width.value * 0.08),
                                                      decoration: BoxDecoration(image: DecorationImage(image: Image.asset('assets/images/frame.png').image, fit: BoxFit.none)),
                                                      child: Center(child: Text('1', style: TextStyle(fontSize: _getController.width.value * 0.035, fontWeight: FontWeight.w600, color: AppColors.element)))
                                                  )
                                              )
                                          ),
                                          Positioned(
                                              left: _getController.width.value * 0.03,
                                              height: _getController.height.value * 0.158,
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 20.h),
                                                    SizedBox(width: _getController.width.value * 0.44, child: Text(maxLines: 1, overflow: TextOverflow.ellipsis, _getController.productModel.value.data!.result![0].name!, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white)))
                                                  ]
                                              )
                                          )
                                        ]
                                    )
                                )
                              ),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty && _getController.productModel.value.data!.result!.length > 3)
                              for (var i in _getController.productModel.value.data!.result!.sublist(1, 3))
                                InkWell(
                                  onTap: () {
                                    _getController.page.value = 1;
                                    _getController.productModelLength.value = 0;
                                    _getController.clearProductDetailModel();
                                    _getController.clearProductDetailList();
                                    Get.to(() => DetailPage(
                                        slug: _getController.productModel.value.data!.result![_getController.productModel.value.data!.result!.indexOf(i)].slug!,
                                        pageIndex: 0
                                    ));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: _getController.width.value * 0.03,
                                          right: _getController.width.value * 0.03,
                                          bottom: _getController.height.value * 0.015),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: Theme.of(context).colorScheme.background, boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1), offset: const Offset(1, 2), blurRadius: 3, spreadRadius: 1)]),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          if (i.image != null)
                                            SizedBox(
                                                width: _getController.width.value * 0.2,
                                                height: _getController.height.value * 0.095,
                                                child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 0,
                                                        width: _getController.width.value * 0.2,
                                                        height: _getController.height.value * 0.09,
                                                        child: SizedBox(
                                                            width: _getController.width.value * 0.2,
                                                            height: _getController.height.value * 0.09,
                                                            child: Image.asset('assets/images/rectangle.png', fit: BoxFit.none)
                                                        ),
                                                      ),
                                                      Positioned(
                                                          right: 0,
                                                          width: _getController.width.value * 0.2,
                                                          height: _getController.height.value * 0.09,
                                                          child: Center(
                                                              child: Container(
                                                                  padding: EdgeInsets.all(_getController.height.value * 0.01),
                                                                  child: Image.asset('assets/images/frame.png', fit: BoxFit.cover)
                                                              )
                                                          )
                                                      ),
                                                      Positioned(
                                                          width: _getController.width.value * 0.2,
                                                          height: _getController.height.value * 0.086,
                                                          child: Center(
                                                              child: Text(
                                                                  '${_getController.productModel.value.data!.result!.indexOf(i) + 1}',
                                                                  style: TextStyle(
                                                                      fontSize: _getController.width.value * 0.03,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: AppColors.element
                                                                  )
                                                              )
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),
                                          Expanded(
                                            child: Text(
                                                i.name.toString(),
                                                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground)),
                                          )
                                        ],
                                      )
                                  )
                                ),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty && _getController.productModel.value.data!.result!.length > 3)
                              SizedBox(height: _getController.height.value * 0.01),
                            if (_getController.menuModel.value.data != null)
                              ChildItem(title: 'Do‘kon mahsulotlari'.tr, function: (){
                                _getController.page.value = 1;
                                _getController.productModelLength.value = 0;
                                _getController.clearProductModel();
                                Get.to(() => CatDetailPage(
                                  title: 'Do‘kon mahsulotlari'.tr, menuSlug: _getController.menuModel.value.data!.result![0].slug!,
                                  parent: true, menuIndex: 0
                                ));
                              }),
                            if (_getController.productModel.value.data != null && _getController.productModel.value.data!.result!.isNotEmpty)
                              SizedBox(
                                  height: 370.h,
                                  width: _getController.width.value,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.04),
                                      itemCount: _getController.productModel.value.data!.result!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ProductItem(
                                            imageUrl: _getController.productModel.value.data!.result![index].image,
                                            title: _getController.productModel.value.data!.result![index].name,
                                            price: _getController.productModel.value.data!.result![index].price.toString(),
                                            function: () {
                                              _getController.page.value = 1;
                                              _getController.productModelLength.value = 0;
                                              _getController.clearProductDetailModel();
                                              _getController.clearProductDetailList();
                                              Get.to(() => DetailPage(
                                                slug: _getController.productModel.value.data!.result![index].slug!,
                                                pageIndex: 0
                                              ));
                                              },
                                            id: _getController.productModel.value.data!.result![index].sId,
                                            deck: _getController.productModel.value.data!.result![index].name,
                                            count: _getController.productModel.value.data!.result![index].count
                                        );
                                      })
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