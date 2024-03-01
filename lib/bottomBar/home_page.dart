import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/home/category_page.dart';
import 'package:ildiz/resource/colors.dart';
import '../companents/child_item.dart';
import '../companents/search_fild.dart';
import '../controllers/get_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {

  final GetController _getController = Get.put(GetController());

  HomePage({super.key});
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ApiController().getBanner();
    ApiController().getProduct(1, 'badiiy-kitoblar');
    /*return Scaffold(
        body: SingleChildScrollView(
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
                        Positioned(
                          child: SizedBox(
                            width: _getController.width.value,
                            child: SvgPicture.asset('assets/svgImages/shap.svg',
                                fit: BoxFit.fitWidth,
                                height: _getController.height.value * 0.2),
                          ),
                        ),
                        Positioned(
                          top: _getController.height.value * 0.018,
                            left: 0,
                            right: 0,
                            child: SearchFields()
                        )
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
                                  else if ('oz_UZ' == Get.locale.toString() && i.imageOz != '')
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
                            title: _getController.fullCheck == true ? _getController.menuModel.value.data!.result![_getController.fullIndex.value].title!.uz! : 'Kategoriya',
                            function: (){
                              print('Barchasi');
                            }),
                        if (_getController.menuModel.value.data != null)
                          SizedBox(
                              width: _getController.width.value * 0.93,
                              child: Wrap(
                                spacing: _getController.width.value * 0.02,
                                children: [
                                  for (var i in _getController.menuModel.value.data!.result!)
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => CategoryPage(
                                          menuIndex: _getController.menuModel.value.data!.result!.indexOf(i),
                                        ));
                                      },
                                      child: Chip(
                                        visualDensity: VisualDensity.compact,
                                        label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_UZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
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
                        ChildItem(title: 'Elektron kitoblar', function: (){
                          print('Barchasi');
                        }),
                        //horizontal list
                        if (_getController.productModel.value.data != null)
                          SizedBox(
                            height: _getController.height.value * 0.35,
                            width: _getController.width.value,
                            child: ListView.builder(
                                padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                itemCount: _getController.productModel.value.data!.result!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
                                    width: _getController.width.value * 0.44,
                                    //height: _getController.height.value * 0.25,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: _getController.width.value * 0.44,
                                          height: _getController.height.value * 0.205,
                                          margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.background,
                                            image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![index].image!), fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(child: Text(_getController.productModel.value.data!.result![index].name!.toString(), maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
                                        SizedBox(height: _getController.height.value * 0.006),
                                        SizedBox(
                                          child: Text(
                                            _getController.productModel.value.data!.result![index].menuSlug!.toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: _getController.width.value * 0.04,
                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: _getController.height.value * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              '${_getController.productModel.value.data!.result![index].price!} so\'m',
                                              style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                color: AppColors.primaryColor2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                print('Korzinka');
                                              },
                                              child: Icon(
                                                TablerIcons.shopping_cart_plus,
                                                size: _getController.width.value * 0.06,
                                                color: Theme.of(context).colorScheme.onBackground,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                        if (_getController.productModel.value.data != null)
                          SizedBox(
                            height: _getController.height.value * 0.35,
                            width: _getController.width.value,
                            child: ListView.builder(
                                padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                itemCount: _getController.productModel.value.data!.result!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
                                    width: _getController.width.value * 0.44,
                                    //height: _getController.height.value * 0.25,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: _getController.width.value * 0.44,
                                          height: _getController.height.value * 0.205,
                                          margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.background,
                                            image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![index].image!), fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(child: Text(_getController.productModel.value.data!.result![index].name!.toString(), maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
                                        SizedBox(height: _getController.height.value * 0.006),
                                        SizedBox(
                                          child: Text(
                                            _getController.productModel.value.data!.result![index].menuSlug!.toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: _getController.width.value * 0.04,
                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: _getController.height.value * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              '${_getController.productModel.value.data!.result![index].price!} so\'m',
                                              style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                color: AppColors.primaryColor2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                print('Korzinka');
                                              },
                                              child: Icon(
                                                TablerIcons.shopping_cart_plus,
                                                size: _getController.width.value * 0.06,
                                                color: Theme.of(context).colorScheme.onBackground,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                        if (_getController.productModel.value.data != null)
                          SizedBox(
                            height: _getController.height.value * 0.35,
                            width: _getController.width.value,
                            child: ListView.builder(
                                padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                itemCount: _getController.productModel.value.data!.result!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
                                    width: _getController.width.value * 0.44,
                                    //height: _getController.height.value * 0.25,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: _getController.width.value * 0.44,
                                          height: _getController.height.value * 0.205,
                                          margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Theme.of(context).colorScheme.background,
                                            image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![index].image!), fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(child: Text(_getController.productModel.value.data!.result![index].name!.toString(), maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
                                        SizedBox(height: _getController.height.value * 0.006),
                                        SizedBox(
                                          child: Text(
                                            _getController.productModel.value.data!.result![index].menuSlug!.toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: _getController.width.value * 0.04,
                                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: _getController.height.value * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              '${_getController.productModel.value.data!.result![index].price!} so\'m',
                                              style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                color: AppColors.primaryColor2,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                print('Korzinka');
                                              },
                                              child: Icon(
                                                TablerIcons.shopping_cart_plus,
                                                size: _getController.width.value * 0.06,
                                                color: Theme.of(context).colorScheme.onBackground,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ))
          ),
        )
    );*/
    return Scaffold(
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header:  CustomHeader(
              builder: (BuildContext context, RefreshStatus? mode) {
                return Container(
                  height: 80.0,
                  child: Center(
                    child: Image.asset('assets/images/men.png', width: 100.0, height: 100.0),
                  ),
                );
              },),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const SizedBox();
                } else if (mode == LoadStatus.loading) {
                  body = const CircularProgressIndicator(
                    color: Colors.blue,
                    backgroundColor: Colors.white,
                    strokeWidth: 2,
                  );
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
              await Future.delayed(const Duration(milliseconds: 1000));
              _refreshController.loadComplete();
            },
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 1000));
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
                                      else if ('oz_UZ' == Get.locale.toString() && i.imageOz != '')
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
                                title: _getController.fullCheck == true ? _getController.menuModel.value.data!.result![_getController.fullIndex.value].title!.uz! : 'Kategoriya',
                                function: (){
                                  print('Barchasi');
                                }),
                            if (_getController.menuModel.value.data != null)
                              SizedBox(
                                  width: _getController.width.value * 0.93,
                                  child: Wrap(
                                    spacing: _getController.width.value * 0.02,
                                    children: [
                                      for (var i in _getController.menuModel.value.data!.result!)
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => CategoryPage(
                                              menuIndex: _getController.menuModel.value.data!.result!.indexOf(i),
                                            ));
                                          },
                                          child: Chip(
                                            visualDensity: VisualDensity.compact,
                                            label: Text('uz_UZ' == Get.locale.toString() ? i.title!.uz! : 'oz_UZ' == Get.locale.toString() ? i.title!.oz! : i.title!.ru!),
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
                            ChildItem(title: 'Elektron kitoblar', function: (){
                              print('Barchasi');
                            }),
                            //horizontal list
                            if (_getController.productModel.value.data != null)
                              SizedBox(
                                height: _getController.height.value * 0.35,
                                width: _getController.width.value,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                    itemCount: _getController.productModel.value.data!.result!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
                                        width: _getController.width.value * 0.44,
                                        //height: _getController.height.value * 0.25,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: _getController.width.value * 0.44,
                                              height: _getController.height.value * 0.205,
                                              margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Theme.of(context).colorScheme.background,
                                                image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![index].image!), fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(child: Text(_getController.productModel.value.data!.result![index].name!.toString(), maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
                                            SizedBox(height: _getController.height.value * 0.006),
                                            SizedBox(
                                              child: Text(
                                                _getController.productModel.value.data!.result![index].menuSlug!.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: _getController.width.value * 0.04,
                                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: _getController.height.value * 0.01),
                                            Row(
                                              children: [
                                                Text(
                                                  '${_getController.productModel.value.data!.result![index].price!} so\'m',
                                                  style: TextStyle(
                                                    fontSize: _getController.width.value * 0.04,
                                                    color: AppColors.primaryColor2,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    print('Korzinka');
                                                  },
                                                  child: Icon(
                                                    TablerIcons.shopping_cart_plus,
                                                    size: _getController.width.value * 0.06,
                                                    color: Theme.of(context).colorScheme.onBackground,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ),
                            if (_getController.productModel.value.data != null)
                              SizedBox(
                                height: _getController.height.value * 0.35,
                                width: _getController.width.value,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                    itemCount: _getController.productModel.value.data!.result!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
                                        width: _getController.width.value * 0.44,
                                        //height: _getController.height.value * 0.25,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: _getController.width.value * 0.44,
                                              height: _getController.height.value * 0.205,
                                              margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Theme.of(context).colorScheme.background,
                                                image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![index].image!), fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(child: Text(_getController.productModel.value.data!.result![index].name!.toString(), maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
                                            SizedBox(height: _getController.height.value * 0.006),
                                            SizedBox(
                                              child: Text(
                                                _getController.productModel.value.data!.result![index].menuSlug!.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: _getController.width.value * 0.04,
                                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: _getController.height.value * 0.01),
                                            Row(
                                              children: [
                                                Text(
                                                  '${_getController.productModel.value.data!.result![index].price!} so\'m',
                                                  style: TextStyle(
                                                    fontSize: _getController.width.value * 0.04,
                                                    color: AppColors.primaryColor2,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    print('Korzinka');
                                                  },
                                                  child: Icon(
                                                    TablerIcons.shopping_cart_plus,
                                                    size: _getController.width.value * 0.06,
                                                    color: Theme.of(context).colorScheme.onBackground,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ),
                            if (_getController.productModel.value.data != null)
                              SizedBox(
                                height: _getController.height.value * 0.35,
                                width: _getController.width.value,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                                    itemCount: _getController.productModel.value.data!.result!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
                                        width: _getController.width.value * 0.44,
                                        //height: _getController.height.value * 0.25,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: _getController.width.value * 0.44,
                                              height: _getController.height.value * 0.205,
                                              margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Theme.of(context).colorScheme.background,
                                                image: DecorationImage(image: NetworkImage(_getController.productModel.value.data!.result![index].image!), fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(child: Text(_getController.productModel.value.data!.result![index].name!.toString(), maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
                                            SizedBox(height: _getController.height.value * 0.006),
                                            SizedBox(
                                              child: Text(
                                                _getController.productModel.value.data!.result![index].menuSlug!.toString(),
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: _getController.width.value * 0.04,
                                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: _getController.height.value * 0.01),
                                            Row(
                                              children: [
                                                Text(
                                                  '${_getController.productModel.value.data!.result![index].price!} so\'m',
                                                  style: TextStyle(
                                                    fontSize: _getController.width.value * 0.04,
                                                    color: AppColors.primaryColor2,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    print('Korzinka');
                                                  },
                                                  child: Icon(
                                                    TablerIcons.shopping_cart_plus,
                                                    size: _getController.width.value * 0.06,
                                                    color: Theme.of(context).colorScheme.onBackground,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
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