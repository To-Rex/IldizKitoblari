import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../controllers/get_controller.dart';
import '../../resource/colors.dart';

class AuthorDetail extends StatelessWidget {
  String sId;
  String title;
  int index;
  AuthorDetail({super.key, required this.sId, required this.index, required this.title});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    if (index == 0) _getController.clearAuthorDetailList();
    ApiController().getAuthorDetail(sId);
    return Scaffold(
      appBar: AppBar(
          title: Text(title, style: TextStyle(fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: _getController.width.value * 0.06),
            onPressed: () {
              Get.back();
            },
          )),
      body: Obx(() => _getController.authorDetailModelList.isNotEmpty
          ? Column(
          children: [
            SizedBox(height: _getController.height.value * 0.01),
            if (_getController.authorDetailModelList[index].data!.image == null || _getController.authorDetailModelList[index].data!.image == '')
              CircleAvatar(
                  radius: _getController.width.value * 0.14,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text('uz_UZ' == Get.locale.toString()
                      ? _getController.authorDetailModelList[index].data!.name!.uz!.toUpperCase().substring(0,1)
                      : 'oz_OZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.name!.oz!.toUpperCase().substring(0,2)
                      : _getController.authorDetailModelList[index].data!.name!.ru!.toUpperCase().substring(0,2),
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.1, fontWeight: FontWeight.bold),
                  )
              )
            else
              Center(
                  child: CircleAvatar(
                    radius: _getController.width.value * 0.14,
                    backgroundImage: Image.network(
                        _getController.authorDetailModelList[index].data!.image.toString(),
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: _getController.width.value * 0.15,
                            height: _getController.width.value * 0.15,
                            child: Skeletonizer(child: Container(width: _getController.width.value * 0.15, height: _getController.width.value * 0.15, color: AppColors.grey))
                          );
                        }
                    ).image
                )
            ),
            SizedBox(height: _getController.height.value * 0.01),
            Center(
                child: Text(
                  'uz_UZ' == Get.locale.toString()
                    ? _getController.authorDetailModelList[index].data!.name!.uz!
                    : 'oz_OZ' == Get.locale.toString() ? _getController.authorDetailModelList[index].data!.name!.oz!
                    : _getController.authorDetailModelList[index].data!.name!.ru!,
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.05, fontWeight: FontWeight.w500))
            )
          ])
          : const Center(child: CircularProgressIndicator())
      )
    );
  }
}