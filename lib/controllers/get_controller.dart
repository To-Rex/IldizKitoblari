import 'dart:async';
import 'dart:convert';
import 'package:flip_widget_flutter/flip_widget_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
import 'package:webview_flutter/webview_flutter.dart';
import '../book_custom_lib/src/utils/text.dart';
import '../models/author_detail_model.dart';
import '../models/author_model.dart';
import '../models/banner_model.dart';
import '../models/basket/cart_create.dart';
import '../models/basket/basket_model.dart';
import '../models/books/task_request.dart';
import '../models/login_model.dart';
import '../models/menu_detail.dart';
import '../models/menu_model.dart';
import '../models/menu_options.dart';
import '../models/orders/country_model.dart';
import '../models/orders/order_create_model.dart';
import '../models/orders/order_detail_model.dart';
import '../models/orders/order_list.dart';
import '../models/orders/order_list_detail.dart';
import '../models/orders/region_model.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_rate.dart';
import '../models/shop/shop_data_model.dart';
import '../models/user/about_model.dart';
import '../models/user/contact_us_model.dart';
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
  List filtersPage = [].obs;
  var genreIndex = 0.obs;
  var genreIndexSub = 0.obs;
  var genreIndexSubSub = 0.obs;
  var checkBoxCardList = <bool>[].obs;
  var allCheckBoxCard = false.obs;
  List dropDownOrders = <int>[].obs;
  var paymentTypeIndex = 0.obs;
  var deliveryPrice = ''.obs;
  //get kGooglePlex => null;



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
    if (!onLoading.value) {
      onLoading.value = true;
    }
  }

  void offLoad() {
    if (onLoading.value) {
      onLoading.value = false;
    }
  }

  void addFilterListSelect(value) => filtersListSelect.add(null);

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

  void changeIndex(int index) {this.index.value = index;}

  void changePage(int page) {this.page.value = page;}

  void changeItemPage(int itemPage) {this.itemPage.value = itemPage;}

  changeImage(String newImage) {image.value = newImage;}

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
  var authorDetailModelList = <AuthorDetailModel>[].obs;
  var authorDetailProductModelList = <ProductModel>[].obs;
  var menuOptionsModel = MenuOptionsModel().obs;
  var menuOptionsModelList = <MenuOptionsModel>[].obs;
  var basketModel = BasketModel().obs;
  var cartCreate = CartCreate().obs;
  List<CartCreate> listCartCreate = <CartCreate>[].obs;
  var getPriceModel = GetPrice().obs;
  var getCountryModel = CountryModel().obs;
  var getRegionModel = RegionModel().obs;
  var orderCreateModel = OrderCreateModel().obs;
  var orderDetailModel = OrderDetailModel().obs;
  var orderListModel = OrderListModel().obs;
  var orderListDetailModel = OrderListDetail().obs;
  var shopDataModel = ShopDataModel().obs;
  var aboutModel = AboutModel().obs;
  var contactUsModel = ContactUsModel().obs;

  void changeContactUsModel(ContactUsModel newContactUsModel) {contactUsModel.value = newContactUsModel;}

  void clearContactUsModel() {contactUsModel.value = ContactUsModel();}

  void changeAboutModel(AboutModel newAboutModel) {aboutModel.value = newAboutModel;}

  void clearAboutModel() {aboutModel.value = AboutModel();}

  void changeShopDataModel(ShopDataModel newShopDataModel) {shopDataModel.value = newShopDataModel;}

  void changeShopDataProductModel(ShopProductModel newShopProductModel, int index) {
    if (shopDataModel.value.data != null && shopDataModel.value.data!.result != null) {
      shopDataModel.update((model) {
        model?.data?.result?[index].shopProductModel = newShopProductModel;
      });
    }
  }

  void clearShopDataModel() {shopDataModel.value = ShopDataModel();}

  void removeShopDataModelMenu(index) {
    if (shopDataModel.value.data != null && shopDataModel.value.data!.result != null) {
      shopDataModel.value.data!.result?.removeAt(index);
    }
  }


  void insertCountryAtStart(ResultCountry country) {getCountryModel.update((model) {model?.data?.result?.insert(0, country);});}

  void insertRegionAtStart(ResultRegion region) {getRegionModel.update((model) {model?.data?.result?.insert(0, region);});}

  void changeOrderListModel(OrderListModel orderList){orderListModel.value = orderList;}
  void changeOrderListDetailModel(OrderListDetail orderListDetail){orderListDetailModel.value = orderListDetail;}

  void clearOrderListModel(){orderListModel.value = OrderListModel();}

  void clearOrderListDetailModel(){orderListDetailModel.value = OrderListDetail();}

  String getWeight() {
    if (orderDetailModel.value.data != null) {
      double totalWeight = 0;
      for (int i = 0; i < orderDetailModel.value.data!.orderProducts!.length; i++) {
        if (orderDetailModel.value.data!.orderProducts![i].product!.weight != null) {
          totalWeight += orderDetailModel.value.data!.orderProducts![i].orderCount! * orderDetailModel.value.data!.orderProducts![i].product!.weight!;
        } else {
          return 'Xatolikkkkk';
        }
      }
      return totalWeight.toString();
    } else {
      return '0';
    }
  }

  void changeOrderDetailModel(OrderDetailModel orderDetail) {orderDetailModel.value = orderDetail;}

  void clearOrderDetailModel() {orderDetailModel.value = OrderDetailModel();}

  void changeOrderCreateModel(OrderCreateModel orderCreate) {orderCreateModel.value = orderCreate;}

  void clearOrderCreateModel() {orderCreateModel.value = OrderCreateModel();}

  void changeCountryModel(CountryModel countryModel) {getCountryModel.value = countryModel;}

  void changeRegionModel(RegionModel regionModel) {getRegionModel.value = regionModel;}

  void clearRegionModel() {getRegionModel.value = RegionModel();}

  void changeGetPrice(GetPrice getPrice) {getPriceModel.value = getPrice;}

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
    if (allCheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = jsonEncode(listCartCreate).toString();
      ApiController().getTotalBasketPrice(data);
    }
  }

  bool checkCardId(id) {
    for (var element in listCartCreate) {
      if (element.sId == id) {
        return true;
      }
    }
    return false;
  }

  String checkCardIdCount(String id) {
    if (GetStorage().read('cart') == null) return '0';
    for (final element in jsonDecode(jsonEncode(GetStorage().read('cart')))) {
      if (element['_id'] == id) {
        return element['count'].toString();
      }
    }
    return '0';
  }

  int checkCardIdIndex(String id) {
    for (var i = 0; i < listCartCreate.length; i++) {
      if (listCartCreate[i].sId == id) {
        return i;
      }
    }
    return 0;
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
    filtersPage.clear();
    menuOptionsModelList.add(menuOptionsModel);
    for (int i = 0; i < menuOptionsModelList.length; i++) {
      filtersPage.add(1);
    }
  }

  void addMenuOptionsModelListDetail(index, MenuOptionsModel menuOptionsModel) => menuOptionsModelList[index].data!.result!.addAll(menuOptionsModel.data!.result!);

  void changeFiltersPage(int index) => filtersPage[index] = filtersPage[index] + 1;

  void clearMenuOptionsModelList() {
    if (menuOptionsModelList.isNotEmpty) {
      menuOptionsModelList.clear();
    }
  }

  void removeMenuOptionsModelList(int index) {if (menuOptionsModelList.isNotEmpty&&menuOptionsModelList.length>=index){menuOptionsModelList.removeRange(index, menuOptionsModelList.length);}}

  void changeMenuDetailModel(MenuDetailModel menuDetailModel) {this.menuDetailModel.value = menuDetailModel;}

  void clearMenuDetailModel() {if (menuDetailModel.value.data != null) {menuDetailModel.value = MenuDetailModel();}}

  void addAuthorDetailProductModelList(ProductModel productModel) {authorDetailProductModelList.add(productModel);}

  void clearAuthorDetailProductModelList() {authorDetailProductModelList.clear();}

  void removeAuthorDetailProductModelList(int index) {
    if (authorDetailProductModelList.isNotEmpty&&authorDetailProductModelList.length>=index){
      authorDetailProductModelList.removeRange(index, authorDetailProductModelList.length);
    }
  }

  void addAuthorDetailModelList(AuthorDetailModel authorDetailModel) {authorDetailModelList.add(authorDetailModel);}

  void clearAuthorDetailModelList() {authorDetailModelList.clear();}

  void changeAuthorDetailProductModelList(int index, ProductModel productModel) {authorDetailProductModelList[index] = productModel;}

  void addProductDetailModel(ProductDetailModel productDetailModel) {productDetailList.add(productDetailModel);}

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

  void addProductRate(ProductRate productRate) {productRateList.add(productRate);}

  void removeProductRate(int index) {
    if (productRateList.isNotEmpty&&productRateList.length>=index){
      productRateList.removeRange(index, productRateList.length);
    }
  }

  void addAuthorDetailModel(AuthorDetailModel authorDetailModel) {authorDetailModelList.add(authorDetailModel);}

  void clearAuthorDetailList() {authorDetailModelList.clear();}

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

  void changeLoginModel(LoginModel loginModel) {this.loginModel.value = loginModel;}

  void changeMeModel(MeModel meModel) {this.meModel.value = meModel;}

  void changeMenuModel(MenuModel menuModel) {this.menuModel.value = menuModel;}

  void deleteMenuModel(int index) {
    if (menuModel.value.data != null && menuModel.value.data!.result != null && menuModel.value.data!.result!.isNotEmpty && index <= menuModel.value.data!.result!.length) {
      menuModel.value.data!.result!.removeAt(index);
    }
  }

  void changeBannerModel(BannerModel bannerModel) {this.bannerModel.value = bannerModel;}

  void clearBannerModel() {
    if (bannerModel.value.data != null) {
      bannerModel.value = BannerModel();
    }
  }

  void addBannerModel(BannerModel bannerModel) {this.bannerModel.value.data!.result!.addAll(bannerModel.data!.result!);}

  void changeProductModel(ProductModel productModel) {this.productModel.value = productModel;}

  void addProductModel(ProductModel productModel) {this.productModel.value.data!.result!.addAll(productModel.data!.result!);}

  void changeQuotesModel(QuotesModel quotesModel) {this.quotesModel.value = quotesModel;}

  void addQuotesModel(QuotesModel quotesModel) {this.quotesModel.value.data!.result!.addAll(quotesModel.data!.result!);}

  void clearQuotesModel() {
    if (quotesModel.value.data != null) {
      quotesModel.value = QuotesModel();
    }
  }

  void changeAuthorModel(AuthorModel authorModel) {
    this.authorModel.value = authorModel;
    productModelLength.value = authorModel.data!.result!.length;
  }

  void clearAuthorModel() {
    if (authorModel.value.data != null) {
      productModelLength.value = 0;
      authorModel.value = AuthorModel();
    }
  }

  void addAuthorModel(AuthorModel authorModel) {
    this.authorModel.value.data!.result!.addAll(authorModel.data!.result!);
    productModelLength.value = productModelLength.value + authorModel.data!.result!.length;
  }

  void changeProductDetailModel(ProductDetailModel productDetailModel) {this.productDetailModel.value = productDetailModel;}

  void clearProductDetailModel() {
    if (productDetailModel.value.data != null) {
      productDetailModel.value = ProductDetailModel();
    }
  }

  void clearProductModel() {
    if (productModel.value.data != null) {
      productModelLength.value = 0;
      productModel.value.data!.result!.clear();
    }
  }

  void changeProductRate(ProductRate productRate) {this.productRate.value = productRate;}

  void clearProductRate() {
    if (productRate.value.data != null) {
      productRate.value = ProductRate();
    }
  }

  void addPage() {page.value++;}

  void addItemPage() {itemPage.value++;}

  void changeProductModelLength(int length) {productModelLength.value = length;}

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

  void stopTimer() {_timer!.cancel();}

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    countdownDuration.value = const Duration(minutes: 1, seconds: 59);
    startTimer();
  }

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
  final TextEditingController addressController = TextEditingController();

  final List<TextEditingController> textControllers = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshLibController = RefreshController(initialRefresh: false);
  final SwiperController swiperController = SwiperController();
  late TabController tabController;
  late final WebViewController controller;

  double calculateTotalHeight() {
    if (basketModel.value.data != null && basketModel.value.data!.result != null && basketModel.value.data!.result!.isNotEmpty) {
      //return basketModel.value.data!.result!.length * Get.height * 0.165 + Get.height * 0.15;
      return (basketModel.value.data!.result!.length +1) * (131.h + 12.h);
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

  String getSelectedCard() {
    if (allCheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = jsonEncode(listCartCreate).toString();
      return data;
    } else if (!allCheckBoxCard.value && listCartCreate.isNotEmpty) {
      var data = jsonEncode(checkBoxCardList.asMap().entries.where((entry) => entry.value).map((entry) => listCartCreate[entry.key]).toList()).toString();
      return data;
    } else {
      return '[]';
    }
  }

  void addTextControllers() => textControllers.add(TextEditingController());

  void clearControllers() {
    if (textControllers.isNotEmpty) {
      textControllers.clear();
    }
  }

  String getFilterTextFields() {
    String params = '';
    for (int index = 0; textControllers.length > index; index++) {
      if (textControllers[index].text != '') {
        params = '$params&value[]=${textControllers[index].text}';
      }
    }
    if (params.isNotEmpty) {
      return params;
    } else {
      return '';
    }
  }

  String getFilterTextSelect() {
    String params = '';
    for (int index = 0; filtersListSelect.length > index; index++) {
      if (filtersListSelect[index] != null && filtersListSelect[index] != -1) {
        params = '$params&value_id[]=${menuOptionsModelList[index].data!.result![filtersListSelect[index]].sId}';
      }
    }
    if (params.isNotEmpty) {
      return params;
    } else {
      return '';
    }
  }

  String getDistrict() {
    if (getRegionModel.value.data!.result!.isNotEmpty) {
      if (getRegionModel.value.data!.result![dropDownOrders[1]].sId != null) {
        debugPrint('${getRegionModel.value.data!.result![dropDownOrders[1]].sId}');
        return getRegionModel.value.data!.result![dropDownOrders[1]].sId ?? '';
      }
    }
    return '';
  }

  String getCountry() {
    if ( getCountryModel.value.data!.result!.isNotEmpty) {
      if (getCountryModel.value.data!.result![dropDownOrders[0]].sId != null) {
        debugPrint('${getCountryModel.value.data!.result![dropDownOrders[0]].sId}');
        return getCountryModel.value.data!.result![dropDownOrders[0]].sId ?? '';
      }
    }
    return '';
  }


  var filePath = ''.obs;
  var currentPage = 0.obs;
  var currentPageBack = 1.obs;
  var totalPages = 0.obs;
  late PDFViewController pdfController;
  late PDFViewController pdfBackController;
  var flipKey = GlobalKey<FlipWidgetState>().obs;
  RxBool isFullScreen = true.obs;

  void setBackController() {
    currentPageBack.value = 1;
    pdfBackController.setPage(currentPageBack.value);
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value - 1) {
      currentPage.value++;
      currentPageBack.value++;
      pdfController.setPage(currentPage.value);
      pdfBackController.setPage(currentPageBack.value);
      //flipKey.value.currentState!.stopFlip();
      Future.delayed(const Duration(milliseconds: 600), () {
        flipKey.value.currentState!.stopFlip();
      });
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      currentPageBack.value--;
      pdfController.setPage(currentPage.value);
      pdfBackController.setPage(currentPageBack.value);
      //flipKey.value.currentState!.stopFlip();
      Future.delayed(const Duration(milliseconds: 600), () {
        flipKey.value.currentState!.stopFlip();
      });
    }
  }

  void toggleFullScreen() {
    debugPrint('toggleFullScreen');
    isFullScreen.value = !isFullScreen.value;
    if (isFullScreen.value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
    }
  }


  //=========================================================================================================================================================
  RxBool whileApi = true.obs;
  RxList allPages = <int>[].obs;
  RxBool isOver = false.obs;
  RxInt currentIndex = 0.obs;
  Rx<Color> backgroundColor = Colors.white.obs;
  Rx<Color> textColor = Colors.black.obs;
  RxDouble fontSize = 18.0.obs;
  RxBool isVertical = false.obs;
  // scrollController book page turn effect for vertical
  final ScrollController scrollController = ScrollController();

  void startLoadingPages(String data, double fontSize, double fontHeight, double maxWidth, EdgeInsetsGeometry padding, double maxTextHeight) {
    allPages.clear();
    whileApi.value = true;

    var request = TaskRequest(data, fontSize, fontHeight, maxWidth, padding, maxTextHeight);

    List<int> pages = [];
    int index = 0;
    pages.add(index);
    int left = index;
    int right = 1000;

    while (whileApi.value) {
      if (right >= request.data.length - 1) {
        right = request.data.length - 1;
      }
      int i = TextUtil.calculateTextMaxTextPos(
        request.data.substring(left, right),
        request.fontSize,
        fontHeight: request.fontHeight,
        maxWidth: request.maxWidth,
        maxLines: (maxTextHeight / TextUtil.calculateTextHeight('La-la-la...', fontSize, fontHeight: fontHeight, maxWidth: maxWidth, padding: padding)).toInt(),
        padding: request.padding,
      );
      index = index + (i == 0 ? right - left : i);
      left = index;
      pages.add(index);
      if (right == request.data.length - 1 && index >= request.data.length - 1) {
        allPages.addAll(pages);
        isOver.value = true;
        return;
      }
      right = index + 1000;

      if (index >= request.data.length - 1) break;
    }
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void setBackgroundColor(Color color) {
    backgroundColor.value = color;
  }

}