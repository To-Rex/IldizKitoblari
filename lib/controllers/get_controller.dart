import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ildiz/bottomBar/accaunt_page.dart';
import 'package:ildiz/bottomBar/basket_page.dart';
import 'package:ildiz/bottomBar/home_page.dart';
import 'package:ildiz/bottomBar/library_page.dart';
import 'package:ildiz/bottomBar/shop_page.dart';
import 'package:ildiz/models/basket/get_price.dart';
import 'package:ildiz/models/me_models.dart';
import 'package:ildiz/models/quotos_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/author_detail_model.dart';
import '../models/author_model.dart';
import '../models/banner_model.dart';
import '../models/basket/cart_create.dart';
import '../models/basket/basket_model.dart';
import '../models/login_model.dart';
import '../models/menu_detail.dart';
import '../models/menu_model.dart';
import '../models/menu_options.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_rate.dart';
import 'api_controller.dart';

class GetController extends GetxController {
  var height = 0.0.obs;
  var width = 0.0.obs;
  var fullName = 'Dilshodjon Haydarov'.obs;
  var onLoading = false.obs;
  var check = false.obs;
  var widgetOptions = <Widget>[];
  var index = 0.obs;
  var bottomBarHeight = 0.0.obs;
  var obscureText = true.obs;
  var fullCheck = false.obs;
  var fullIndex = 0.obs;
  var indexSub = 0.obs;
  var page = 0.obs;
  var itemPage = 0.obs;
  var productModelLength = 0.obs;
  var passwordCheck = false.obs;
  var editCheck = false.obs;
  var image = ''.obs;
  List filters = <bool>[false,false,false,false,false,false].obs;
  List filtersObj = ['','',[]].obs;
  List filtersListSelect = [].obs;
  List filterGenre = [].obs;
  var genreIndex = 0.obs;
  var genreIndexSub = 0.obs;
  var genreIndexSubSub = 0.obs;
  var checkBoxCardList = <bool>[].obs;
  var allCheckBoxCard = false.obs;



  void changeCheckBoxCardList(int i) {
    checkBoxCardList[i] = !checkBoxCardList[i];
    bool allChecked = checkBoxCardList.every((element) => element);
    allCheckBoxCard.value = allChecked;
    ApiController().getTotalBasketPrice(jsonEncode(checkBoxCardList.asMap().entries.where((entry) => entry.value).map((entry) => listCartCreate[entry.key]).toList()));
  }

  void changeAllCheckBoxCardList() {
    if (allCheckBoxCard.value) {
      for (int i = 0; i < checkBoxCardList.length; i++) {
        checkBoxCardList[i] = true;
      }
    } else {
      for (int i = 0; i < checkBoxCardList.length; i++) {
        checkBoxCardList[i] = false;
      }
    }
    ApiController().getTotalBasketPrice(jsonEncode(checkBoxCardList.asMap().entries.where((entry) => entry.value).map((entry) => listCartCreate[entry.key]).toList()));

  }

  void onLoad() {
    onLoading.value = true;
  }

  void offLoad() {
    onLoading.value = false;
  }

  void addFilterListSelect(value){
    filtersListSelect.add(null);
  }

  void changeFilterListSelect(int index,int value){
    if (filtersListSelect[index] == null) {
      filtersListSelect[index] = value;
    } else if (filtersListSelect[index] == value) {
      filtersListSelect[index] = null;
    } else {
      filtersListSelect[index] = value;
    }
  }

  void changeGenreListSelect(int value){
    if (filterGenre[0] == null) {
      filterGenre[0] = value;
    } else if (filterGenre[0] == value) {
      filterGenre[0] = null;
    } else {
      filterGenre[0] = value;
    }
  }

  void changeFilterIndex(index){
    if (index == 0) {
      filters[0] = !filters[0];
      filters[1] = false;
    } else if (index == 1) {
      filters[1] = !filters[1];
      filters[0] = false;
    } else if (index == 2) {
      filters[2] = !filters[2];
      filters[3] = false;
    } else if (index == 3) {
      filters[3] = !filters[3];
      filters[2] = false;
    } else if (index == 4) {
      filters[4] = !filters[4];
      filters[5] = false;
    } else {
      filters[5] = !filters[5];
      filters[4] = false;
    }
  }

  void clearFilters() {
    for (int i = 0; i < filtersListSelect.length; i++) {
      if (filtersListSelect[i] != null) {
        filtersListSelect[i] = null;
      }
    }
    filterGenre[0] = null;
    filtersObj[0] = '';
    filtersObj[1] = '';
    filtersObj[2] = [];
  }

  @override
  void onInit() {
    super.onInit();
    filtersObj.add('');
    filtersObj.add('');
  }

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

  void changeItemPage(int itemPage) {
    this.itemPage.value = itemPage;
  }

  changeImage(String newImage) {
    image.value = newImage;
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
  var authorModel = AuthorModel().obs;
  var menuDetailModel = MenuDetailModel().obs;
  var productDetailList = <ProductDetailModel>[].obs;
  var productRateList = <ProductRate>[].obs;
  var productModelList = <ProductModel>[].obs;
  var authorDetailModelList = <AuthorDetailModel>[].obs;
  var authorDetailProductModelList = <ProductModel>[].obs;
  var menuOptionsModel = MenuOptionsModel().obs;
  var menuOptionsModelList = <MenuOptionsModel>[].obs;
  var basketModel = BasketModel().obs;
  var cartCreate = CartCreate().obs;
  List<CartCreate> listCartCreate = <CartCreate>[].obs;
  var getPriceModel = GetPrice().obs;

  void changeGetPrice(GetPrice getPrice) {
    getPriceModel.value = getPrice;
  }

  void changeBasketModel(BasketModel basketModel) {
    this.basketModel.value = basketModel;
    listCartCreate.clear();
    GetStorage().remove('cart');
    basketModel.data?.result?.forEach((item) {
      listCartCreate.add(CartCreate(
        sId: item.productId,
        count: item.cartCount,
        type: 'active',
      ));
    });
    GetStorage().write('cart', listCartCreate);
    if (allCheckBoxCard.value) {
      var data = jsonEncode(listCartCreate).toString();
      ApiController().getTotalBasketPrice(data);
    }
  }

  void clearBasketModel() {
    basketModel.value = BasketModel();
    listCartCreate.clear();
    checkBoxCardList.clear();
  }

  List<String> getMenuOptionsModelListData(int index) {
    if (menuOptionsModelList[index].data!.result!.isNotEmpty) {
      return menuOptionsModelList[index].data!.result!.map((e) => e.name!.uz!).toList();
    } else {
      return [];
    }
  }

  void addMenuOptionsModelList(MenuOptionsModel menuOptionsModel) {
    menuOptionsModelList.add(menuOptionsModel);
  }

  void clearMenuOptionsModelList() {
    if (menuOptionsModelList.isNotEmpty) {
      menuOptionsModelList.clear();
    }
  }

  void removeMenuOptionsModelList(int index) {
    if (menuOptionsModelList.isNotEmpty&&menuOptionsModelList.length>=index){
      menuOptionsModelList.removeRange(index, menuOptionsModelList.length);
    }
  }

  void changeMenuDetailModel(MenuDetailModel menuDetailModel) {
    this.menuDetailModel.value = menuDetailModel;
  }

  void clearMenuDetailModel() {
    if (menuDetailModel.value.data != null) {
      menuDetailModel.value = MenuDetailModel();
    }
  }

  void addAuthorDetailProductModelList(ProductModel productModel) {
    authorDetailProductModelList.add(productModel);
  }

  void clearAuthorDetailProductModelList() {
    authorDetailProductModelList.clear();
  }

  void removeAuthorDetailProductModelList(int index) {
    if (authorDetailProductModelList.isNotEmpty&&authorDetailProductModelList.length>=index){
      authorDetailProductModelList.removeRange(index, authorDetailProductModelList.length);
    }
  }

  void addAuthorDetailModelList(AuthorDetailModel authorDetailModel) {
    authorDetailModelList.add(authorDetailModel);
  }

  void clearAuthorDetailModelList() {
    authorDetailModelList.clear();
  }

  void changeAuthorDetailProductModelList(int index, ProductModel productModel) {
    authorDetailProductModelList[index] = productModel;
  }

  void addProductModelList(ProductModel productModel) {
    productModelList.add(productModel);
  }

  void clearProductModelList() {
    productModelList.clear();
  }

  void removeProductModelList(int index) {
    if (productModelList.isNotEmpty&&productModelList.length>=index){
      productModelList.removeRange(index, productModelList.length);
    }
  }

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

  void addAuthorDetailModel(AuthorDetailModel authorDetailModel) {
    authorDetailModelList.add(authorDetailModel);
  }

  void clearAuthorDetailList() {
    authorDetailModelList.clear();
  }

  void removeAuthorDetailModel(int index) {
    if (authorDetailModelList.isNotEmpty&&authorDetailModelList.length>=index){
      authorDetailModelList.removeRange(index, authorDetailModelList.length);
    }
  }

  void clearMenuModel() {
    if (menuModel.value.data != null && menuModel.value.data!.result != null && menuModel.value.data!.result!.isNotEmpty) {
      menuModel.value.data!.result!.clear();
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

  //delete menuModel data result list index
  void deleteMenuModel(int index) {
    if (menuModel.value.data != null && menuModel.value.data!.result != null && menuModel.value.data!.result!.isNotEmpty && index <= menuModel.value.data!.result!.length) {
      menuModel.value.data!.result!.removeAt(index);
    }
  }

  void changeBannerModel(BannerModel bannerModel) {
    this.bannerModel.value = bannerModel;
  }

  //clear
  void clearBannerModel() {
    if (bannerModel.value.data != null) {
      bannerModel.value = BannerModel();
    }
  }

  //add banner
  void addBannerModel(BannerModel bannerModel) {
    this.bannerModel.value.data!.result!.addAll(bannerModel.data!.result!);
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

  //add quotes
  void addQuotesModel(QuotesModel quotesModel) {
    this.quotesModel.value.data!.result!.addAll(quotesModel.data!.result!);
  }

  //clear quotes
  void clearQuotesModel() {
    if (quotesModel.value.data != null) {
      quotesModel.value = QuotesModel();
    }
  }

  //authorModel
  void changeAuthorModel(AuthorModel authorModel) {
    this.authorModel.value = authorModel;
    productModelLength.value = authorModel.data!.result!.length;
  }

  //clear authorModel
  void clearAuthorModel() {
    if (authorModel.value.data != null) {
      productModelLength.value = 0;
      authorModel.value = AuthorModel();
    }
  }

  //add authorModel
  void addAuthorModel(AuthorModel authorModel) {
    this.authorModel.value.data!.result!.addAll(authorModel.data!.result!);
    productModelLength.value = productModelLength.value + authorModel.data!.result!.length;
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

  void addItemPage() {
    itemPage.value++;
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
  final TextEditingController searchController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController startPriceController = TextEditingController();
  final TextEditingController endPriceController = TextEditingController();

  final List<TextEditingController> textControllers = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final SwiperController swiperController = SwiperController();
  late TabController tabController;

  double calculateTotalHeight() {
    if (basketModel.value.data != null && basketModel.value.data!.result != null && basketModel.value.data!.result!.isNotEmpty) {
      return basketModel.value.data!.result!.length * Get.height * 0.165 + Get.height * 0.085;
    } else {
      return Get.height * 0.7;
    }
  }

  String getPrice() {
    int total = 0;
    if (allCheckBoxCard.value && basketModel.value.data != null && basketModel.value.data?.result != null) {
      for (var item in basketModel.value.data!.result!) {
        if (item.price != null) {
          total += item.price!;
        }
      }
      return total.toString();
    } else if (!allCheckBoxCard.value &&basketModel.value.data != null && basketModel.value.data?.result != null) {
      for (int i = 0; i < checkBoxCardList.length; i++) {
        if (checkBoxCardList[i] && basketModel.value.data!.result![i].price != null) {
          total += basketModel.value.data!.result![i].price!;
        }
      }
      return total.toString() == '0' ? '0' : total.toString();
    } else {
      return '0';
    }
  }

  void addTextControllers() {
    textControllers.add(TextEditingController());
  }

  void clearControllers() {
    if (textControllers.isNotEmpty) {
      textControllers.clear();
    }
  }

}