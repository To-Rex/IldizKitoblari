import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../companents/detail_element.dart';
import '../../companents/product_item.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatelessWidget {

  String slug;

  DetailPage({super.key, required this.slug});
  final GetController _getController = Get.put(GetController());
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    //ApiController().getProductDetail('aldanganlar');
    ApiController().getProductDetail(slug);
    _getController.fullIndex.value = 0;
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
          child: Stack(
            children: [
              Positioned(top: 0, left: 0, right: 0, bottom: 0,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Obx(() => _getController.productDetailModel.value.data != null && _getController.productRate.value.data != null
                      ? Column(
                      children: [
                        AppBar(
                          surfaceTintColor: Colors.transparent,
                          leading: IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Theme.of(context).colorScheme.onBackground,
                                  size: _getController.width.value * 0.065),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                          actions: [
                            IconButton(
                                icon: Icon(
                                    TablerIcons.share,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    size: _getController.width.value * 0.065),
                                onPressed: () {
                                }
                            ),
                            IconButton(
                                icon: Icon(
                                    TablerIcons.bookmark,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    size: _getController.width.value * 0.065),
                                onPressed: () {
                                }
                            )],
                        ),
                        if (_getController.productDetailModel.value.data?.images != null)
                        Container(
                          height: _getController.height.value * 0.427,
                          width: _getController.width.value,
                          margin: EdgeInsets.only(top: _getController.height.value * 0.01, left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                          child: Swiper(
                            onIndexChanged: (index) {
                              _getController.fullIndex.value = index;
                            },
                            controller: _getController.swiperController,
                            itemCount: int.parse(_getController.productDetailModel.value.data!.images!.length.toString()),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(image: NetworkImage(_getController.productDetailModel.value.data?.images![index].file ?? ''), fit: BoxFit.cover)
                                )
                              );
                            }
                          )
                        ),
                        Container(
                          height: _getController.height.value * 0.061,
                          width: _getController.width.value,
                          margin: EdgeInsets.only(top: _getController.height.value * 0.007),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _getController.productDetailModel.value.data?.images!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _getController.fullIndex.value = index;
                                  _getController.swiperController.move(index);
                                },
                                child: Obx(() => Container(
                                  margin: EdgeInsets.only(left: _getController.width.value * 0.03),
                                  width: _getController.width.value * 0.14,
                                  height: _getController.height.value * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                                      border: _getController.fullIndex.value == index ? Border.all(color: AppColors.primaryColor3, width: 1) : null,
                                      image: DecorationImage(image: NetworkImage(_getController.productDetailModel.value.data?.images![index].file ?? ''), fit: BoxFit.cover)
                                  ),
                                )),
                              );
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, top: _getController.height.value * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //_getController.productDetailModel.value.data?.name?.uz ?? '',
                                  'uz_UZ' == 'uz' ? _getController.productDetailModel.value.data?.name?.uz ?? '' : 'uz_UZ' == 'oz' ? _getController.productDetailModel.value.data?.name?.oz ?? '' : _getController.productDetailModel.value.data?.name?.ru ?? '',
                                  style: TextStyle(
                                    fontSize: _getController.width.value * 0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: _getController.height.value * 0.013),
                                if (_getController.productDetailModel.value.data != null)
                                Row(
                                    children: [
                                      if (_getController.productRate.value.data != null)
                                        DetailElement(
                                          title: _getController.productRate.value.data!.result!.average == null ? '0' : _getController.productRate.value.data!.result!.average.toString(),
                                          subTitle: '',
                                          icon: Icons.star,
                                        ),
                                      if (_getController.productRate.value.data != null)
                                      DetailElement(
                                        title: _getController.productRate.value.data!.result!.total.toString() ?? '',
                                        subTitle: 'ta izoh'.tr,
                                        icon: TablerIcons.message_circle,
                                      ),
                                      DetailElement(
                                          title: _getController.productDetailModel.value.data?.views.toString() ?? '',
                                          subTitle: 'ta ko\'rilgan'.tr,
                                          icon: TablerIcons.eye
                                      )
                                    ]
                                ),
                                Container(
                                  height: _getController.height.value * 0.08,
                                  width: _getController.width.value,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.025, bottom: _getController.height.value * 0.013),
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor3.withOpacity(0.15),
                                    border: Border.all(color: AppColors.primaryColor3, width: 1),
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child:
                                      Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Elektron kitob'.tr,
                                              style: TextStyle(
                                                  fontSize: _getController.width.value * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.onBackground
                                              ),
                                            ),
                                            //price
                                            Text('${_getController.productDetailModel.value.data?.price} so\'m',
                                                style: TextStyle(
                                                    fontSize: _getController.width.value * 0.04,
                                                    fontWeight: FontWeight.w400,
                                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                                )
                                            )
                                          ]
                                      )),
                                      Icon(
                                        TablerIcons.book_2,
                                        color: AppColors.primaryColor3,
                                        size: _getController.width.value * 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: _getController.height.value * 0.08,
                                        width: _getController.width.value * 0.45,
                                        padding: EdgeInsets.only(
                                            left: _getController.width.value * 0.03,
                                            right: _getController.width.value * 0.03
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(0.2),
                                          border: Border.all(color: AppColors.grey, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Row(
                                            children: [
                                              Expanded(child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Elektron kitob'.tr,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                            color: Theme.of(context).colorScheme.onBackground
                                                        )
                                                    ),
                                                    Text('16000 so\'m',
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w400,
                                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                                        )
                                                    )
                                                  ]
                                              )),
                                              Icon(
                                                TablerIcons.book,
                                                color: AppColors.primaryColor3,
                                                size: _getController.width.value * 0.06,
                                              )
                                            ]
                                        )
                                    ),
                                    Container(
                                        height: _getController.height.value * 0.08,
                                        width: _getController.width.value * 0.45,
                                        padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(0.2),
                                          border: Border.all(color: AppColors.grey, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Row(
                                            children: [
                                              Expanded(child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Audio kitob'.tr,
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w500,
                                                            color: Theme.of(context).colorScheme.onBackground
                                                        )
                                                    ),
                                                    Text('16000 so\'m',
                                                        style: TextStyle(
                                                            fontSize: _getController.width.value * 0.04,
                                                            fontWeight: FontWeight.w400,
                                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                                        )
                                                    )
                                                  ]
                                              )),
                                              Icon(
                                                  TablerIcons.headphones,
                                                  color: AppColors.primaryColor3,
                                                  size: _getController.width.value * 0.06
                                              )
                                            ]
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                Text('Tafsilotlar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
                                SizedBox(height: _getController.height.value * 0.02),
                                if (_getController.productDetailModel.value.data?.options != null)
                                  for (int i = 0; i < _getController.productDetailModel.value.data!.options!.length; i++)
                                    Container(
                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.019),
                                      child: Row(
                                        children: [
                                          Text('uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.options![i].optionId?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.options![i].optionId?.name?.ru ?? '' : 'oz_OZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.options![i].optionId?.name?.oz ?? '' : '', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),),
                                          Expanded(child: Text('  ---------------------------------------------------------  ', maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))),
                                          Text('uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.options![i].valueId?.name?.uz ?? _getController.productDetailModel.value.data?.options![i].value ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.options![i].valueId?.name?.ru ?? _getController.productDetailModel.value.data?.options![i].value ?? '' : 'oz_OZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.options![i].valueId?.name?.oz ?? _getController.productDetailModel.value.data?.options![i].value ?? '' : '', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground))
                                      ],
                                    ),
                                  ),
                                SizedBox(height: _getController.height.value * 0.01),
                                if ('uz_UZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.uz != '' || 'ru_RU' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.ru != '' || 'oz_OZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.oz != '')
                                  Text('Tavsif'.tr,
                                    style: TextStyle(
                                      fontSize: _getController.width.value * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if ('uz_UZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.uz != '' || 'ru_RU' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.ru != '' || 'oz_OZ' == Get.locale.toString() && _getController.productDetailModel.value.data?.content?.oz != '')
                                  Html(
                                    style: {
                                      'p': Style(
                                        fontSize: FontSize(_getController.width.value * 0.04),
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                    },
                                    //data: _getController.productDetailModel.value.data?.content?.uz ?? '',
                                    data: 'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.content?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.content?.ru ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.content?.oz ?? '' : '',
                                  ),
                                Text('Mualif haqida'.tr,
                                  style: TextStyle(
                                    fontSize: _getController.width.value * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: _getController.width.value,
                                  height: _getController.height.value * 0.09,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.02),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.background,
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3)
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: _getController.width.value * 0.16,
                                        height: _getController.height.value * 0.08,
                                        margin: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].image ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].image ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].image ?? '' : '',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : '',
                                            style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).colorScheme.onBackground
                                            ),
                                          ),
                                          Text(
                                            'uz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailModel.value.data?.simularProducts![0].option?.valueId?.name?.uz ?? '' : '',
                                            style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
                                            ),
                                          )
                                        ],
                                      )),
                                      Icon(
                                        TablerIcons.arrow_right,
                                        color: Theme.of(context).colorScheme.onBackground,
                                        size: _getController.width.value * 0.07,
                                      ),
                                      SizedBox(width: _getController.width.value * 0.03),
                                    ],
                                  ),
                                ),
                                Text('Tavsiya etiladi'.tr,
                                  style: TextStyle(
                                    fontSize: _getController.width.value * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  height: _getController.height.value * 0.35,
                                  width: _getController.width.value,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.02, bottom: _getController.height.value * 0.01),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _getController.productDetailModel.value.data?.simularProducts!.length,
                                    itemBuilder: (context, index) {
                                      return ProductItem(
                                        id: _getController.productDetailModel.value.data?.simularProducts![index].slug ?? '',
                                        title: _getController.productDetailModel.value.data?.simularProducts![index].option?.valueId?.name?.uz ?? '',
                                        deck: _getController.productDetailModel.value.data?.simularProducts![index].option?.valueId?.name?.uz ?? '',
                                        price: _getController.productDetailModel.value.data?.simularProducts![index].price.toString() ?? '',
                                        imageUrl: _getController.productDetailModel.value.data?.simularProducts![index].image ?? '',
                                        function: () {
                                          //new page for product detail
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(slug: _getController.productDetailModel.value.data?.simularProducts![index].slug ?? '')));
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Text('Sizning fikringiz'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.bold)),
                                SizedBox(height: _getController.height.value * 0.015),
                                if (_getController.productRate.value.data != null)
                                  Text('Baholang'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                                if (_getController.productRate.value.data != null)
                                  SizedBox(height: _getController.height.value * 0.01),
                                if (_getController.productRate.value.data != null)
                                  RatingBar.builder(
                                      initialRating: _getController.productRate.value.data!.result!.average == null ? 0 : double.parse(_getController.productRate.value.data!.result!.average.toString()),
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: _getController.width.value * 0.07,
                                      itemPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                      unratedColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                                      itemBuilder: (context, _) =>
                                      const Icon(
                                          TablerIcons.star_filled,
                                          color: AppColors.primaryColor
                                      ),
                                      onRatingUpdate: (rating) {}
                                  ),
                                SizedBox(height: _getController.height.value * 0.02),
                                Text('${'Izoh'.tr}:', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                                SizedBox(height: _getController.height.value * 0.01),
                                Container(
                                  width: _getController.width.value,
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), width: 1),
                                  ),
                                  child: TextField(
                                    minLines: 1,
                                    maxLines: 3,
                                    style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground),
                                    decoration: InputDecoration(
                                      hintText: 'Kiriting'.tr,
                                      labelStyle: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                                      hintStyle: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: _getController.height.value * 0.02),
                                SizedBox(
                                  width: _getController.width.value,
                                  height: _getController.height.value * 0.06,
                                  child: ElevatedButton(
                                    onPressed: () {
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text('Jo\'natish'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.background)))
                                ),
                                SizedBox(height: _getController.height.value * 0.033),
                                Text('Izohlar'.tr, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.bold)),

                                if (_getController.productDetailModel.value.data!.comments!.isNotEmpty)
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    semanticChildCount: _getController.productDetailModel.value.data?.comments!.length,
                                    addAutomaticKeepAlives: true,
                                    primary: true,
                                    addRepaintBoundaries: true,
                                    scrollDirection: Axis.vertical,
                                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                    findChildIndexCallback: (key) => null,
                                    itemCount: _getController.productDetailModel.value.data?.comments!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: EdgeInsets.only(bottom: _getController.height.value * 0.02),
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02, top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.01),
                                          decoration: BoxDecoration(
                                            color: AppColors.grey.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), width: 1),
                                          ),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        width: _getController.width.value * 0.12,
                                                        height: _getController.width.value * 0.12,
                                                        margin: EdgeInsets.only(right: _getController.width.value * 0.03),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: DecorationImage(image: NetworkImage(_getController.productDetailModel.value.data?.comments![index].user?.avatar ?? '',), fit: BoxFit.cover))
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                            _getController.productDetailModel.value.data?.comments![index].user?.fullName ?? '',
                                                            style: TextStyle(
                                                                fontSize: _getController.width.value * 0.04,
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).colorScheme.onBackground
                                                            )
                                                        )
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: _getController.height.value * 0.01),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: _getController.width.value * 0.32,
                                                      child: RatingBar.builder(
                                                          initialRating: _getController.productDetailModel.value.data?.comments![index].rate?.toDouble() ?? 0,
                                                          minRating: 0,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemSize: _getController.width.value * 0.06,
                                                          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                                          onRatingUpdate: (rating) {}
                                                      ),
                                                    ),
                                                    Expanded(child:
                                                    Text(
                                                        DateTime.parse(_getController.productDetailModel.value.data?.comments![index].createdAt ?? '').toString().substring(0, 10),
                                                        maxLines: 1,
                                                        style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5))
                                                    ))
                                                  ],
                                                ),
                                                SizedBox(height: _getController.height.value * 0.01),
                                                Text(
                                                    _getController.productDetailModel.value.data?.comments![index].description ?? '',
                                                    style: TextStyle(
                                                        fontSize: _getController.width.value * 0.04,
                                                        fontWeight: FontWeight.w400,
                                                        color: Theme.of(context).colorScheme.onBackground
                                                    )
                                                )
                                              ]
                                          )
                                      );
                                    }
                                ),
                                if (_getController.productDetailModel.value.data!.comments!.isEmpty)
                                  Container(
                                    width: _getController.width.value,
                                    height: _getController.height.value * 0.11,
                                    margin: EdgeInsets.only(top: _getController.height.value * 0.015),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withOpacity(0.1),
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2), width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          TablerIcons.message_circle_cancel,
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                          size: _getController.width.value * 0.1,
                                        ),
                                        Text('Izohlar yo\'q'.tr,
                                            style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))
                                      ],
                                    ),
                                  )
                              ],
                            )
                        ),
                        SizedBox(height: _getController.height.value * 0.214)
                      ]
                  ) : SizedBox(
                      height: _getController.height.value,
                      width: _getController.width.value,
                      child: Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500))))
                  )
                )
              ),
              Positioned(
                  bottom: 0, left:  0, right: 0,
                  child: Obx(() => SizedBox(
                      height: _getController.height.value * 0.12,
                      width: _getController.width.value,
                      child:Container(
                        height: _getController.height.value * 0.1,
                        width: _getController.width.value * 0.5,
                        padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, -1)
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (_getController.productDetailModel.value.data != null)
                              Expanded(
                                  child: _getController.productDetailModel.value.data != null
                                      ? Text('${_getController.productDetailModel.value.data!.price} so\'m', style: TextStyle(fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onBackground)) : const SizedBox()),
                            SizedBox(
                              width: _getController.width.value * 0.35,
                              height: _getController.height.value * 0.06,
                              child: ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text('Xarid'.tr, style: TextStyle(
                                    fontSize: _getController.width.value * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.background)
                                ),
                              ),
                            ),
                            Container(
                              width: _getController.width.value * 0.13,
                              height: _getController.height.value * 0.06,
                              margin: EdgeInsets.only(left: _getController.width.value * 0.02),
                              child: IconButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                icon: Icon(
                                  TablerIcons.shopping_bag,
                                  color: Theme.of(context).colorScheme.background,
                                  size: _getController.width.value * 0.07,
                                ),
                                onPressed: () {
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  )
              )
            ]
          )
      )
    );
  }
}