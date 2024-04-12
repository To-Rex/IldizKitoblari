import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/author_item.dart';
import '../../companents/product_item.dart';
import '../../companents/scleton_item.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';
import 'detail_page.dart';

class AuthorCategory extends StatelessWidget {
  AuthorCategory({super.key});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    ApiController().getAuthors(30,1,'');
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
                    },
                    onRefresh: () async {
                      _refreshController.refreshCompleted();
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: _refreshController,
                    child: ListView.builder(
                        itemCount: _getController.authorModel.value.data!.result!.length,
                        itemBuilder: (context, index) {
                          return AuthorItem(
                            sId: _getController.authorModel.value.data!.result![index].sId.toString(),
                            title: 'uz_UZ' == Get.locale.toString()
                                ? _getController.authorModel.value.data!.result![index].name!.uz.toString()
                                : 'oz_OZ' == Get.locale.toString()
                                ? _getController.authorModel.value.data!.result![index].name!.oz.toString()
                                : _getController.authorModel.value.data!.result![index].name!.ru.toString(),
                            subTitle: _getController.authorModel.value.data!.result![index].productCount!.toString(),
                            image: _getController.authorModel.value.data!.result![index].image!.toString(),
                            onTap: () {
                              debugPrint(_getController.authorModel.value.data!.result![index].name!.uz.toString());
                            }
                          );
                        }
                    )
                ))

        ],
      ))
    );
  }
}
