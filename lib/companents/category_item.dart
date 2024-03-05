import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  Function function;
  //String imgUrl;

  CategoryItem(
      this.id,
      this.title,
      this.function,
      //this.imgUrl,
      {Key? key}) : super(key: key);
  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        function();
      },
      child: Container(
        width: _getController.width.value,
        height: _getController.width.value * 0.15,
        margin: EdgeInsets.symmetric(vertical: _getController.width.value * 0.01, horizontal: _getController.width.value * 0.03),
        padding: EdgeInsets.symmetric(horizontal: _getController.width.value * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.grey.withOpacity(0.2),
        ),
        child: Row(
          children:[
            Container(
              width: _getController.width.value * 0.1,
              height: _getController.width.value * 0.1,
              margin: EdgeInsets.only(right: _getController.width.value * 0.04),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Theme.of(context).colorScheme.background),
              child: Center(
                  child: Icon(Icons.category,
                      size: _getController.width.value * 0.06,
                      color: Theme.of(context).colorScheme.onBackground
                  )
              ),
              //child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
            Expanded(child: Text(title, maxLines: 2, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w400))),
            Icon(Icons.arrow_forward, size: _getController.width.value * 0.06, color: Theme.of(context).colorScheme.onBackground),
          ],
        ),
      ),
    );
  }
}