import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:ildiz/bottomBar/accaunt_page.dart';
import 'package:ildiz/bottomBar/basket_page.dart';
import 'package:ildiz/bottomBar/home_page.dart';
import 'package:ildiz/bottomBar/library_page.dart';
import 'package:ildiz/bottomBar/shop_page.dart';
import 'package:ildiz/models/me_models.dart';
import 'package:ildiz/models/quotos_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/banner_model.dart';
import '../models/login_model.dart';
import '../models/menu_model.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_rate.dart';

class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;
  var check = false.obs;
  var widgetOptions = <Widget>[];
  var index = 0.obs;
  var bottomBarHeight = 0.0.obs;
  var obscureText = true.obs;
  var fullCheck = false.obs;
  var fullIndex = 0.obs;
  var indexSub = 0.obs;
  var page = 0.obs;
  var productModelLength = 0.obs;
  var passwordCheck = false.obs;

  void setHeightWidth(BuildContext context) {
    height.value = MediaQuery.of(context).size.height;
    width.value = MediaQuery.of(context).size.width;
  }

  void changeWidgetOptions() {
    bottomBarHeight.value = height.value * 0.08;
    widgetOptions.add(HomePage());
    widgetOptions.add(ShopPage());
    widgetOptions.add(LibraryPage());
    widgetOptions.add(BasketPage());
    widgetOptions.add(AccountPage());
  }

  void changeIndex(int index) {
    this.index.value = index;
  }

  void changePage(int page) {
    this.page.value = page;
  }

  var nameController;

  //models
  var loginModel = LoginModel().obs;
  var meModel = MeModel().obs;
  var menuModel = MenuModel().obs;
  var bannerModel = BannerModel().obs;
  var productModel = ProductModel().obs;
  var quotesModel = QuotesModel().obs;
  var productDetailModel = ProductDetailModel().obs;
  var productRate = ProductRate().obs;
  var productDetailList = <ProductDetailModel>[].obs;
  var productRateList = <ProductRate>[].obs;

  void addProductDetailModel(ProductDetailModel productDetailModel) {
    productDetailList.add(productDetailModel);
  }

  void clearProductDetailList() {
    productDetailList.clear();
    productRateList.clear();
  }

  void removeProductDetailModel(int index) {
    if (productDetailList.isNotEmpty&&productDetailList.length>=index){
      productDetailList.removeRange(index, productDetailList.length);
      removeProductRate(index);
    }
  }

  void addProductRate(ProductRate productRate) {
    productRateList.add(productRate);
  }

  void removeProductRate(int index) {
    if (productRateList.isNotEmpty&&productRateList.length>=index){
      productRateList.removeRange(index, productRateList.length);
    }
  }

  //methods
  void changeLoginModel(LoginModel loginModel) {
    this.loginModel.value = loginModel;
  }

  void changeMeModel(MeModel meModel) {
    this.meModel.value = meModel;
  }

  void changeMenuModel(MenuModel menuModel) {
    this.menuModel.value = menuModel;
  }

  void changeBannerModel(BannerModel bannerModel) {
    this.bannerModel.value = bannerModel;
  }

  void changeProductModel(ProductModel productModel) {
    this.productModel.value = productModel;
  }

  //add productModel to productModel list
  void addProductModel(ProductModel productModel) {
    this.productModel.value.data!.result!.addAll(productModel.data!.result!);
  }

  void changeQuotesModel(QuotesModel quotesModel) {
    this.quotesModel.value = quotesModel;
  }

  void changeProductDetailModel(ProductDetailModel productDetailModel) {
    this.productDetailModel.value = productDetailModel;
  }

  //clear productDetailModel
  void clearProductDetailModel() {
    if (productDetailModel.value.data != null) {
      productDetailModel.value = ProductDetailModel();
    }
  }

  //clear productModel
  void clearProductModel() {
    if (productModel.value.data != null) {
      productModelLength.value = 0;
      productModel.value.data!.result!.clear();
    }
  }

  void changeProductRate(ProductRate productRate) {
    this.productRate.value = productRate;
  }

  //clear productRate
  void clearProductRate() {
    if (productRate.value.data != null) {
      productRate.value = ProductRate();
    }
  }

  void addPage() {
    page.value++;
  }
  //productModel length
  void changeProductModelLength(int length) {
    productModelLength.value = length;
  }

  //companents
  final countdownDuration = const Duration(minutes: 1, seconds: 59).obs;
  Timer? _timer;
  void startTimer() {const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (countdownDuration.value.inSeconds == 0) {
          timer.cancel();
        } else {
          countdownDuration.value = countdownDuration.value - oneSec;
        }
      },
    );
  }

  void stopTimer() {
    _timer!.cancel();
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    countdownDuration.value = const Duration(minutes: 1, seconds: 59);
    startTimer();
  }

  //text filds controllers
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final SwiperController swiperController = SwiperController();
}
