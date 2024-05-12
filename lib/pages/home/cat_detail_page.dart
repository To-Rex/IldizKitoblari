import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:ildiz/pages/shop/filter_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'detail_page.dart';

class CatDetailPage extends StatelessWidget {
  var title;
  var menuSlug;
  var parent;
  var menuIndex;

  CatDetailPage({super.key, required this.title, required this.menuSlug, required this.parent, required this.menuIndex});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void showBottomSheet(BuildContext context) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                height: _getController.height.value * 0.45,
                child: Container(
                    height: _getController.height.value * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.03),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: _getController.width.value * 0.03, width: _getController.width.value),
                          Container(
                            height: _getController.width.value * 0.01,
                            width: _getController.width.value,
                            margin: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.42),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3), borderRadius: BorderRadius.circular(100))
                          ),
                          SizedBox(height: _getController.width.value * 0.08, width: _getController.width.value),
                          Text('Saralash'.tr, style: TextStyle(fontSize: _getController.width.value * 0.055, fontWeight: FontWeight.w600)),
                          SizedBox(height: _getController.width.value * 0.03),
                          for (int i = 0; i < _getController.filters.length; i++)
                            Column(
                                children: [
                                  GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        _getController.changeFilterIndex(i);
                                        setState(() {
                                          if (!parent) {
                                            ApiController().getProduct(1, menuSlug, false,
                                                _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                                                _getController.filters[4] == true ? true : null,
                                                _getController.filters[5] == true ? true : null,
                                                _getController.filters[0] == true ? 1 : -1
                                            );
                                          } else {
                                            //ApiController().getSelectProduct(1, menuSlug, false);
                                            ApiController().getSelectProduct(1, menuSlug, false,
                                                _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                                                _getController.filters[4] == true ? true : null,
                                                _getController.filters[5] == true ? true : null,
                                                _getController.filters[0] == true ? 1 : -1
                                            );
                                          }
                                        });
                                      },
                                      child: Row(
                                          children: [
                                            if (_getController.filters[i])
                                              Container(
                                                  margin: EdgeInsets.only(right: _getController.width.value * 0.02),
                                                  width: _getController.width.value * 0.015,
                                                  height: _getController.width.value * 0.015,
                                                  decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(100))
                                              ),
                                            Text(
                                                i == 0 ? 'Nomi (A - Z)' : i == 1 ? 'Nomi (Z - A)' : i == 2 ? 'Avval arzonlari' : i == 3 ? 'Avval qimmatlari' : i == 4 ? 'Yangisidan boshlab' : 'Top mahsulotdan boshlab',
                                                style: TextStyle(fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w500, color: _getController.filters[i] ? AppColors.primaryColor : Theme.of(context).colorScheme.onBackground)
                                            )
                                          ]
                                      )
                                  ),
                                  SizedBox(height: _getController.width.value * 0.02),
                                  if (i == 1 || i == 3) const Divider(),
                                ]
                            )
                        ]
                    )
                )
              );
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    _getController.filters.clear();
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);
    _getController.filters.add(false);

    if (!parent) {
      ApiController().getProduct(1, menuSlug, false,null,null,null,null);
    } else {
      ApiController().getSelectProduct(1, menuSlug, false,null,null,null,null);
    }

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
        body: Obx(() => Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.01),
                child: Row(
                    children: [
                      Expanded(child: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500))),
                      InkWell(
                          onTap: () {
                            showBottomSheet(context);
                          },
                          child: Container(
                          width: _getController.width.value * 0.05,
                          height: _getController.width.value * 0.05,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.background,),
                          child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)))),
                      IconButton(
                          onPressed: () {
                            Get.to(() => FilterPage(
                                menuIndex: menuIndex, menuSlug: menuSlug), transition: Transition.topLevel);
                          },
                          icon: Icon(
                            TablerIcons.adjustments_horizontal,
                            size: _getController.width.value * 0.06,
                            color: Theme.of(context).colorScheme.onBackground,
                          )
                      )
                    ]
                )
            ),
            if (_getController.productModelLength.value == 0)
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.71,
                      children: List.generate(8, (index) {
                        return SkeletonItem();
                      })
                  )
              ),
            if (_getController.productModelLength.value != 0)
              Expanded(
                  child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const ClassicHeader(),
                      footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = const SizedBox();
                            } else if (mode == LoadStatus.loading) {
                              body = const CircularProgressIndicator(
                                  color: Colors.blue,
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2);
                            } else if (mode == LoadStatus.failed) {
                              body = const Text("Ex nimadir xato ketdi", style: TextStyle(fontSize: 14, color: Colors.red));
                            } else if (mode == LoadStatus.canLoading) {body = const SizedBox();
                            } else {body = const Text("Ma`lumotlar yangilandi", style: TextStyle(fontSize: 14, color: Colors.black));}
                            return SizedBox(
                                height: _getController.height.value * 0.1,
                                child: Center(child: body));
                          }
                      ),
                      onLoading: () async {
                        if (!parent) {
                          ApiController().getProduct(_getController.page.value + 1, menuSlug, true,
                              _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                              _getController.filters[4] == true ? true : null,
                              _getController.filters[5] == true ? true : null,
                              _getController.filters[0] == true ? 1 : -1
                          ).then((value) => _refreshController.loadComplete());
                        } else {
                          ApiController().getSelectProduct(_getController.page.value + 1, menuSlug, true,
                              _getController.filters[2] == true ? 1 : _getController.filters[3] == true ? -1 : null,
                              _getController.filters[4] == true ? true : null,
                              _getController.filters[5] == true ? true : null,
                              _getController.filters[0] == true ? 1 : -1
                          ).then((value) => _refreshController.loadComplete());}
                      },
                      onRefresh: () async {
                        _getController.page.value = 1;
                        if (!parent) {
                          ApiController().getProduct(1, menuSlug, false,null,null,null,null).then((value) => _refreshController.refreshCompleted());
                        } else {
                          _getController.page.value = 1;
                          _getController.productModelLength.value = 0;
                          _getController.clearProductModel();
                          ApiController().getSelectProduct(1, menuSlug, false,null,null,null,null).then((value) => _refreshController.refreshCompleted());}
                      },
                      physics: const BouncingScrollPhysics(),
                      controller: _refreshController,
                      child: Container(
                        margin: EdgeInsets.only(left: _getController.width.value * 0.04),
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.07,
                              mainAxisExtent: 330.h,
                              mainAxisSpacing: _getController.height.value * 0.018,
                              crossAxisSpacing: _getController.width.value * 0.03,
                            ),
                            itemCount: _getController.productModelLength.value,
                            itemBuilder: (context, index) {
                              return ProductItem(
                                id: _getController.productModel.value.data!.result![index].sId!,
                                title: _getController.productModel.value.data!.result![index].name!,
                                deck: _getController.productModel.value.data!.result![index].slug!,
                                price: _getController.productModel.value.data!.result![index].price!.toString(),
                                imageUrl: _getController.productModel.value.data!.result![index].image ?? '',
                                count: _getController.productModel.value.data!.result![index].count ?? 0,
                                function: () {
                                  _getController.clearProductDetailModel();
                                  _getController.clearProductDetailList();
                                  Get.to(() => DetailPage(slug: _getController.productModel.value.data!.result![index].slug!, pageIndex: 0));},
                              );
                            })
                      )
                  )
              )
            ]
          )
        )
    );
  }
}
