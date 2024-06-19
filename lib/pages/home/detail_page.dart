import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../companents/detail_child_item.dart';
import '../../companents/detail_element.dart';
import '../../companents/product_item.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../shop/book_page.dart';

class DetailPage extends StatelessWidget {
  String slug;
  int pageIndex;

  DetailPage({super.key, required this.slug, required this.pageIndex});
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
            _getController.fullIndex.value = 0;
            _getController.productDetailList.clear();
            _getController.productRateList.clear();
            ApiController().getProductDetail(slug).then((value) => _refreshController.refreshCompleted());
          },
          controller: _refreshController,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() => _getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex
                  ? Column(
                  children: [
                    AppBar(
                      surfaceTintColor: Colors.transparent,
                      leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: _getController.width.value * 0.065), onPressed: () {Navigator.pop(context);}),
                      actions: [
                        IconButton(icon: Icon(TablerIcons.share, color: Theme.of(context).colorScheme.onSurface, size: _getController.width.value * 0.065), onPressed: () {}),
                        IconButton(icon: Icon(TablerIcons.bookmark, color: Theme.of(context).colorScheme.onSurface, size: _getController.width.value * 0.065), onPressed: () {})],
                    ),
                    if (_getController.productDetailList[pageIndex].data?.images != null)
                      Container(
                          height: _getController.height.value * 0.427,
                          width: _getController.width.value,
                          margin: EdgeInsets.only(top: _getController.height.value * 0.01, left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                          child: Swiper(
                              onIndexChanged: (index) {_getController.fullIndex.value = index;},
                              onTap: (index) {
                                Get.to(() => Container(
                                    color: Theme.of(context).colorScheme.surface,
                                    width: _getController.width.value,
                                    height: _getController.height.value,
                                    child: PhotoViewGallery(
                                      pageOptions: List.generate(_getController.productDetailList[pageIndex].data!.images!.isEmpty ? 1 : _getController.productDetailList[pageIndex].data!.images!.length, (index) {
                                        return PhotoViewGalleryPageOptions(
                                          imageProvider: _getController.productDetailList[pageIndex].data!.images!.isEmpty ? const NetworkImage('https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740') : NetworkImage(_getController.productDetailList[pageIndex].data!.images![index].file ?? ''),
                                          initialScale: PhotoViewComputedScale.contained,
                                          heroAttributes: PhotoViewHeroAttributes(tag: index),
                                        );
                                      }),
                                      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                                      pageController: PageController(initialPage: _getController.fullIndex.value),
                                    )
                                ));
                              },
                              controller: _getController.swiperController,
                              itemCount: _getController.productDetailList[pageIndex].data!.images!.isEmpty ? 1 : _getController.productDetailList[pageIndex].data!.images!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                        image: DecorationImage(image: _getController.productDetailList[pageIndex].data!.images!.isEmpty ? const NetworkImage('https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740') : NetworkImage(_getController.productDetailList[pageIndex].data!.images![index].file ?? ''), fit: BoxFit.cover)
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
                            itemCount: _getController.productDetailList[pageIndex].data?.images!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                                          image: DecorationImage(image: NetworkImage(_getController.productDetailList[pageIndex].data?.images![index].file ?? ''), fit: BoxFit.cover)
                                      )
                                  ))
                              );
                            }
                        )
                    ),
                    Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, top: _getController.height.value * 0.015, bottom: _getController.height.value * 0.03),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('uz_UZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.name?.ru ?? '' : 'oz_OZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.name?.oz ?? '' : '', style: TextStyle(fontSize: _getController.width.value * 0.06, fontWeight: FontWeight.bold)),
                              SizedBox(height: _getController.height.value * 0.013),
                              if (_getController.productDetailList[pageIndex].data != null)
                                Row(
                                    children: [
                                      if (_getController.productRateList.length > pageIndex)
                                        DetailElement(title: _getController.productRateList[pageIndex].data!.result!.average == null
                                            ? '0.0'
                                            : _getController.productRateList[pageIndex].data!.result!.average.toString().length > 3
                                            ? _getController.productRateList[pageIndex].data!.result!.average.toString().substring(0, 3)
                                            : _getController.productRateList[pageIndex].data!.result!.average.toString(),
                                            subTitle: '', icon: Icons.star),
                                      if (_getController.productRateList.length > pageIndex)
                                        DetailElement(title: _getController.productRateList[pageIndex].data!.result!.total.toString(), subTitle: 'ta izoh'.tr, icon: TablerIcons.message_circle),
                                      DetailElement(title: _getController.productDetailList[pageIndex].data?.views.toString() ?? '', subTitle: 'ta ko‘rilgan'.tr, icon: TablerIcons.eye)
                                    ]
                                ),
                              InkWell(
                                onTap: () {_getController.paymentTypeIndex.value = 0;},
                                child: Container(
                                  height: _getController.height.value * 0.08,
                                  width: _getController.width.value,
                                  margin: EdgeInsets.only(top: _getController.height.value * 0.025, bottom: _getController.height.value * 0.013),
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  decoration: BoxDecoration(
                                      color: _getController.paymentTypeIndex.value == 0 ?AppColors.primaryColor3.withOpacity(0.15): AppColors.grey.withOpacity(0.2),
                                      border: Border.all(color: _getController.paymentTypeIndex.value == 0 ? AppColors.primaryColor3 : AppColors.grey, width: 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(8))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Qog‘ozli kitob'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                                            Text('${_getController.productDetailList[pageIndex].data?.price} ${'so‘m'.tr}', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)))
                                          ]
                                      )),
                                      Icon(TablerIcons.book_2, color: AppColors.primaryColor3, size: _getController.width.value * 0.1),
                                    ],
                                  ),
                                )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (_getController.productDetailList[pageIndex].data?.pdf?.toString() != '')
                                    InkWell(
                                      onTap: () {
                                        _getController.paymentTypeIndex.value = 1;
                                      },
                                      child: Container(
                                          height: _getController.height.value * 0.08,
                                          width: _getController.width.value * 0.45,
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                          decoration: BoxDecoration(
                                              color: _getController.paymentTypeIndex.value == 1 ?AppColors.primaryColor3.withOpacity(0.15): AppColors.grey.withOpacity(0.2),
                                              border: Border.all(
                                                  color: _getController.paymentTypeIndex.value == 1 ? AppColors.primaryColor3 : AppColors.grey,
                                                  width: 1),
                                              borderRadius: const BorderRadius.all(Radius.circular(8))
                                          ),
                                          child: Row(
                                              children: [
                                                Expanded(
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Elektron kitob'.tr, maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                                                          Text('${_getController.productDetailList[pageIndex].data?.pdfPrice.toString()} ${'so‘m'.tr}', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)))
                                                        ]
                                                    )
                                                ),
                                                Icon(TablerIcons.book, color: AppColors.primaryColor3, size: _getController.width.value * 0.06)
                                              ]
                                          )
                                      )
                                    ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => BookPage(
                                          url: _getController.productDetailList[pageIndex].data!.pdf!,
                                         //title: _getController.productDetailList[pageIndex].data!.name!,
                                          title: 'uz_UZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data!.name!.uz! : 'oz_OZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data!.name!.oz! : _getController.productDetailList[pageIndex].data!.name!.ru!,
                                      ));
                                    },
                                      child: Container(
                                          height: _getController.height.value * 0.08,
                                          width: _getController.width.value * 0.45,
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                          decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2), border: Border.all(color: AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                          child: Expanded(child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Fragmentni O`qish'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                                              ]
                                          ))
                                      )
                                  )
                                ]
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _getController.paymentTypeIndex.value = 2;
                                      },
                                      child: Container(
                                          height: _getController.height.value * 0.08,
                                          width: _getController.width.value * 0.45,
                                          padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                          decoration: BoxDecoration(
                                            //color: AppColors.grey.withOpacity(0.2), || AppColors.primaryColor3.withOpacity(0.15),
                                              color: _getController.paymentTypeIndex.value == 2 ?AppColors.primaryColor3.withOpacity(0.15): AppColors.grey.withOpacity(0.2),
                                              border: Border.all(
                                                //color: AppColors.grey,
                                                  color: _getController.paymentTypeIndex.value == 2 ? AppColors.primaryColor3 : AppColors.grey,
                                                  width: 1),
                                              borderRadius: const BorderRadius.all(Radius.circular(8))
                                          ),
                                          child: Row(
                                              children: [
                                                Expanded(child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Audio kitob'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                                                      Text('16000 so‘m', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)))
                                                    ]
                                                )),
                                                Icon(TablerIcons.headphones, color: AppColors.primaryColor3, size: _getController.width.value * 0.06)
                                              ]
                                          )
                                      )
                                  ),
                                  if (_getController.productDetailList[pageIndex].data?.pdf?.toString() != '')
                                    Container(
                                        height: _getController.height.value * 0.08,
                                        width: _getController.width.value * 0.45,
                                        padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                        decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2), border: Border.all(color: AppColors.grey, width: 1), borderRadius: const BorderRadius.all(Radius.circular(8))),
                                        child: Expanded(child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('Fragmentni Eshitish'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
                                            ]
                                        ))
                                    )
                                ]
                              )
                            ]
                        )
                    ),
                    DetailChildItem(title: 'Tafsilotlar'.tr, function: (){}, check: false),
                    Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, bottom: _getController.height.value * 0.005),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: _getController.height.value * 0.02),
                              if (_getController.productDetailList[pageIndex].data?.options != null)
                                for (int i = 0; i < _getController.productDetailList[pageIndex].data!.options!.length; i++)
                                  Container(
                                      width: _getController.width.value,
                                      margin: EdgeInsets.only(bottom: _getController.height.value * 0.011),
                                      child: Row(
                                          children: [
                                            LimitedBox(maxWidth: _getController.width.value * 0.25, child: Text(maxLines: 1, textAlign: TextAlign.start, 'uz_UZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.options![i].optionId?.name?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.options![i].optionId?.name?.ru ?? '' : 'oz_OZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.options![i].optionId?.name?.oz ?? '' : '', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),),),
                                            Expanded(child: Text('  ---------------------------------------------------------  ', maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)))),
                                            LimitedBox(maxWidth: _getController.width.value * 0.7, child: Text(maxLines: 1, textAlign: TextAlign.end, 'uz_UZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.options![i].valueId?.name?.uz ?? _getController.productDetailList[pageIndex].data?.options![i].value ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.options![i].valueId?.name?.ru ?? _getController.productDetailList[pageIndex].data?.options![i].value ?? '' : 'oz_OZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.options![i].valueId?.name?.oz ?? _getController.productDetailList[pageIndex].data?.options![i].value ?? '' : '', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),)
                                          ]
                                      )
                                  ),
                              SizedBox(height: _getController.height.value * 0.02),
                            ]
                        )
                    ),
                    if ('uz_UZ' == Get.locale.toString() && _getController.productDetailList[pageIndex].data?.content?.uz != '' || 'ru_RU' == Get.locale.toString() && _getController.productDetailList[pageIndex].data?.content?.ru != '' || 'oz_OZ' == Get.locale.toString() && _getController.productDetailList[pageIndex].data?.content?.oz != '')
                      DetailChildItem(title: 'Tavsif'.tr, function: (){}, check: false),
                    Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ('uz_UZ' == Get.locale.toString() && _getController.productDetailList[pageIndex].data?.content?.uz != '' || 'ru_RU' == Get.locale.toString() && _getController.productDetailList[pageIndex].data?.content?.ru != '' || 'oz_OZ' == Get.locale.toString() && _getController.productDetailList[pageIndex].data?.content?.oz != '')
                                Html(style: {'p': Style(fontSize: FontSize(_getController.width.value * 0.04), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)},data: 'uz_UZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.content?.uz ?? '' : 'ru_RU' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.content?.ru ?? '' : 'oz_UZ' == Get.locale.toString() ? _getController.productDetailList[pageIndex].data?.content?.oz ?? '' : '',)
                            ]
                        )
                    ),
                    DetailChildItem(title: 'Tavsiya etiladi'.tr, function: (){}, check: false),
                    Container(
                      height: 370.h,
                      width: _getController.width.value,
                      margin: EdgeInsets.only(top: _getController.height.value * 0.02),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                        itemCount: _getController.productDetailList[pageIndex].data?.simularProducts!.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                            id: _getController.productDetailList[pageIndex].data?.simularProducts![index].slug ?? '',
                            title: _getController.productDetailList[pageIndex].data?.simularProducts![index].name ?? '',
                            deck: _getController.productDetailList[pageIndex].data?.simularProducts![index].option?.valueId?.name?.uz ?? '',
                            price: _getController.productDetailList[pageIndex].data?.simularProducts![index].price.toString() ?? '',
                            imageUrl: _getController.productDetailList[pageIndex].data?.simularProducts![index].image ?? '',
                            function: () {
                              _getController.fullIndex.value = 0;
                              _getController.swiperController.move(0);
                              _getController.removeProductDetailModel(pageIndex+1);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(slug: _getController.productDetailList[pageIndex].data?.simularProducts![index].slug ?? '', pageIndex: pageIndex+1)));
                            }, count: _getController.productDetailList[pageIndex].data?.simularProducts![index].count ?? 0,
                          );
                        },
                      ),
                    ),
                    DetailChildItem(title: 'Sizning fikringiz'.tr, function: (){}, check: false),
                    Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03, bottom: _getController.height.value * 0.025),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: _getController.height.value * 0.015),
                              if (_getController.productRateList.length > pageIndex)
                                Text('Baholang'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                              if (_getController.productRateList.length > pageIndex)
                                SizedBox(height: _getController.height.value * 0.01),
                              if (_getController.productRateList.length > pageIndex)
                                RatingBar.builder(
                                    initialRating: _getController.productRateList[pageIndex].data!.result!.average == null ? 0 : double.parse(_getController.productRateList[pageIndex].data!.result!.average.toString()),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: _getController.width.value * 0.07,
                                    itemPadding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.01),
                                    unratedColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                    itemBuilder: (context, _) =>
                                    const Icon(TablerIcons.star_filled, color: AppColors.primaryColor),
                                    onRatingUpdate: (rating) {
                                      _getController.ratingController.text = rating.toString();
                                    }
                                ),
                              SizedBox(height: _getController.height.value * 0.02),
                              Text('${'Izoh'.tr}:', style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500)),
                              SizedBox(height: _getController.height.value * 0.01),
                              Container(
                                  width: _getController.width.value,
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface,
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1)
                                  ),
                                  child: TextField(
                                      minLines: 1,
                                      maxLines: 3,
                                      controller: _getController.commentController,
                                      style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface),
                                      decoration: InputDecoration(
                                          hintText: 'Kiriting'.tr,
                                          labelStyle: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                                          hintStyle: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                                          border: InputBorder.none
                                      )
                                  )
                              ),
                              SizedBox(height: _getController.height.value * 0.02),
                              SizedBox(
                                  width: _getController.width.value,
                                  height: _getController.height.value * 0.06,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (_getController.commentController.text.isEmpty) {
                                          ApiController().showToast(context, 'Xatolik', 'Ma‘lumotlar yo‘q!', true, 3);
                                        } else {
                                          ApiController().createComment(
                                              _getController.commentController.text,
                                              _getController.productDetailList[pageIndex].data!.sId.toString(),
                                              _getController.ratingController.text
                                          ).then((value) => {
                                            _getController.fullIndex.value = 0,
                                            _getController.productDetailList.clear(),
                                            _getController.productRateList.clear(),
                                            ApiController().getProductDetail(slug)
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                                      ),
                                      child: Text('Jo‘natish'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface)))
                              ),
                            ]
                        )
                    ),
                    DetailChildItem(title: 'Izohlar'.tr, function: (){}, check: true),
                    if (_getController.productDetailList[pageIndex].data!.comments!.isNotEmpty)
                      SizedBox(height: _getController.height.value * 0.01),
                    _getController.productDetailList[pageIndex].data!.comments!.isNotEmpty
                        ? Padding(padding: EdgeInsets.only(left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                        child: Column(
                          children: [
                            for (int i = 0; i < _getController.productDetailList[pageIndex].data!.comments!.length; i++)
                              Container(
                                  margin: EdgeInsets.only(bottom: _getController.height.value * 0.02),
                                  padding: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02, top: _getController.height.value * 0.01, bottom: _getController.height.value * 0.01),
                                  decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.1), borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1)),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            if (_getController.productDetailList[pageIndex].data?.comments![i].user?.avatar != '')
                                              Container(
                                                  width: _getController.width.value * 0.12,
                                                  height: _getController.width.value * 0.12,
                                                  margin: EdgeInsets.only(right: _getController.width.value * 0.03),
                                                  decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(
                                                      image: NetworkImage(_getController.productDetailList[pageIndex].data?.comments![i].user?.avatar ?? '',),
                                                      fit: BoxFit.cover)
                                                  )
                                              )
                                            else
                                              Container(
                                                width: _getController.width.value * 0.12,
                                                height: _getController.width.value * 0.12,
                                                margin: EdgeInsets.only(right: _getController.width.value * 0.03),
                                                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                                                child: Icon(Icons.person, color: Theme.of(context).colorScheme.surface, size: _getController.width.value * 0.06),
                                              ),
                                            Expanded(
                                                child: Text(
                                                    _getController.productDetailList[pageIndex].data?.comments![i].user?.fullName ?? '',
                                                    style: TextStyle(
                                                        fontSize: _getController.width.value * 0.04,
                                                        fontWeight: FontWeight.w500,
                                                        color: Theme.of(context).colorScheme.onSurface)
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
                                                      initialRating: _getController.productDetailList[pageIndex].data?.comments![i].rate?.toDouble() ?? 0,
                                                      minRating: 0,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: _getController.width.value * 0.06,
                                                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                                      onRatingUpdate: (rating) {}
                                                  )
                                              ),
                                              Expanded(child: Text(
                                                  DateTime.parse(_getController.productDetailList[pageIndex].data?.comments![i].createdAt ?? '').toString().substring(0, 10),
                                                  maxLines: 1,
                                                  style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
                                              ))
                                            ]
                                        ),
                                        SizedBox(height: _getController.height.value * 0.01),
                                        Text(
                                            _getController.productDetailList[pageIndex].data?.comments![i].description ?? '',
                                            style: TextStyle(
                                                fontSize: _getController.width.value * 0.04,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.onSurface
                                            )
                                        )
                                      ]
                                  )
                              ),
                          ]))
                        : Container(
                        width: _getController.width.value,
                        height: _getController.height.value * 0.12,
                        margin: EdgeInsets.only(top: _getController.height.value * 0.015,left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                TablerIcons.message_circle_cancel,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                size: _getController.width.value * 0.1,
                              ),
                              Text('Izohlar yo‘q'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)))
                            ]
                        )
                    ),
                    SizedBox(height: _getController.height.value * 0.214)
                  ]
              )
                  : Column(children: [
                    AppBar(
                      surfaceTintColor: Colors.transparent,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: _getController.width.value * 0.065),
                          onPressed: () {Navigator.pop(context);}
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(TablerIcons.share, color: Theme.of(context).colorScheme.onSurface, size: _getController.width.value * 0.065),
                            onPressed: () {}
                        ),
                        IconButton(
                            icon: Icon(TablerIcons.bookmark, color: Theme.of(context).colorScheme.onSurface, size: _getController.width.value * 0.065),
                            onPressed: () {}
                        )],
                    ),
                Skeletonizer(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: _getController.width.value,
                              height: _getController.height.value * 0.427,
                              margin: EdgeInsets.only(top: _getController.height.value * 0.015,left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), image: DecorationImage(image: NetworkImage('https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740'), fit: BoxFit.cover))),
                          SizedBox(height: _getController.height.value * 0.01),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: _getController.width.value * 0.03),
                                  width: _getController.width.value * 0.14,
                                  height: _getController.height.value * 0.06,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2), width: 1),
                                      image: const DecorationImage(image:NetworkImage('https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740'), fit: BoxFit.cover)
                                  )
                              )
                            ]
                          ),
                          SizedBox(height: _getController.height.value * 0.01),
                          Padding(
                              padding: EdgeInsets.only(left: _getController.width.value * 0.03),
                              child: Text('hello'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface))
                          )
                        ]
                    )
                )
              ]))
          )
        ),
        bottomNavigationBar: BottomAppBar(
          height: _getController.height.value * 0.09,
          surfaceTintColor: Theme.of(context).colorScheme.onSecondary,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.surface,
          child: Obx(() => Container(
            margin: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex)
                    Expanded(child: _getController.productDetailList[pageIndex].data != null
                        ? Text(
                        '${_getController.paymentTypeIndex.value == 0
                            ? _getController.productDetailList[pageIndex].data!.price
                            : _getController.paymentTypeIndex.value == 1
                            ? _getController.productDetailList[pageIndex].data?.pdfPrice.toString()
                            : _getController.productDetailList[pageIndex].data!.price
                        } ${'so‘m'.tr}',
                        style: TextStyle(fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)) : const SizedBox())
                  else
                    Expanded(
                        child: Skeletonizer(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.surface),
                            child: Text('hello'.tr),
                          )
                        )
                    ),
                  if (_getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex)
                    SizedBox(
                      width: _getController.width.value * 0.35,
                      height: _getController.height.value * 0.06,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: Text('Xarid'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface))
                      ))
                  else
                    SizedBox(
                      width: _getController.width.value * 0.35,
                      height: _getController.height.value * 0.06,
                      child: Skeletonizer(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: Text('Xarid'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.surface))
                        )
                      )
                    ),
                  if (_getController.productDetailList.length > pageIndex && _getController.productRateList.length > pageIndex)
                    Container(
                      width: _getController.width.value * 0.13,
                      height: _getController.height.value * 0.06,
                      margin: EdgeInsets.only(left: _getController.width.value * 0.02),
                      child: IconButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          icon: Icon(TablerIcons.shopping_bag, color: Theme.of(context).colorScheme.surface, size: _getController.width.value * 0.07),
                          onPressed: () {}
                      )
                  )
                  else
                    Skeletonizer(
                      child: Container(
                          width: _getController.width.value * 0.13,
                          height: _getController.height.value * 0.06,
                          margin: EdgeInsets.only(left: _getController.width.value * 0.02),
                          child: IconButton(
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              icon: Icon(TablerIcons.shopping_bag, color: Theme.of(context).colorScheme.surface, size: _getController.width.value * 0.07),
                              onPressed: () {}
                          )
                      )
                    )
                ]
            )
          ),
          ),
        )
    );
  }
}