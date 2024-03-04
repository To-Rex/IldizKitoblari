import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../companents/category_item.dart';
import '../../controllers/get_controller.dart';
import 'cat_detail_page.dart';

class SubCategoryPage extends StatelessWidget {
  var title;
  var menuSlug;
  var menuIndex;
  var index;

  SubCategoryPage({super.key, required this.title, required this.menuSlug, required this.menuIndex, required this.index});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Obx(() => _getController.menuModel.value.data!.result![menuIndex].children![menuIndex].children != null
            ? Center(child: Text('Ma\'lumotlar yo\'q!'.tr, style: TextStyle(fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w600)))
            : Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _getController.menuModel.value.data!.result![menuIndex].children![index].children!.length,
                    itemBuilder: (context, indexs) {
                      return CategoryItem(
                          _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].sId!,
                          'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.ru!, () {
                            _getController.page.value = 1;
                            _getController.productModelLength.value = 0;
                            _getController.clearProductModel();
                        Get.to(() => CatDetailPage(title: 'uz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.uz! : 'oz_UZ' == Get.locale.toString() ? _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.oz! : _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].title!.ru!, menuSlug: _getController.menuModel.value.data!.result![menuIndex].children![index].children![indexs].slug!));
                      });
                    }
                ),
              ),
            ])
        )
    );
  }
}
