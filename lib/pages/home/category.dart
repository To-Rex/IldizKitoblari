import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';
import 'category_page.dart';

class Category extends StatelessWidget {
  Category({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategoriyalar',
            style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onBackground)),
        centerTitle: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06), onPressed: () {Get.back();})
      ),
      body: Obx(() => _getController.menuModel.value.data == null
          ? Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600)))
          : SizedBox(
        width: _getController.width.value,
        height: _getController.height.value,
        child: ListView.builder(
          itemCount: _getController.menuModel.value.data == null ? 0 : _getController.menuModel.value.data!.result!.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              _getController.menuModel.value.data!.result![index].sId!,
              _getController.menuModel.value.data!.result![index].slug!,
              () {
                if (_getController.menuModel.value.data!.result![index].children == null) {
                  Get.to(() => CatDetailPage(title: _getController.menuModel.value.data!.result![index].title!.uz!, menuSlug: _getController.menuModel.value.data!.result![index].slug!));
                }else {
                  Get.to(() => CategoryPage(menuIndex: _getController.menuModel.value.data!.result!.indexOf(_getController.menuModel.value.data!.result![index])));
                }
              }
            );
          }
        )
      )
      )
    );
  }
}
