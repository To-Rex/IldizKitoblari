import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/companents/filds/text_large.dart';
import 'package:ildiz/companents/filds/text_small.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:get_storage/get_storage.dart';
import '../companents/acc_item.dart';
import '../controllers/get_controller.dart';
import '../pages/auth/login_page.dart';
import '../pages/home/author_category.dart';
import '../pages/onboarding_page.dart';
import '../pages/profile/about_program.dart';
import '../pages/profile/contact_us.dart';
import '../pages/profile/edit_user.dart';
import '../pages/profile/only_sale_product_page.dart';
import '../pages/profile/orders_page.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final GetController _getController = Get.put(GetController());

  final List locale =[
    {'name':'Russian','locale':const Locale('ru','RU')},
    {'name':'Uzbek','locale':const Locale('uz','UZ')},
    {'name':'Ўзбекча','locale':const Locale('oz','OZ')},
  ];

  updateLanguage(Locale locale){Get.updateLocale(locale);}

  void showLanguageBottomSheet(BuildContext context) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10.0),left: Radius.circular(10.0))),
        enableDrag: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  width: _getController.width.value,
                  height: _getController.height.value * 0.45,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r),left: Radius.circular(10.r))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: _getController.width.value * 0.03, width: _getController.width.value),
                      Container(
                          height: _getController.width.value * 0.01,
                          width: _getController.width.value * 0.1,
                          margin: EdgeInsets.only(top: _getController.width.value * 0.01, bottom: _getController.width.value * 0.06),
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3), borderRadius: BorderRadius.circular(100))
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
                                        child: Text(locale[index]['name'], style: TextStyle(color: locale[index]['locale'] == Get.locale ? AppColors.primaryColor : Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.04, fontWeight: FontWeight.w500))
                                    )
                                ),
                                if (index != locale.length - 1)
                                  Padding(
                                      padding: EdgeInsets.only(left: _getController.width.value * 0.05, right: _getController.width.value * 0.05),
                                      child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2))
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
                                    top: 60.h,
                                    left: _getController.width.value * 0.03,
                                    child: Text('Sahifam'.tr, style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 27.sp, fontWeight: FontWeight.bold))
                                )
                              ]
                          )
                      ),
                      Container(
                          width: _getController.width.value,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r), topRight: Radius.circular(18.r))),
                          child: Column(
                            children: [
                              if (_getController.meModel.value.data != null)
                                Row(
                                    children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 16.w, top: _getController.width.value * 0.045, bottom: _getController.width.value * 0.04),
                                      child: _getController.meModel.value.data!.result!.avatar == null || _getController.meModel.value.data!.result!.avatar == ''
                                          ? CircleAvatar(
                                          radius: 34.r,
                                          backgroundColor: AppColors.grey,
                                          //child: Text(_getController.meModel.value.data!.result!.fullName.toString().substring(0,1), style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: _getController.width.value * 0.06))
                                          child: TextLarge(text: _getController.meModel.value.data!.result!.fullName.toString().contains(' ') ? _getController.meModel.value.data!.result!.fullName.toString().split(' ')[0].substring(0,1) + _getController.meModel.value.data!.result!.fullName.toString().split(' ')[1].substring(0,1) : _getController.meModel.value.data!.result!.fullName.toString().substring(0,1),
                                              color: Theme.of(context).colorScheme.surface, fontSize: _getController.width.value * 0.06, fontWeight: FontWeight.bold )
                                      )
                                          : CircleAvatar(
                                          radius: 34.r,
                                          backgroundImage: NetworkImage(_getController.meModel.value.data!.result!.avatar.toString())
                                      )
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 16.w, top: _getController.width.value * 0.045, bottom: _getController.width.value * 0.04),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(_getController.meModel.value.data!.result!.fullName.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 21.sp, fontWeight: FontWeight.w600)),
                                            SizedBox(height: _getController.height.value * 0.004),
                                            Text('ID ${_getController.meModel.value.data!.result!.sId.toString()}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 17.sp, fontWeight: FontWeight.w500))
                                          ]
                                      )
                                  )
                                ]
                                )
                              else
                                Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 16.w, top: _getController.width.value * 0.045, bottom: _getController.width.value * 0.04),
                                          child: CircleAvatar(
                                              radius: 34.r,
                                              backgroundColor: AppColors.grey,
                                              child: Text('SF', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: _getController.width.value * 0.06))
                                          )
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 16.w, top: _getController.width.value * 0.045, bottom: _getController.width.value * 0.04),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Salom, Foydalanuvchi', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 21.sp, fontWeight: FontWeight.w600)),
                                                SizedBox(height: _getController.height.value * 0.004),
                                                Text('Hush kelibsiz', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontSize: 17.sp, fontWeight: FontWeight.w500))
                                              ]
                                          )
                                      )
                                    ]
                                ),
                              if (_getController.meModel.value.data != null)
                                Container(
                                    width: _getController.width.value,
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                                    height: _getController.height.value * 0.06,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => EditUser());
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                                        child: const TextSmall(text: 'Profilni tahrirlash', color: AppColors.white, fontWeight: FontWeight.bold)
                                    )
                                )
                              else
                                Container(
                                    width: _getController.width.value,
                                    margin: EdgeInsets.only(top: 16.h),
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                                    height: _getController.height.value * 0.06,
                                    child: ElevatedButton(
                                        onPressed: () {Get.to(LoginPage());},
                                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                                        child: const TextSmall(text: 'Ro‘yxatdan o‘tganmisiz?', color: AppColors.white, fontWeight: FontWeight.bold)
                                    )
                                ),
                              SizedBox(height: 9.h),
                              AccItem(
                                  title: 'Mualliflar'.tr,
                                  icon: 'assets/icon/copyRight.svg',
                                  subTitle: '',
                                  onTaps: () {
                                    _getController.clearAuthorModel();
                                    Get.to(() => AuthorCategory());
                                  }
                              ),
                              if (_getController.meModel.value.data != null)
                              AccItem(
                                  title: 'Mening kitoblarim'.tr,
                                  icon: 'assets/icon/diary.svg',
                                  subTitle: '',
                                  onTaps: () {}
                              ),
                              if (_getController.meModel.value.data != null)
                              AccItem(
                                  title: 'Buyurtmalar'.tr,
                                  icon: 'assets/icon/shopping-cart.svg',
                                  subTitle: '',
                                  onTaps: () {
                                    Get.to(OrdersPage());
                                  }
                              ),
                              AccItem(
                                  title: 'Chegirmalar'.tr,
                                  icon: 'assets/icon/ticket.svg',
                                  subTitle: '',
                                  onTaps: () {
                                    Get.to(() => OnlySaleProductPage(), transition: Transition.rightToLeft);
                                  }
                              ),
                              AccItem(
                                  title: 'Promokod'.tr,
                                  icon: 'assets/icon/badge.svg',
                                  subTitle: '',
                                  onTaps: () {}
                              ),
                              AccItem(
                                  title: 'Tilni o‘zgartirish'.tr,
                                  icon: 'assets/icon/globe.svg',
                                  subTitle: 'uz_UZ' == Get.locale.toString() ? 'O‘zbekcha' : 'oz_OZ' == Get.locale.toString() ? 'Ўзбекча' : 'Русский',
                                  onTaps: () {
                                    showLanguageBottomSheet(context);
                                  }
                              ),
                              AccItem(
                                  title: 'O‘qish turi'.tr,
                                  icon: 'assets/icon/overview.svg',
                                  subTitle: '',
                                  onTaps: () {}
                              ),
                              AccItem(
                                  title: 'Tungi rejim'.tr,
                                  icon: 'assets/icon/night.svg',
                                  subTitle: '',
                                  switchValue: true,
                                  onTaps: () {
                                    AdaptiveTheme.of(context).toggleThemeMode();
                                  }
                              ),
                              AccItem(
                                  title: 'Dastur haqida'.tr,
                                  icon: 'assets/icon/info.svg',
                                  subTitle: '',
                                  onTaps: () {
                                    Get.to(() => AboutProgram(), transition: Transition.rightToLeft);
                                  }
                              ),
                              AccItem(
                                  title: 'Biz bilan bog‘lanish'.tr,
                                  icon: 'assets/icon/contact.svg',
                                  subTitle: '',
                                  onTaps: () {
                                    Get.to(() => ContactUs(), transition: Transition.rightToLeft);
                                  }
                              ),
                              if (_getController.meModel.value.data != null)
                              AccItem(
                                  title: 'Ilovadan chiqish'.tr,
                                  icon: 'assets/icon/exit.svg',
                                  subTitle: '',
                                  color: AppColors.red,
                                  onTaps: () {
                                    showDialog(context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                          backgroundColor: Theme.of(context).colorScheme.surface,
                                          title: Text('Dasturdan chiqmoqchimisiz?'.tr),
                                          titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 19.sp),
                                          content: Text('Dasturdan chiqqaningdan so‘ng login va parolingiz orqali qayta kirishingiz mumkin.'.tr),
                                          contentTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.w400, fontSize: 16.sp),
                                          actions: [
                                            SizedBox(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              foregroundColor: Colors.transparent,
                                                              disabledForegroundColor: Colors.transparent,
                                                              shadowColor: Colors.transparent,
                                                              surfaceTintColor: Colors.transparent,
                                                              elevation: 0,
                                                              backgroundColor: AppColors.grey.withOpacity(0.3),
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                                                          ),
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text('Orqaga'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 16.sp))
                                                      )
                                                  ),
                                                  SizedBox(width: Get.width * 0.03),
                                                  Expanded(
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              foregroundColor: Colors.transparent,
                                                              disabledForegroundColor: Colors.transparent,
                                                              shadowColor: Colors.transparent,
                                                              surfaceTintColor: Colors.transparent,
                                                              elevation: 0,
                                                              backgroundColor: AppColors.red,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                                                          ),
                                                          onPressed: () {
                                                            GetStorage().remove('token');
                                                            Get.offAll(const OnboardingPage());
                                                          },
                                                          child: Text('Chiqish'.tr, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500, fontSize: 16.sp))
                                                      )
                                                  )
                                                ],
                                              )
                                            )

                                          ]
                                        )
                                    );
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