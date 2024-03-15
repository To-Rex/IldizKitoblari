import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class ProductItem extends StatefulWidget {
   String? id;
   String? title;
   String? deck;
   String? price;
   String? imageUrl;
   Function function;

  ProductItem({super.key,required this.id, required this.title, required this.deck, required this.price, required this.imageUrl, required this.function});

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
        widget.function();
      },
      child: Container(
        margin: EdgeInsets.only(top: _getController.height.value * 0.007, left: _getController.width.value * 0.013, right: _getController.width.value * 0.013),
        width: _getController.width.value * 0.44,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.imageUrl != null || widget.imageUrl != ''|| widget.imageUrl != 'null' || widget.imageUrl != ' ')
            Container(
              width: _getController.width.value * 0.44,
              height: _getController.height.value * 0.205,
              margin: EdgeInsets.only(bottom: _getController.height.value * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.background,
                //image: DecorationImage(image: NetworkImage(widget.imageUrl!), fit: BoxFit.cover),
                image: DecorationImage(image: NetworkImage(widget.imageUrl == null || widget.imageUrl == ''|| widget.imageUrl == 'null' || widget.imageUrl == ' ' ? 'https://auctionresource.azureedge.net/blob/images/auction-images%2F2023-08-10%2Facf6f333-1745-4756-89b9-4e0f7974b166.jpg?preset=740x740' : widget.imageUrl!), fit: BoxFit.cover)
              )
            ),
            SizedBox(child: Text(widget.title!, maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
            SizedBox(height: _getController.height.value * 0.01),
            Row(
              children: [
                Expanded(child: Text(
                  '${widget.price} ${'uz_UZ' == Get.locale.toString() ? 'so\'m' : 'oz_OZ' == Get.locale.toString() ? 'сўм' : 'ru_RU' == Get.locale.toString() ? 'сум' : 'en_EN' == Get.locale.toString() ? 'sum' : 'so\'m'}',
                  style: TextStyle(
                    fontSize: _getController.width.value * 0.04,
                    color: AppColors.primaryColor2,
                    fontWeight: FontWeight.w600
                  )
                )),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    TablerIcons.shopping_cart_plus,
                    size: _getController.width.value * 0.06,
                    color: Theme.of(context).colorScheme.onBackground
                  )
                )
              ]
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: _getController.height.value * 0.01),
                  height: _getController.height.value * 0.05,
                  width: _getController.width.value * 1.0,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor2, padding: EdgeInsets.zero, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      child: Text('Xarid'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w600))
                  )
              ),
            )
          ]
        )
      )
    );
  }
}