import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../controllers/get_controller.dart';
import '../pages/home/author_detail.dart';

class AuthorItem extends StatelessWidget {
  final String sId;
  final String title;
  final String subTitle;
  final String image;
  var onTap;
  bool? switchValue;
  Color? color;
  final int index;

  AuthorItem({super.key,required this.sId, required this.title, required this.subTitle, required this.image, required this.onTap, this.switchValue, this.color, required this.index});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.035, vertical: _getController.width.value * 0.02),
            color: Theme.of(context).colorScheme.background,
            surfaceTintColor: Theme.of(context).colorScheme.onBackground,
            elevation: 5,
            shadowColor: Theme.of(context).colorScheme.background,
            child: Container(
                width: _getController.width.value,
                padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.025, vertical: _getController.width.value * 0.02),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).colorScheme.background),
                child: Row(
                    children: [
                      if (image != '')
                        Container(
                            width: _getController.width.value * 0.15,
                            height: _getController.width.value * 0.15,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)))
                      else
                        Icon(Icons.person, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), size: _getController.width.value * 0.1),
                      SizedBox(width: _getController.width.value * 0.02),
                      Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: TextStyle(fontSize: _getController.width.value * 0.04, color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600)),
                            Text('$subTitle ${'ta kitob'.tr}', style: TextStyle(fontSize: _getController.width.value * 0.035, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), fontWeight: FontWeight.w500))
                          ]
                      )),
                      Icon(TablerIcons.arrow_right, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), size: _getController.width.value * 0.06)
                    ]
                )
            )
        )
    );
  }
}
