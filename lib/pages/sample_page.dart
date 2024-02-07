import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../companents/bottombar_icons.dart';
import '../controllers/get_controller.dart';
import '../resource/colors.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

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

  void _onItemTapped(int index) {
    _getController.changeIndex(index);
    _getController.changeWidgetOptions();
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
    _getController.changeWidgetOptions();
    return Scaffold(
      body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
      bottomNavigationBar: BottomAppBar(
        height: _getController.height.value * 0.1,
        surfaceTintColor: Theme.of(context).colorScheme.onSecondary,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.onSecondary,
        color: Theme.of(context).colorScheme.background,
        child: Obx(() => Container(
          margin: EdgeInsets.only(left: _getController.width.value * 0.02, right: _getController.width.value * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //home,shop,library,basket,account
              BottomBarIcons(
                icon: 'assets/icon/home.svg',
                title: 'Asosiy'.tr,
                onTap: () {
                  _onItemTapped(0);
                },
                isSelected: _getController.index.value == 0,
              ),
              BottomBarIcons(
                icon: 'assets/icon/shop.svg',
                title: 'Do\'kon'.tr,
                onTap: () {
                  _onItemTapped(1);
                },
                isSelected: _getController.index.value == 1,
              ),
              BottomBarIcons(
                icon: 'assets/icon/library.svg',
                title: 'Kutubxona'.tr,
                onTap: () {
                  _onItemTapped(2);
                },
                isSelected: _getController.index.value == 2,
              ),
              BottomBarIcons(
                icon: 'assets/icon/basket.svg',
                title: 'Savatcha'.tr,
                onTap: () {
                  _onItemTapped(3);
                },
                isSelected: _getController.index.value == 3,
              ),
              BottomBarIcons(
                icon: 'assets/icon/account.svg',
                title: 'Sahifam'.tr,
                onTap: () {
                  _onItemTapped(4);
                },
                isSelected: _getController.index.value == 4,
              ),
            ],
          ),
        ),
        ),
      )
    );
  }
}