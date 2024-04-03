import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/pages/home/sub_category_page.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';

class CategoryPage extends StatelessWidget {
  var menuIndex;

  CategoryPage({super.key, required this.menuIndex});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    print('menuIndex: $menuIndex');
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
                      'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!,
                          () {
                        _getController.page.value = 1;
                        _getController.productModelLength.value = 0;
                        _getController.clearProductModel();
                        print('menuIndex: $menuIndex');
                        if (_getController.menuModel.value.data!.result![menuIndex].children![index].children != null) {
                          Get.to(() => SubCategoryPage(
                            title: 'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!,
                            menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].slug!,
                            menuIndex: menuIndex,
                            index: index,
                          ));
                        } else {
                          Get.to(() => CatDetailPage(title: 'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].title!.ru!, menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].slug!, parent: false));
                        }
                      });
                }
            )
          )
        ]))
    );
  }
}
