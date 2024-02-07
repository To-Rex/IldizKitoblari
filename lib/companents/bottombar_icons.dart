import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';

import '../controllers/get_controller.dart';

class BottomBarIcons extends StatelessWidget {
  final String icon;
  final String title;
  var onTap;
  final bool isSelected;

  BottomBarIcons({super.key, required this.icon, required this.title, this.onTap, required this.isSelected});
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: SizedBox(
        width: _getController.width * 0.15,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                icon,
                colorFilter: isSelected ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn) : null,
              ),
              SizedBox(height: _getController.height * 0.01),
              Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryColor : AppColors.grey,
                    fontSize: _getController.width * 0.03,
                  )
              )

            ]
        )
      )
    );
  }
}
