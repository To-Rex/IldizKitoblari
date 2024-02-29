import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class ProductItem extends StatelessWidget {
   String? id;
   String? title;
   String? deck;
   String? price;
   String? imageUrl;

  ProductItem({Key? key,required this.id, required this.title, required this.deck, required this.price, required this.imageUrl}) : super(key: key);

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
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
              image: DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover),
            ),
          ),
          SizedBox(child: Text(
            title!,
            maxLines: 1, style: TextStyle(fontSize: _getController.width.value * 0.045, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),),),
          SizedBox(height: _getController.height.value * 0.006),
          SizedBox(
            child: Text(
              deck!,
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
                '$price so`m',
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
}