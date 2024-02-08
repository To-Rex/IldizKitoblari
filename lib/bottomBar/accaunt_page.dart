import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ildiz/resource/colors.dart';

import '../companents/acc_item.dart';
import '../controllers/get_controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final GetController _getController = Get.put(GetController());

  final List locale =[
    {'name':'English','locale':Locale('en','US')},
    {'name':'Russian','locale':Locale('ru','RU')},
    {'name':'Uzbek','locale':Locale('uz','UZ')}
  ];

  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
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
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          child: SvgPicture.asset('assets/svgImages/shap.svg',
                              fit: BoxFit.fitWidth,
                              height: _getController.height.value * 0.2),
                        )),
                    Positioned(
                        height: _getController.height.value * 0.2,
                        top: _getController.height.value * 0.04,
                        left: _getController.width.value * 0.03,
                        child: Text('Sahifam'.tr,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: _getController.width.value * 0.07,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Positioned(
                        width: _getController.width.value,
                        top: _getController.height.value * 0.11,
                        child: Container(
                            width: _getController.width.value,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.05),
                                        child: CircleAvatar(
                                            radius: _getController.width.value * 0.07,
                                            backgroundImage: const AssetImage('assets/images/oo4.png')
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: _getController.width.value * 0.05, top: _getController.width.value * 0.05),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dilshodjon Haydarov'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.05)),
                                            Text('ID 644a520d1d9b3384ec163d1b'.tr, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: _getController.width.value * 0.04))
                                          ]
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(height: _getController.width.value * 0.04),
                                SizedBox(
                                    width: _getController.width.value * 0.91,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed('/myInfo');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryColor2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                        ),
                                        child: Text('Profilni tahrirlash'.tr,
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: _getController.width.value * 0.04
                                            )
                                        )
                                    )
                                ),
                                AccItem(
                                    title: 'Mualliflar'.tr,
                                    icon: Icons.person,
                                    onTap: () {
                                      Get.toNamed('/myInfo');
                                    }
                                ),
                                AccItem(
                                    title: 'Mening kitoblarim'.tr,
                                    icon: Icons.book,
                                    onTap: () {
                                      Get.toNamed('/myBooks');
                                    }
                                ),
                                //Buyurtmalar
                                AccItem(
                                    title: 'Buyurtmalar'.tr,
                                    icon: Icons.shopping_cart,
                                    onTap: () {
                                      Get.toNamed('/myOrders');
                                    }
                                ),
                                //chegirmalar
                                AccItem(
                                    title: 'Chegirmalar'.tr,
                                    icon: Icons.local_offer,
                                    onTap: () {
                                      Get.toNamed('/myDiscounts');
                                    }
                                ),
                                //promokod
                                AccItem(
                                    title: 'Promokod'.tr,
                                    icon: Icons.qr_code,
                                    onTap: () {
                                      Get.toNamed('/myPromoCode');
                                    }
                                ),
                                //tilni o'zgartirish
                                AccItem(
                                    title: 'Tilni o\'zgartirish'.tr,
                                    icon: Icons.language,
                                    onTap: () {
                                      buildLanguageDialog(context);
                                    }
                                ),
                                //O\'qish turi
                                AccItem(
                                    title: 'O\'qish turi'.tr,
                                    icon: Icons.read_more,
                                    onTap: () {
                                      Get.toNamed('/readingMode');
                                    }
                                ),
                                //Tungi rejim
                                AccItem(
                                    title: 'Tungi rejim'.tr,
                                    icon: Icons.nightlight_round,
                                    onTap: () {
                                      AdaptiveTheme.of(context).toggleThemeMode();
                                    }
                                ),
                                //Dastur haqida
                                AccItem(
                                    title: 'Dastur haqida'.tr,
                                    icon: Icons.info,
                                    onTap: () {
                                      Get.toNamed('/aboutApp');
                                    }
                                ),
                                //Biz bilan bog'lanish
                                AccItem(
                                    title: 'Biz bilan bog\'lanish'.tr,
                                    icon: Icons.phone,
                                    onTap: () {
                                      Get.toNamed('/contactUs');
                                    }
                                ),
                                //Ilovadan chiqish
                                AccItem(
                                    title: 'Ilovadan chiqish'.tr,
                                    icon: Icons.exit_to_app,
                                    onTap: () {
                                      Get.toNamed('/exitApp');
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