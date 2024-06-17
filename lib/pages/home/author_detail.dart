import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/author_item.dart';
import '../../companents/child_item.dart';
import '../../companents/product_item.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'author_category.dart';
import 'detail_page.dart';

class AuthorDetail extends StatelessWidget {
  String sId;
  String title;
  int index;
  AuthorDetail({super.key, required this.sId, required this.index, required this.title});

  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    if (index == 0) _getController.clearAuthorDetailList();
    ApiController().getAuthorDetail(sId);
                                    //limit,page,search,add,id
    debugPrint('sId: $sId');
    ApiController().getAuthorsProducts(3, 1, '', false, sId);
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
            _refreshController.loadComplete();
          },
          controller: _refreshController,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() => _getController.authorDetailModelList.isNotEmpty
                  ? Column(
                  children: [
                    SizedBox(height: _getController.height.value * 0.01),
                    if (_getController.authorDetailModelList[index].data!.image == null || _getController.authorDetailModelList[index].data!.image == '')
                      CircleAvatar(
                          radius: _getController.width.value * 0.14,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Text('uz_UZ' == Get.locale.toString()
                              ? _getController.authorDetailModelList[index].data!.name!.uz!.toUpperCase().substring(0,1)
                              : 'oz_OZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.name!.oz!.toUpperCase().substring(0,2)
                              : _getController.authorDetailModelList[index].data!.name!.ru!.toUpperCase().substring(0,2),
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.1, fontWeight: FontWeight.bold),
                          )
                      )
                    else
                      Center(
                          child: CircleAvatar(
                              radius: _getController.width.value * 0.14,
                              backgroundImage: Image.network(
                                  _getController.authorDetailModelList[index].data!.image.toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return SizedBox(
                                        width: _getController.width.value * 0.15,
                                        height: _getController.width.value * 0.15,
                                        child: Skeletonizer(child: Container(width: _getController.width.value * 0.15, height: _getController.width.value * 0.15, color: AppColors.grey))
                                    );
                                  }
                              ).image
                          )
                      ),
                    SizedBox(height: _getController.height.value * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: _getController.width.value * 0.05, right: _getController.width.value * 0.05),
                      child:  Center(
                          child: Text(
                            maxLines: 3,
                              textAlign: TextAlign.center,
                              'uz_UZ' == Get.locale.toString()
                                  ? _getController.authorDetailModelList[index].data!.name!.uz!
                                  : 'oz_OZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.name!.oz!
                                  : _getController.authorDetailModelList[index].data!.name!.ru!,
                              style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500))
                      ),
                    ),
                    SizedBox(height: _getController.height.value * 0.01),
                    if (_getController.authorDetailModelList[index].data!.content != null)
                      Padding(
                        padding: EdgeInsets.only(left: _getController.width.value * 0.04, right: _getController.width.value * 0.04),
                        child:  Center(
                            child: Text(
                                textAlign: TextAlign.start,
                                'uz_UZ' == Get.locale.toString()
                                    ? _getController.authorDetailModelList[index].data!.content!.uz!
                                    : 'oz_OZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.content!.oz!
                                    : _getController.authorDetailModelList[index].data!.content!.ru!,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                    fontSize: _getController.width.value * 0.04,
                                    fontWeight: FontWeight.w500))
                        ),
                      ),
                    SizedBox(height: _getController.height.value * 0.01),
                    if (_getController.menuModel.value.data != null)
                      if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                        ChildItem(title: 'Muallif kitoblari'.tr, function: (){
                          _getController.clearAuthorModel();
                          Get.to(() => AuthorCategory());
                        }),
                    //if (_getController.productModel.value.data != null)
                    if (_getController.authorDetailProductModelList.isNotEmpty)
                      SizedBox(
                          height: 370.h,
                          width: _getController.width.value,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                              itemCount: _getController.authorDetailProductModelList[0].data!.result?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ProductItem(
                                    imageUrl: _getController.authorDetailProductModelList[0].data!.result![index].image.toString(),
                                    title: _getController.authorDetailProductModelList[0].data!.result![index].name.toString(),
                                    price: _getController.authorDetailProductModelList[0].data!.result![index].price.toString(),
                                    function: () {
                                      _getController.page.value = 1;
                                      _getController.productModelLength.value = 0;
                                      _getController.clearProductDetailModel();
                                      _getController.clearProductDetailList();
                                      Get.to(() => DetailPage(
                                        slug: _getController.authorDetailProductModelList[0].data!.result![index].slug.toString(),
                                        pageIndex: 0,
                                      ));
                                    },
                                    id: _getController.authorDetailProductModelList[0].data!.result![index].sId.toString(),
                                    deck: _getController.authorDetailProductModelList[0].data!.result![index].name.toString(),
                                    count: _getController.authorDetailProductModelList[0].data!.count
                                );
                              })),
                    if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                      ChildItem(title: 'Mualliflar'.tr, function: (){
                        _getController.clearAuthorModel();
                        Get.to(() => AuthorCategory());
                      }),
                    if(index<1)
                      if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                        SizedBox(height: _getController.height.value * 0.01),
                    if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                      for (int i = 0; i < _getController.authorDetailModelList[index].data!.similarAuthors!.length; i++)
                        AuthorItem(
                            sId: _getController.authorDetailModelList[index].data!.similarAuthors![i].sId.toString(),
                            title: 'uz_UZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.uz.toString() : 'oz_OZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.oz.toString() : _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.ru.toString(),
                            subTitle: _getController.authorDetailModelList[index].data!.similarAuthors![i].productCount!.toString(),
                            image: _getController.authorDetailModelList[index].data!.similarAuthors![i].image!.toString(),
                            onTap: () {
                              _getController.removeAuthorDetailModel(index + 1);
                              debugPrint('similarAuthors: ${_getController.authorDetailModelList[index].data!.similarAuthors![i].sId.toString()}');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorDetail(
                                  sId: _getController.authorDetailModelList[index].data!.similarAuthors![i].sId.toString(),
                                  title: _getController.authorDetailModelList[index].data!.similarAuthors![i].name!.uz.toString(),
                                  index: index + 1
                              )));
                            },
                            index: index + 1
                        ),
                    if (_getController.authorDetailModelList[index].data!.similarAuthors != null && _getController.authorDetailModelList[index].data!.similarAuthors!.isNotEmpty)
                      SizedBox(height: _getController.height.value * 0.01),
                  ])
                  : const Center(child: CircularProgressIndicator()))
          )
      ),
    );
  }
}