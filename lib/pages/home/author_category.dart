import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/author_item.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import 'author_detail.dart';
import 'detail_page.dart';

class AuthorCategory extends StatelessWidget {
  AuthorCategory({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void onChanged(String value) {
    ApiController().getAuthors(
        15,
        _getController.page.value,
        value,
        false);
  }

  @override
  Widget build(BuildContext context) {
    _getController.page.value = 1;
    ApiController().getAuthors(15,_getController.page.value,'',false);
    return Scaffold(
      appBar: AppBar(
          title: Text('Mualliflar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
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
                    Expanded(child: Text('Mualliflar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05,fontWeight: FontWeight.w500))),
                    InkWell(
                        onTap: () {},
                        child: Container(
                            width: _getController.width.value * 0.05,
                            height: _getController.width.value * 0.05,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.background),
                            child: SvgPicture.asset('assets/icon/sort.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn)))),
                    IconButton(
                      onPressed: () {
                        _getController.addPage();
                        },
                      icon: Icon(
                        TablerIcons.adjustments_horizontal,
                        size: _getController.width.value * 0.06,
                        color: Theme.of(context).colorScheme.onBackground
                      )
                    )
                  ]
              )),
          SizedBox(height: _getController.height.value * 0.01),
          Padding(
              padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
              child: Container(
                  height: _getController.height.value * 0.055,
                  padding: EdgeInsets.only(right: _getController.width.value * 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.17),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: TextField(
                      controller: _getController.searchController,
                      onChanged: onChanged,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: 'Kitoblarni izlash'.tr,
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              fontSize: _getController.width.value * 0.04
                          ),
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(_getController.height.value * 0.013),
                              child: SvgPicture.asset(
                                  'assets/icon/search.svg',
                                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface.withOpacity(0.6), BlendMode.srcIn)
                              )
                          ),
                          border: InputBorder.none
                      )
                  )
              )),

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
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetail(title: 'uz_UZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![index].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorModel.value.data!.result![index].name!.oz.toString() : _getController.authorModel.value.data!.result![index].name!.ru.toString(), sId: _getController.authorModel.value.data!.result![index].sId.toString(), index: 0)));
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
                ))

        ],
      ))
    );
  }
}
