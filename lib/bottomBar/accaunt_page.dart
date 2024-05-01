import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:get_storage/get_storage.dart';
import '../companents/acc_item.dart';
import '../controllers/get_controller.dart';
import '../pages/onboarding_page.dart';
import '../pages/profile/edit_user.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final GetController _getController = Get.put(GetController());

  final List locale =[
    //{'name':'English','locale':const Locale('en','US')},
    {'name':'Russian','locale':const Locale('ru','RU')},
    {'name':'Uzbek','locale':const Locale('uz','UZ')},
    {'name':'Ўзбекча','locale':const Locale('oz','OZ')},
  ];

  updateLanguage(Locale locale){
    Get.updateLocale(locale);
  }

  void showLanguageBottomSheet(BuildContext context) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  width: _getController.width.value,
                  height: _getController.height.value * 0.45,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r),left: Radius.circular(10.r))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: _getController.width.value * 0.03, width: _getController.width.value),
                      Container(
                          height: _getController.width.value * 0.01,
                          width: _getController.width.value * 0.1,
                          margin: EdgeInsets.only(top: _getController.width.value * 0.01, bottom: _getController.width.value * 0.06),
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3), borderRadius: BorderRadius.circular(100))
                      ),
                      ListView.builder(
                          itemCount: locale.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04),
                                    child: InkWell(
                                        onTap: (){updateLanguage(locale[index]['locale']);},
                                        child: Text(locale[index]['name'], style: TextStyle(color: locale[index]['locale'] == Get.locale ? AppColors.primaryColor : Theme.of(context).colorScheme.onBackground, fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500))
                                    )
                                ),
                                if (index != locale.length - 1)
                                  Padding(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.05, right: _getController.width.value * 0.05),
                                      child: Divider(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2))
                                  )
                              ]
                            );
                          }
                      )
                    ]
                  )
              );
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                width: _getController.width.value,
                decoration: const BoxDecoration(color: AppColors.backgroundApp),
                child: Obx(() => Column(
                    children: [
                      SizedBox(
                          height: 112.h,
                          width: _getController.width.value,
                          child: Stack(
                              children: [
                                Positioned(child: SizedBox(width: _getController.width.value, child: SvgPicture.asset('assets/svgImages/shap.svg', fit: BoxFit.fitWidth, height: _getController.height.value * 0.2))),
                                Positioned(
                                    height: _getController.height.value * 0.2,
                                    top: _getController.height.value * 0.062,
                                    left: _getController.width.value * 0.03,
                                    child: Text('Sahifam'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: _getController.width.value * 0.061, fontWeight: FontWeight.bold))
                                )
                              ]
                          )
                      ),
                      Container(
                          width: _getController.width.value,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                                      child: _getController.meModel.value.data!.result!.avatar == null
                                          ? CircleAvatar(
                                          radius: _getController.width.value * 0.08,
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          child: Text(_getController.meModel.value.data!.result!.fullName.toString().substring(0,1), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: _getController.width.value * 0.06))
                                      )
                                          : CircleAvatar(
                                          radius: _getController.width.value * 0.08,
                                          backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                                      )
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.04, bottom: _getController.width.value * 0.04),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(_getController.meModel.value.data!.result!.fullName.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.045, fontWeight: FontWeight.w600)),
                                            SizedBox(height: _getController.height.value * 0.004),
                                            Text('ID ${_getController.meModel.value.data!.result!.sId.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: _getController.width.value * 0.04))
                                          ]
                                      )
                                  )
                                ]
                              ),
                              SizedBox(
                                  width: _getController.width.value * 0.92,
                                  height: _getController.height.value * 0.06,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => EditUser());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.r)
                                        )
                                      ),
                                      child: Text('Profilni tahrirlash'.tr,
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: _getController.width.value * 0.045
                                          )
                                      )
                                  )
                              ),
                              SizedBox(height: 9.h),
                              AccItem(
                                  title: 'Mualliflar'.tr,
                                  icon: 'assets/icon/copyRight.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/myInfo');
                                  }
                              ),
                              AccItem(
                                  title: 'Mening kitoblarim'.tr,
                                  icon: 'assets/icon/diary.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/myBooks');
                                  }
                              ),
                              AccItem(
                                  title: 'Buyurtmalar'.tr,
                                  icon: 'assets/icon/shopping-cart.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/myOrders');
                                  }
                              ),
                              AccItem(
                                  title: 'Chegirmalar'.tr,
                                  icon: 'assets/icon/ticket.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/myDiscounts');
                                  }
                              ),
                              AccItem(
                                  title: 'Promokod'.tr,
                                  icon: 'assets/icon/badge.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/myPromoCode');
                                  }
                              ),
                              AccItem(
                                  title: 'Tilni o\'zgartirish'.tr,
                                  icon: 'assets/icon/globe.svg',
                                  subTitle: 'uz_UZ' == Get.locale.toString() ? 'O\'zbekcha' : 'oz_OZ' == Get.locale.toString() ? 'Ўзбекча' : 'Русский',
                                  onTap: () {
                                    //buildLanguageDialog(context);
                                    showLanguageBottomSheet(context);
                                  }
                              ),
                              AccItem(
                                  title: 'O\'qish turi'.tr,
                                  icon: 'assets/icon/overview.svg',
                                  subTitle: '',
                                  onTap: () {
                                  }
                              ),
                              AccItem(
                                  title: 'Tungi rejim'.tr,
                                  icon: 'assets/icon/night.svg',
                                  subTitle: '',
                                  switchValue: true,
                                  onTap: () {
                                    AdaptiveTheme.of(context).toggleThemeMode();
                                  }
                              ),
                              AccItem(
                                  title: 'Dastur haqida'.tr,
                                  icon: 'assets/icon/info.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/aboutApp');
                                  }
                              ),
                              AccItem(
                                  title: 'Biz bilan bog\'lanish'.tr,
                                  icon: 'assets/icon/contact.svg',
                                  subTitle: '',
                                  onTap: () {
                                    Get.toNamed('/contactUs');
                                  }
                              ),
                              AccItem(
                                  title: 'Ilovadan chiqish'.tr,
                                  icon: 'assets/icon/exit.svg',
                                  subTitle: '',
                                  color: AppColors.red,
                                  onTap: () {
                                    GetStorage().remove('token');
                                    Get.offAll(const OnboardingPage());
                                  }
                              ),
                              SizedBox(height: _getController.width.value * 0.1)
                            ]
                          )
                      )
                    ]
                ))
            )
        )
    );
  }
}