import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
      ApiController().me();
    }
    return Scaffold(
        body: Obx(() => _getController.widgetOptions.elementAt(_getController.index.value)),
        bottomNavigationBar: BottomAppBar(
          height: _getController.height.value * 0.09,
          surfaceTintColor: Theme.of(context).colorScheme.onSecondary,
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.secondary,
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
      print('Connectivity changed: $result');
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
    print(isOnline);
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}