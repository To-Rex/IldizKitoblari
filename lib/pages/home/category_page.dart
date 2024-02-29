import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/pages/home/detail_page.dart';
import '../../companents/app_bar.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';

class CategoryPage extends StatelessWidget {
  var menuIndex;

  CategoryPage({super.key, required this.menuIndex});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategoriya'.tr),
        centerTitle: false,
        toolbarTextStyle: TextStyle(fontSize: _getController.width.value * 0.048, fontWeight: FontWeight.w600),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Theme.of(context).colorScheme.onBackground,
            size: _getController.width.value * 0.06,
          ),
          onPressed: () {
            Get.back();
          },
        )
      ),
      body: Obx(() => _getController.menuModel.value.data!.result![menuIndex].children == null
          ? Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600)))
          : Column(
        children: [
          //MyAppBar(title: 'Kategoriya'),
          Expanded(
            child: ListView.builder(
              itemCount: _getController.menuModel.value.data!.result?[menuIndex].children!.length,
                itemBuilder: (context, index) {
                  return CategoryItem(
                      _getController.menuModel.value.data!.result![menuIndex].children![index].sId!,
                      'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!, () {Get.to(() => DetailPage(title: 'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!, menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].slug!));}
                  );
                }
            )
          )
        ])
      )
    );
  }
}
