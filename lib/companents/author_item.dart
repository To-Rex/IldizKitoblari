import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import '../controllers/get_controller.dart';

class AuthorItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final String image;
  var onTap;
  bool? switchValue;
  Color? color;

  AuthorItem({super.key, required this.title, required this.subTitle, required this.image, required this.onTap, this.switchValue, this.color});

  @override
  State<AuthorItem> createState() => _AccItemState();
}

class _AccItemState extends State<AuthorItem> {
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(_getController.width.value * 0.02),
      color: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.onBackground,
      elevation: 5,
      shadowColor: Theme.of(context).colorScheme.background,
      child: Container(
        width: _getController.width.value * 0.9,
        padding: EdgeInsets.all(_getController.width.value * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).colorScheme.background
        ),
        child: Row(
          children: [
            if (widget.image != '')
            Container(
                width: _getController.width.value * 0.2,
                height: _getController.width.value * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                    )
                )
            )
            else
              Icon(Icons.person, size: _getController.width.value * 0.1),
            SizedBox(width: _getController.width.value * 0.02),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                  style: TextStyle(
                    fontSize: _getController.width.value * 0.04,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w600
                  )
                ),
                Text(widget.subTitle,
                  style: TextStyle(
                    fontSize: _getController.width.value * 0.035,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500
                  )
                )
              ],
            )),
            Icon(
              TablerIcons.arrow_right,
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
              size: _getController.width.value * 0.06,
            )
          ]
        )
      )
    );
  }
}