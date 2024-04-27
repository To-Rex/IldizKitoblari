import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';
import 'package:get_storage/get_storage.dart';
import '../companents/acc_item.dart';
import '../controllers/get_controller.dart';
import '../pages/onboarding_page.dart';
import '../pages/profile/edit_user.dart';

class AccountPage1 extends StatelessWidget {
  AccountPage1({super.key});
  final GetController _getController = Get.put(GetController());

  final List locale =[
    //{'name':'English','locale':const Locale('en','US')},
    {'name':'Russian','locale':const Locale('ru','RU')},
    {'name':'Uzbek','locale':const Locale('uz','UZ')},
    {'name':'Ўзбекча','locale':const Locale('oz','OZ')},
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: locale.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: (){
                          updateLanguage(locale[index]['locale']);
                        }
                      )
                    );
                  }
              )
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              height: _getController.height.value * 1.1,
              width: _getController.width.value,
              child: Obx(() => Stack(
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: 0, left: 0, right: 0,
                        child: SizedBox(
                          child: SvgPicture.asset('assets/svgImages/shap.svg',
                              fit: BoxFit.fitWidth,
                              height: _getController.height.value * 0.2),
                        )),
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: _getController.height.value * 0.06,
                        left: _getController.width.value * 0.03,
                        child: Text('Sahifam'.tr,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: _getController.width.value * 0.06,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Positioned(
                        width: _getController.width.value, top: _getController.height.value * 0.12,
                        child: Container(
                            width: _getController.width.value,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
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
                                  ],
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
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
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
                                SizedBox(height: _getController.width.value * 0.025),
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
                                //Buyurtmalar
                                AccItem(
                                    title: 'Buyurtmalar'.tr,
                                    icon: 'assets/icon/shopping-cart.svg',
                                    subTitle: '',
                                    onTap: () {
                                      Get.toNamed('/myOrders');
                                    }
                                ),
                                //chegirmalar
                                AccItem(
                                    title: 'Chegirmalar'.tr,
                                    icon: 'assets/icon/ticket.svg',
                                    subTitle: '',
                                    onTap: () {
                                      Get.toNamed('/myDiscounts');
                                    }
                                ),
                                //promokod
                                AccItem(
                                    title: 'Promokod'.tr,
                                    icon: 'assets/icon/badge.svg',
                                    subTitle: '',
                                    onTap: () {
                                      Get.toNamed('/myPromoCode');
                                    }
                                ),
                                //tilni o'zgartirish
                                AccItem(
                                    title: 'Tilni o\'zgartirish'.tr,
                                    icon: 'assets/icon/globe.svg',
                                    //get locale
                                    subTitle: Get.locale!.languageCode == 'en' ? 'English' : Get.locale!.languageCode == 'ru' ? 'Russian' : 'O\'zbekcha',
                                    onTap: () {
                                      buildLanguageDialog(context);
                                    }
                                ),
                                //O\'qish turi
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
                                //Dastur haqida
                                AccItem(
                                    title: 'Dastur haqida'.tr,
                                    icon: 'assets/icon/info.svg',
                                    subTitle: '',
                                    onTap: () {
                                      Get.toNamed('/aboutApp');
                                    }
                                ),
                                //Biz bilan bog'lanish
                                AccItem(
                                    title: 'Biz bilan bog\'lanish'.tr,
                                    icon: 'assets/icon/contact.svg',
                                    subTitle: '',
                                    onTap: () {
                                      Get.toNamed('/contactUs');
                                    }
                                ),
                                //Ilovadan chiqish
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
                                //SizedBox(height: _getController.width.value * 0.1),
                              ],
                            )
                        )
                    )
                  ]
              ))
          ),
        )
    );
  }
}