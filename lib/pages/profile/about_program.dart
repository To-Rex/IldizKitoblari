import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ildiz/controllers/api_controller.dart';

import '../../controllers/get_controller.dart';

class AboutProgram extends StatelessWidget{
  AboutProgram({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getAbout();
    return Scaffold(
        appBar: AppBar(
            title: Text('Dastur haqida'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
            centerTitle: false,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface, size: 20.sp),
              onPressed: () {
                Get.back();
              }
            )
        ),
        body: Obx(() =>
            SingleChildScrollView(
                child: Column(
                    children: [
                      if (_getController.aboutModel.value.data?.content?.uz != null)
                        Container(
                            margin: EdgeInsets.only(top: _getController.width.value * 0.04, left: _getController.width.value * 0.03,right: _getController.width.value * 0.03),
                            child: Html(
                                style: {'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(16.sp), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)},
                                data: _getController.aboutModel.value.data?.content?.uz ?? ''
                            )
                        )
                      else
                        if (!_getController.onLoading.value)
                          SizedBox(
                            height: Get.height * 0.8,
                            width: Get.width,
                            child: const Center(child: CircularProgressIndicator())
                          )
                        else
                          Container(

                          )
                    ]
                )
            )
        )
    );
  }
}