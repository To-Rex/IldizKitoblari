import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/author_item.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../companents/search_fild.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import 'author_detail.dart';
import 'detail_page.dart';

class AuthorCategory extends StatelessWidget {
  AuthorCategory({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void onChanged(String value) {
    ApiController().getAuthors(15, _getController.page.value, value, false);
  }

  @override
  Widget build(BuildContext context) {
    _getController.page.value = 1;
    ApiController().getAuthors(15,_getController.page.value,'',false);
    return Scaffold(
      appBar: AppBar(
          title: Text('Mualliflar'.tr, style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 25.sp),
            onPressed: () {
              Get.back();
            }
          )
      ),
      body: Obx(() => Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.01),
              child: Row(
                  children: [
                    Expanded(child: Text('Mualliflar'.tr, style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w500))),
                    InkWell(
                        onTap: () {},
                        child: Container(
                            width: 25.sp,
                            height: 25.sp,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.surface),
                            child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)))),
                    IconButton(
                      onPressed: () {
                        _getController.addPage();
                      },
                      icon: Icon(
                        TablerIcons.adjustments_horizontal,
                        size: 25.sp,
                        color: Theme.of(context).colorScheme.onSurface
                      )
                    )
                  ]
              )
          ),
          SizedBox(height: _getController.height.value * 0.01),
          Container(
              height: _getController.height.value * 0.055,
              margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
              child: TextField(
                  controller: _getController.searchController,
                  onChanged: onChanged,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(13)),
                      hintText: 'Kitoblarni izlash'.tr,
                      fillColor: AppColors.grey.withOpacity(0.2),
                      hintStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 18.sp
                      ),
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(_getController.height.value * 0.013),
                          child: SvgPicture.asset(
                              'assets/icon/search.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface.withOpacity(0.6), BlendMode.srcIn)
                          )
                      )
                  )
              )
          ),
          if (_getController.authorModel.value.data != null)
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
                      ApiController().getAuthors(15,_getController.itemPage.value,'',true);
                      debugPrint('item count: ${_getController.productModelLength.value}');
                    },
                    onRefresh: () async {
                      debugPrint('refresh');
                      _refreshController.refreshCompleted();
                      ApiController().getAuthors(15,_getController.itemPage.value,'',false);
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: _refreshController,
                    child: ListView.builder(
                        itemCount: _getController.productModelLength.value,
                        itemBuilder: (context, index) {
                          return AuthorItem(
                            sId: _getController.authorModel.value.data!.result![index].sId.toString(),
                            title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![index].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![index].name!.oz.toString() : _getController.authorModel.value.data!.result![index].name!.ru.toString(),
                            subTitle: _getController.authorModel.value.data!.result![index].productCount!.toString(),
                            image: _getController.authorModel.value.data!.result![index].image!.toString(),
                            onTap: () {
                              debugPrint(_getController.authorModel.value.data!.result![index].name!.uz.toString());
                              Get.to(() => AuthorDetail(
                                sId: _getController.authorModel.value.data!.result![index].sId.toString(),
                                title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![index].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![index].name!.oz.toString() : _getController.authorModel.value.data!.result![index].name!.ru.toString(),
                                index: 0,
                              ));
                            },
                            index: 0
                          );
                        }
                    )
                )
            )
        ]
      ))
    );
  }
}
