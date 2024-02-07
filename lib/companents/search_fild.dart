import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';

class SearchFields extends StatelessWidget {
  SearchFields({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _getController.height.value * 0.05, left: _getController.width.value * 0.03, right: _getController.width.value * 0.03),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: _getController.height.value * 0.06,
              padding: EdgeInsets.only(right: _getController.width.value * 0.01),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(13),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(_getController.height.value * 0.015),
                    child: SvgPicture.asset(
                      'assets/icon/search.svg',
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: _getController.width.value * 0.02),
          Container(
            height: _getController.height.value * 0.06,
            width: _getController.height.value * 0.06,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Theme.of(context).colorScheme.background.withOpacity(0.5),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icon/bell.svg',
                height: _getController.height.value * 0.03,
                width: _getController.height.value * 0.03,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.surface, BlendMode.srcIn),
              ),
            )
          ),
        ],
      ),
    );
  }
}