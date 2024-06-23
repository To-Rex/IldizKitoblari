import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/get_controller.dart';

class ContactUs extends StatelessWidget{
  ContactUs({super.key});

  final GetController _getController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    ApiController().getContactUs();
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
      body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  width: Get.width,
                  margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                  ),
                  child: Obx(() =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Bog‘lanish'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Bog‘lanish uchun:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 10.h),
                          Text(_getController.contactUsModel.value.data!.result!.phone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(Icons.phone, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Hamkorlar uchun bog‘lanish:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 10.w),
                          Text(_getController.contactUsModel.value.data!.result!.corpPhone.toString(), style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                          SizedBox(height: 10.w),
                          Row(
                              children: [
                                Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Ijtimoiy tarmoqlar:'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 15.h),
                          Row(
                              children: [
                                Container(
                                  height: 35.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                  child: IconButton(onPressed: () {
                                    launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.youtube.toString()), mode: LaunchMode.externalApplication);
                                  },
                                    icon: Icon(
                                        TablerIcons.brand_youtube,
                                        color: AppColors.backgroundApp, size: 20.sp
                                    )
                                  )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.instagram.toString()), mode: LaunchMode.externalApplication);
                                    },
                                      icon: Icon(
                                          TablerIcons.brand_instagram,
                                          color: AppColors.backgroundApp, size: 20.sp
                                      )
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.telegram.toString()), mode: LaunchMode.externalApplication);
                                    },
                                      icon: Icon(
                                          TablerIcons.brand_telegram,
                                          color: AppColors.backgroundApp,
                                          size: 20.sp
                                      ),
                                    )
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(500.r), color: AppColors.grey.withOpacity(0.2)),
                                    child: IconButton(onPressed: () {
                                      launchUrl(Uri.parse(_getController.contactUsModel.value.data!.result!.socials!.facebook.toString()), mode: LaunchMode.externalApplication);
                                    },
                                        icon: Icon(
                                            TablerIcons.brand_facebook,
                                            color: AppColors.backgroundApp,
                                            size: 20.sp
                                        )
                                    )
                                )
                              ]
                          )
                        ]
                      )
                  )
                ),
                Container(
                  width: Get.width,
                  margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), width: 1)
                  ),
                  child: Obx(() =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ildiz kitoblari Xadra filiali'.tr, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10.h),
                          Row(
                              children: [
                                Icon(TablerIcons.world, color: AppColors.backgroundApp, size: 20.sp),
                                SizedBox(width: 10.w),
                                Text('Manzil'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
                              ]
                          ),
                          SizedBox(height: 10.h),
                          Html(
                              style: {'p': Style(textAlign: TextAlign.justify, fontSize: FontSize(16.sp), fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)},
                              data: _getController.contactUsModel.value.data!.result!.address!.uz.toString()
                          )
                        ]
                      )
                  )
                )
              ]
          )
      )
    );
  }
}