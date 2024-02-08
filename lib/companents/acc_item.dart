import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import '../controllers/get_controller.dart';

class AccItem extends StatefulWidget {
  final String title;
  final String subTitle;
  final String icon;
  var onTap;
  bool? switchValue;
  //color
  Color? color;

  AccItem({super.key, required this.title, required this.subTitle, required this.icon, required this.onTap, this.switchValue, this.color});

  @override
  State<AccItem> createState() => _AccItemState();
}

class _AccItemState extends State<AccItem> {
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: _getController.height.value * 0.0179,
      title: Row(
        children: [
          Text(widget.title,
              style: TextStyle(
                  //color: Theme.of(context).colorScheme.onSurface,
                  color: widget.color ?? Theme.of(context).colorScheme.onSurface,
                  fontSize: _getController.width.value * 0.043,
                  fontWeight: FontWeight.w600
              )
          ),
          const Spacer(),
          Text(widget.subTitle,
              style: TextStyle(
                  //color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  color: widget.color ?? Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  fontSize: _getController.width.value * 0.04,
                  fontWeight: FontWeight.w500
              )
          ),
        ],
      ),
      leading: Container(
        padding: EdgeInsets.all(_getController.width.value * 0.026),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(_getController.width.value * 0.03),
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
        ),
        //child: Icon(widget.icon),
        child: SvgPicture.asset(widget.icon,
          //colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          colorFilter: ColorFilter.mode(widget.color ?? Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          height: _getController.width.value * 0.05,
        ),
      ),
      trailing: widget.switchValue != null ? CupertinoSwitch(
        value: Theme.of(context).brightness == Brightness.dark ? widget.switchValue! : !widget.switchValue!,
        onChanged: (value) {
          AdaptiveTheme.of(context).brightness == Brightness.light ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
          setState(() {
            widget.switchValue = value;
            });
        },
        activeColor: AppColors.green,
        trackColor: AppColors.grey.withOpacity(0.5),
        focusColor: AppColors.green,
        thumbColor: Theme.of(context).colorScheme.surface,
        applyTheme: true,
      ) : Icon(Icons.arrow_forward,
        //color: Theme.of(context).colorScheme.onSurface,
        color: widget.color ?? Theme.of(context).colorScheme.onSurface,
        size: _getController.width.value * 0.055,
      ),
      onTap: widget.onTap,
    );
  }
}