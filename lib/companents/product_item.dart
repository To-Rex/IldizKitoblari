import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:text_scroll/text_scroll.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';


class ProductItem extends StatefulWidget {
   String? id;
   String? title;
   String? deck;
   String? price;
   String? imageUrl;
   int? count;
   Function function;

  ProductItem({super.key,required this.id, required this.title, required this.deck, required this.price, required this.imageUrl, required this.count, required this.function});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {

    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        _getController.commentController.clear();
        widget.function();
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.sp, right: 15.sp),
        width: 185.sp,
        child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 185.sp, height: 190.sp, child: ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network(widget.imageUrl == null || widget.imageUrl == '' || widget.imageUrl == 'null' || widget.imageUrl == ' ' ? 'https://ildizkitoblari.uz/_ipx/w_300,f_webp/default.png' : widget.imageUrl!, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {if (loadingProgress == null) return child;return SizedBox(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, child: Skeletonizer(child: Container(width: _getController.width.value * 0.44, height: _getController.height.value * 0.205, color: AppColors.grey)));}, errorBuilder: (context, error, stackTrace) {return Text(error.toString());}))),
              SizedBox(height: 10.sp),
              Container(
                  margin: EdgeInsets.only(right: 5.sp),
                  child: TextScroll(
                      widget.title!,
                      style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600),
                      mode: TextScrollMode.endless,
                      pauseBetween: const Duration(milliseconds: 10000),
                      selectable: true,
                      delayBefore: const Duration(milliseconds: 10000))
              ),
              SizedBox(height: 5.sp),
              //Expanded(child: Text('${widget.price} ${'uz_UZ' == Get.locale.toString() ? 'so\'m' : 'oz_OZ' == Get.locale.toString() ? 'сўм' : 'ru_RU' == Get.locale.toString() ? 'сум' : 'en_EN' == Get.locale.toString() ? 'sum' : 'so\'m'}', style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600))),
              Expanded(child: Text('${widget.price} ${'so‘m'.tr}', style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600))),
              Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Icon(TablerIcons.shopping_cart_plus, size: 18.sp, color: widget.count == 0 ? AppColors.secondaryColor : AppColors.primaryColor2)
                    ),
                    SizedBox(width: 2.sp),
                    Expanded(child:  TextScroll(
                        widget.count == 0 ? '${'Sotuvda mavjud emas'.tr}.' : 'Sotuvda mavjud'.tr,
                        style: TextStyle(fontSize: 14.sp, color: widget.count == 0 ? AppColors.secondaryColor : AppColors.primaryColor2, fontWeight: FontWeight.w600),
                        mode: TextScrollMode.endless,
                        pauseBetween: const Duration(milliseconds: 2000),
                        selectable: true,
                        delayBefore: const Duration(milliseconds: 3000))
                    ),
                  ]
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.sp),
                  height: 35.h,
                  width: 190.w,
                  child: ElevatedButton(
                      onPressed: () {
                        ApiController().addToBasket('1', widget.id.toString(),'active').then((value) => widget.function());
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      child: Text('Xarid'.tr, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w600))
                  )
              ),
              if (!_getController.checkCardId(widget.id))
                Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    height: 35.h,
                    width: 190.w,
                    child: ElevatedButton(
                        onPressed: () {
                          ApiController().addToBasket('1', widget.id.toString(),'active');
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text('Savatga qo‘shish'.tr, maxLines: 1, style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w600))
                    )
                )
              else
                Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    height: 35.h,
                    width: 190.w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primaryColor),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              color: Theme.of(context).colorScheme.onBackground,
                              onPressed: () {
                                if (int.parse(_getController.checkCardIdCount(widget.id.toString())) > 1) {
                                  ApiController().addToBasket('${int.parse(_getController.checkCardIdCount(widget.id.toString())) - 1}', widget.id.toString(), 'active');
                                } else {
                                  ApiController().addToBasket('0', widget.id.toString(), 'deleted');
                                }
                              },
                              icon: Icon(TablerIcons.minus, color: AppColors.white, size: Get.height * 0.025)),
                          Text(
                              _getController.listCartCreate[_getController.checkCardIdIndex(widget.id.toString())].count.toString(),
                              style: TextStyle(fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.w600)),
                          IconButton(
                              color: Theme.of(context).colorScheme.onBackground,
                              onPressed: () {
                                if (_getController.basketModel.value.data!.result![_getController.checkCardIdIndex(widget.id.toString())].count! >= _getController.basketModel.value.data!.result![_getController.checkCardIdIndex(widget.id.toString())].cartCount!) {
                                  ApiController().addToBasket('${int.parse(_getController.checkCardIdCount(widget.id.toString())) + 1}', widget.id.toString(), 'active');
                                }
                              },
                              icon: Icon(TablerIcons.plus, color: AppColors.white, size: Get.height * 0.025)),
                        ]
                    )
                )
            ]
        ))
      )
    );
  }
}