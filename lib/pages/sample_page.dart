import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../companents/bottombar_icons.dart';
import '../controllers/api_controller.dart';
import '../controllers/get_controller.dart';

class SamplePage extends StatelessWidget {
  SamplePage({super.key});

  final GetController _getController = Get.put(GetController());

  void _onItemTapped(int index) {
    _getController.changeIndex(index);
    _getController.changeWidgetOptions();
  }

  final MyConnectivity _connectivity = MyConnectivity.instance;


  @override
  Widget build(BuildContext context) {
    _getController.changeWidgetOptions();
    _connectivity.initialise();
    if (_getController.meModel.value.data == null) {
      ApiController().me().then((value) => ApiController().getBasket());
    }
    return Scaffold(
        body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
        bottomNavigationBar: BottomAppBar(
          height: 85.sp,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.onSurface,
          color: Theme.of(context).colorScheme.surface,
          child: Obx(() => Container(
            margin: EdgeInsets.only(left: 5.sp, right: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(0);
                  },
                  child: BottomBarIcons(
                    icon: 'assets/icon/home.svg',
                    title: 'Asosiy'.tr,
                    isSelected: _getController.index.value == 0
                  )
                ),
                InkWell(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    onTap: () {_onItemTapped(1);},
                  child: BottomBarIcons(
                    icon: 'assets/icon/shop.svg',
                    title: 'Do\'kon'.tr,
                    isSelected: _getController.index.value == 1,
                  )
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(2);
                  },
                  child: BottomBarIcons(
                    icon: 'assets/icon/library.svg',
                    title: 'Kutubxona'.tr,
                    isSelected: _getController.index.value == 2,
                  ),
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(3);
                  },
                    child:BottomBarIcons(
                      icon: 'assets/icon/basket.svg',
                      title: 'Savatcha'.tr,
                      isSelected: _getController.index.value == 3,
                    ),
                ),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    _onItemTapped(4);
                  },
                    child:BottomBarIcons(
                      icon: 'assets/icon/account.svg',
                      title: 'Sahifam'.tr,
                      isSelected: _getController.index.value == 4,
                    ),
                ),
              ],
            ),
          ),
          ),
        )
    );
  }
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
      ApiController().showDialogConnectivity(Get.context);
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}