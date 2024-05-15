import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:ildiz/models/login_model.dart';
import '../models/author_detail_model.dart';
import '../models/author_model.dart';
import '../models/banner_model.dart';
import '../models/basket/cart_create.dart';
import '../models/basket_model.dart';
import '../models/me_models.dart';
import '../models/menu_detail.dart';
import '../models/menu_model.dart';
import '../models/menu_options.dart';
import '../models/product_detail_model.dart';
import '../models/product_model.dart';
import '../models/product_rate.dart';
import '../models/quotos_model.dart';
import '../pages/auth/verify_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/sample_page.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());
  static const String _baseUrl = 'https://ildizkitoblari.uz';

  //auth
  static const String _login = '$_baseUrl/api/v1/auth/login';
  static const String _check = '$_baseUrl/api/v1/user/check';
  static const String _otp = '$_baseUrl/api/v1/otp';
  static const String _create = '$_baseUrl/api/v1/user/create';
  static const String _me = '$_baseUrl/api/v1/user/me';
  static const String _checkOtp = '$_baseUrl/api/v1/otp/check';
  static const String _passwordUpdate = '$_baseUrl/api/v1/user/password-update';

  //home
  static const String _menu = '$_baseUrl/api/v1/menu/mobile/list';
  static const String _menuDetail = '$_baseUrl/api/v1/menu/';
  static const String _banner = '$_baseUrl/api/v1/banner/list?limit=6';
  static const String _product = '$_baseUrl/api/v1/product/list?limit=12';
  static const String _productDetail = '$_baseUrl/api/v1/product/';
  static const String _productRate = '$_baseUrl/api/v1/product/rate/';
  static const String _quotation = '$_baseUrl/api/v1/banner/quotation/list';
  static const String _update = '$_baseUrl/api/v1/user/update';
  static const String _comment = '$_baseUrl/api/v1/product/comment/create';
  static const String _authors = '$_baseUrl/api/v1/author/list';
  static const String _authorDetail = '$_baseUrl/api/v1/author/';
  //https://ildizkitoblari.uz/api/v1/product/list?limit=12&page=1&value_id[]=643a5f49590e7e6f7fb931cc
  static const String _authorProduct = '$_baseUrl/api/v1/product/list';
  //https://ildizkitoblari.uz/api/v1/options/select/list?page=1&option_id=643a5ed8590e7e6f7fb931c6&menu_slug=badiiy-kitoblar&limit=10
  static const String _getMenuOptions = '$_baseUrl/api/v1/options/select/list';
  //https://ildizkitoblari.uz/api/v1/cart/list
  static const String _getCart = '$_baseUrl/api/v1/cart/list';
  //https://ildizkitoblari.uz/api/v1/user/cart/create
  static const String _addCart = '$_baseUrl/api/v1/user/cart/create';


  //show toast message
  void showToast(context,String title,String message, error,sec) {
    Get.snackbar(
      title.tr,
      message.tr,
      backgroundColor: error ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
      colorText: error ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.surface,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
          bottom: _getController.height.value * 0.03,
          left: _getController.width.value * 0.04,
          right: _getController.width.value * 0.04
      ),
      borderRadius: 12,
      duration: Duration(seconds: sec),
      icon: error ? Icon(
        Icons.error,
        color: Theme.of(context).colorScheme.onError,
      ) : null,
    );
  }

  //show dialog connectivity
  void showDialogConnectivity(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Internet bağlanmadi'.tr),
          content: Text('Internet bağlanmadi'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('Yana qayta urinish'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      },
    );
  }

  //auth
  //------------------------------------------------------------------------------------------------
  Future<void> login() async {
    var response = await post(Uri.parse(_login), body: {
      'phone': _getController.phoneController.text.toString(),
      'password': _getController.passwordController.text.toString(),
      'remember': 'false',
    });
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == true) {
        _getController.changeLoginModel(LoginModel.fromJson(jsonDecode(response.body)));
        _getController.changeMeModel(MeModel.fromJson(jsonDecode(response.body)));
        debugPrint('token: ${_getController.loginModel.value.data!.token}');
        GetStorage().write('token', _getController.loginModel.value.data!.token);
        if (GetStorage().read('token') != null) {
          Get.offAll(SamplePage());
        }
      } else {
        if (jsonDecode(response.body)['data']['message'] == 'User not found!') {
          showToast(Get.context, 'Xatolik', 'Bunday foydalanuvchi mavjud emas!', true, 3);
        }else{
          showToast(Get.context, 'Xatolik', 'Noto\'g\'ri parol kiritdingiz!', true, 3);
        }
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> check(type, resend) async {
    var response = await post(Uri.parse(_check), body: {
      'phone': _getController.phoneController.text.toString(),
      'type': type.toString(),
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('check: ${_getController.phoneController.text}');
      if (jsonDecode(response.body)['status'] == true) {
        debugPrint('check: ${_getController.phoneController.text}');
        otp(_getController.phoneController.text, type, resend);
      }else{
        if (resend == true && jsonDecode(response.body)['data']['message'] == 'User already exists!'){
          otp(_getController.phoneController.text, type, resend);
        }else{
          showToast(Get.context, 'Xatolik', 'Bunday foydalanuvchi mavjud!', true, 3);
        }
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> otp(phone, type, resend) async {
    var response = await post(Uri.parse(_otp), body: {
      'phone': phone,
      'type': type.toString(),
    });
    if (response.statusCode == 200) {
      debugPrint('otp: ${response.body}');
      if (jsonDecode(response.body)['status'] == true) {
        _getController.resetTimer();
        if (!resend) {
          Get.to(VerifyPage());
        }else{
          _getController.fullCheck.value = false;
          _getController.passwordCheck.value = true;
          _getController.resetTimer();
        }
      }else{
        showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> create(String fullName, String otp, String password, String phone) async {
    debugPrint('create: $fullName, $otp, $password, $phone');
    var response = await post(Uri.parse(_create),
        body: {
          'full_name': fullName,
          'otp': otp.toString(),
          'password': password,
          'phone': phone,
        }
    );
    if (response.statusCode == 200|| response.statusCode == 201) {
      debugPrint('create: ${response.body}');
      if (jsonDecode(response.body)['status'] == true) {
        _getController.changeLoginModel(LoginModel.fromJson(jsonDecode(response.body)));
        _getController.changeMeModel(MeModel.fromJson(jsonDecode(response.body)));
        GetStorage().write('token', _getController.loginModel.value.data!.token);
        Get.offAll(SamplePage());
        debugPrint('token: ${_getController.loginModel.value.data!.token}');
      }else{
        if (jsonDecode(response.body)['data']['message'] == 'OTP is wrong!') {
          showToast(Get.context, 'Xatolik', 'Kod noto\'g\'ri!', true, 3);
        }else{
          showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
        }
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> me() async {
    debugPrint('token: ${GetStorage().read('token')}');
    var response = await get(Uri.parse(_me), headers: {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    });
    debugPrint('me: ${response.body}');
    if (response.statusCode == 200) {
      _getController.changeMeModel(MeModel.fromJson(jsonDecode(response.body)));
    } else if (response.statusCode == 401) {
      Get.offAll(const OnboardingPage());
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  //edit user

  Future<void> editUser(avatar) async {
    var headers = {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    };
    var request = http.MultipartRequest('PUT', Uri.parse(_update));
    request.fields.addAll({
      'full_name': _getController.fullNameController.text.toString(),
    });
    if (avatar != null && avatar != '') {
      debugPrint('avatar: $avatar');
      request.files.add(await http.MultipartFile.fromPath('avatar', avatar));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      me();
      _getController.image.value = '';
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }

  }

  Future<void> checkOtp() async {
    var response = await post(Uri.parse(_checkOtp), body: {
      'phone': _getController.phoneController.text.toString(),
      'otp': _getController.codeController.text.toString(),
    });
    if (response.statusCode == 200) {
      debugPrint('checkOtp: ${response.body}');
      if (jsonDecode(response.body)['status'] == true) {
        _getController.fullCheck.value = true;
        _getController.passwordCheck.value = false;
      }else{
        showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> passwordUpdate() async {
    var response = await put(Uri.parse(_passwordUpdate), body: {
      'phone': _getController.phoneController.text.toString(),
      'password': _getController.passwordController.text.toString(),
    });
    debugPrint('passwordUpdate: ${response.body}');
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == true) {
        showToast(Get.context, 'Muvaffaqiyatli', 'Parolni muvaffaqiyatli o\'zgartirdingiz!', false, 3);
        Get.offAll(const OnboardingPage());
        _getController.phoneController.clear();
        _getController.passwordController.clear();
        _getController.codeController.clear();
      }else{
        showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  //home
  //------------------------------------------------------------------------------------------------
  Future<void> getMenu() async {
    var response = await get(Uri.parse(_menu),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('menu: ${response.body}');
    if (response.statusCode == 200) {
      _getController.changeMenuModel(MenuModel.fromJson(jsonDecode(response.body)));
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getMenuDetail(slug) async {
    print('=======================================================================================================================)');
    print('${_menuDetail}$slug');
    var response = await get(Uri.parse('$_menuDetail$slug'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('menu: ${response.body}');
    if (response.statusCode == 200) {
      _getController.clearMenuDetailModel();
      _getController.changeMenuDetailModel(MenuDetailModel.fromJson(jsonDecode(response.body)));
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getMenuOption(page, menuIndex, slug, limit, add) async {
    List optionIdList = [];

    optionIdList = _getController.menuDetailModel.value.data!.options!.map((e) => e.optionId?.sId).toList();
    for (var _ in optionIdList) {
      _getController.addFilterListSelect(null);
    }
    int childrenLength = _getController.menuModel.value.data!.result![menuIndex].children!.length;
    for (int i = 0; i < childrenLength; i++) {
      if (i < optionIdList.length) {
        var response = await get(Uri.parse('$_getMenuOptions?page=$page&option_id=${optionIdList[i]}&menu_slug=$slug&limit=$limit'),
          headers: {'Accept-Language': Get.locale!.languageCode},
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          _getController.addTextControllers();
          if (!add) {
            _getController.clearMenuOptionsModelList();
            _getController.addMenuOptionsModelList(MenuOptionsModel.fromJson(jsonDecode(response.body)));
          }
          _getController.addMenuOptionsModelList(MenuOptionsModel.fromJson(jsonDecode(response.body)));
        }
      }
    }
  }

  Future<void> getMenuOptions(page,optionId,slug,limit,add) async {
    //https://ildizkitoblari.uz/api/v1/options/select/list?page=1&option_id=643a5ed8590e7e6f7fb931c6&menu_slug=badiiy-kitoblar&limit=10
    debugPrint('====${_getMenuOptions}?page=$page&option_id=$optionId&menu_slug=$slug&limit=$limit');
    var response = await get(Uri.parse('$_getMenuOptions?page=$page&option_id=$optionId&menu_slug=$slug&limit=$limit'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('menu: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (add==false) {
        _getController.clearMenuOptionsModelList();
        _getController.addMenuOptionsModelList(MenuOptionsModel.fromJson(jsonDecode(response.body)));
      } else{
        _getController.addMenuOptionsModelList(MenuOptionsModel.fromJson(jsonDecode(response.body)));
      }
    }
  }

  Future<void> getBanner(page, type) async {
    var response = await get(Uri.parse('$_banner&page=$page&type=$type'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    //debugPrint('banner: ${response.body}');
    getMenu();
    if (response.statusCode == 200) {
      if(type == 1){
        _getController.changeBannerModel(BannerModel.fromJson(jsonDecode(response.body)));
      }else{
        _getController.changeQuotesModel(QuotesModel.fromJson(jsonDecode(response.body)));
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getProduct(page, menuSlug,bool add, price, newProduct, famous,name) async {

    //var response = await get(Uri.parse('$_product&page=$page&menu_slug=$menuSlug${price==null?'':'&price=$price'}${newProduct==null?'':'&new_product=$newProduct'}${famous==null?'':'&famous=$famous'}${name==null?'':'&name=$name'}'),
    //https://ildizkitoblari.uz/api/v1/product/list?limit=12&page=1&menu_slug=badiiy-kitoblar&start_price=1000&end_price=100000
    var response = await get(Uri.parse('$_product&page=$page&menu_slug=$menuSlug${price==null?'':'&price=$price'}${newProduct==null?'':'&new_product=$newProduct'}${famous==null?'':'&famous=$famous'}${name==null?'':'&name=$name'}${_getController.filtersObj[0]==''?'':'&start_price=${_getController.filtersObj[0]}'}${_getController.filtersObj[1]==''?'':'&end_price=${_getController.filtersObj[1]}'}'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );

    debugPrint('product: ${response.body}');
    debugPrint('$_product&page=$page&menu_slug=$menuSlug${price==null?'':'&price=$price'}${newProduct==null?'':'&new_product=$newProduct'}${famous==null?'':'&famous=$famous'}${name==null?'':'&name=$name'}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (add==false) {
        _getController.clearProductModel();
        _getController.changeProductModel(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.changeProductModelLength(_getController.productModel.value.data!.result!.length);
      }else{
        _getController.addProductModel(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.changeProductModelLength(_getController.productModel.value.data!.result!.length);
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getSelectProduct(page, menuSlug,bool add, price, newProduct, famous,name) async {
    debugPrint('getProduct: $page, $menuSlug');
    //var response = await get(Uri.parse('$_product&page=$page&parent_slug=$menuSlug'),
    var response = await get(Uri.parse('$_product&page=$page&parent_slug=$menuSlug${price==null?'':'&price=$price'}${newProduct==null?'':'&new_product=$newProduct'}${famous==null?'':'&famous=$famous'}${name==null?'':'&name=$name'}'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    //debugPrint('product: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (add==false) {
        _getController.clearProductModel();
        _getController.changeProductModel(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.changeProductModelLength(_getController.productModel.value.data!.result!.length);
      }else{
        _getController.addProductModel(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.changeProductModelLength(_getController.productModel.value.data!.result!.length);
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  //https://ildizkitoblari.uz/api/v1/product/list?limit=12&page=1&famous=true
  //get top product
  Future<void> getTopProduct(page,bool add) async {
    var response = await get(Uri.parse('$_product&page=$page&famous=true'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('topProduct: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (add==false) {
        _getController.clearProductModel();
        _getController.changeProductModel(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.changeProductModelLength(_getController.productModel.value.data!.result!.length);
      }else{
        _getController.addProductModel(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.changeProductModelLength(_getController.productModel.value.data!.result!.length);
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getItemsProduct(page,List menuSlug,bool add,String search) async {
    var lang = Get.locale!.languageCode;
    for (var i = 0; i < menuSlug.length; i++) {
      //var response = await get(Uri.parse('$_product&page=$page&parent_slug=${menuSlug[i]}'),
      var response = await get(Uri.parse('$_product&page=$page&parent_slug=${menuSlug[i]}&search=$search'),
        headers: {
          'Accept-Language': lang,
        },
      );
      debugPrint('product: ${response.body}');
      print('product: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(response.body)['data']['result'].isEmpty) {
          debugPrint('menuSlugssss: ${menuSlug[i]}');
          _getController.deleteMenuModel(_getController.itemPage.value);
          continue;
        }
        if (add==false) {
          _getController.clearProductModelList();
          _getController.addProductModelList(ProductModel.fromJson(jsonDecode(response.body)));
          _getController.changeItemPage(2);
        }else{
          _getController.addProductModelList(ProductModel.fromJson(jsonDecode(response.body)));
          _getController.addItemPage();
        }
      } else {
        _getController.deleteMenuModel(_getController.itemPage.value);
        showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
      }
    }
  }

  Future<void> getItemsProductSearch(page,bool add,String search) async {
    var lang = Get.locale!.languageCode;
    List menuSlug;
    //menuSlug = _getController.menuModel.value.data!.result![0].slug!;
    menuSlug = _getController.menuModel.value.data!.result!.map((e) => e.slug).toList();
    for (var i = 0; i < menuSlug.length; i++) {
      //var response = await get(Uri.parse('$_product&page=$page&parent_slug=${menuSlug[i]}'),
      var response = await get(Uri.parse('$_product&page=$page&parent_slug=${menuSlug[i]}&search=$search'),
        headers: {
          'Accept-Language': lang,
        },
      );
      debugPrint('product: ${response.body}');
      print('product: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(response.body)['data']['result'].isEmpty) {
          debugPrint('menuSlugssss: ${menuSlug[i]}');
          _getController.deleteMenuModel(_getController.itemPage.value);
          continue;
        }
        if (add==false) {
          _getController.clearProductModelList();
          _getController.addProductModelList(ProductModel.fromJson(jsonDecode(response.body)));
          _getController.changeItemPage(2);
        }else{
          _getController.addProductModelList(ProductModel.fromJson(jsonDecode(response.body)));
          _getController.addItemPage();
        }
      } else {
        _getController.deleteMenuModel(_getController.itemPage.value);
        showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
      }
    }
  }

  Future<void> getProductDetail(id) async {
    var response = await get(Uri.parse('$_productDetail$id'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('productDetail: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      //_getController.changeProductDetailModel(ProductDetailModel.fromJson(jsonDecode(response.body)));
      _getController.addProductDetailModel(ProductDetailModel.fromJson(jsonDecode(response.body)));
      //getProductRate(_getController.productDetailModel.value.data!.sId);
      getProductRate(jsonDecode(response.body)['data']['_id']);
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getProductRate(id) async {
    var response = await get(Uri.parse('$_productRate$id'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('productRate: ${response.body}');
    if (response.statusCode == 200) {
      _getController.changeProductRate(ProductRate.fromJson(jsonDecode(response.body)));
      _getController.addProductRate(ProductRate.fromJson(jsonDecode(response.body)));
      //_getController.ratingController.text = _getController.productRate.value.data!.result!.average!.toString();
      _getController.ratingController.text = jsonDecode(response.body)['data']['result']['average'].toString();
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getQuotation(page) async {
    var response = await get(Uri.parse('$_quotation?limit=5&page=$page'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    //debugPrint('quotation: ${response.body}');
    if (response.statusCode == 200) {
      _getController.changeQuotesModel(QuotesModel.fromJson(jsonDecode(response.body)));
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> createComment(String description,String productId,rate) async {
    debugPrint('comment: $description, $productId, $rate');
    var response = await post(Uri.parse(_comment),
        headers: {
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
        body: {'description': description,
          'product_id': productId,
          'rate': rate.toString()
    });
    debugPrint('comment: ${response.body}');
    debugPrint('comment: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('comment: ${response.body}');
      _getController.commentController.clear();
    }else{
      debugPrint('comment: ${response.body}');
    }
  }

  Future<void> getAuthors(limit,page,search,add) async {
    var response = await get(Uri.parse('$_authors?limit=$limit&page=$page&search=$search'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('authors: ${response.body}');
    if (response.statusCode == 200) {
      if (add==false) {
        _getController.clearAuthorModel();
        _getController.itemPage.value = 1;
        _getController.changeAuthorModel(AuthorModel.fromJson(jsonDecode(response.body)));
      } else {
        _getController.addAuthorModel(AuthorModel.fromJson(jsonDecode(response.body)));
        _getController.addItemPage();
      }
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getAuthorDetail(id) async {
    var response = await get(Uri.parse('$_authorDetail$id'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('authorDetail: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      _getController.addAuthorDetailModel(AuthorDetailModel.fromJson(jsonDecode(response.body)));
      print(_getController.authorDetailModelList.length);
      //print(_getController.authorDetailModelList[0].data!.name?.oz);
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> getAuthorsProducts(limit,page,search,add,id) async {
    var response = await get(Uri.parse('$_authorProduct?limit=$limit&page=$page&value_id[]=$id&search=$search'),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    debugPrint('authorProduct: ${response.body}');
    if (response.statusCode == 200) {
      if (add==false) {
        _getController.clearAuthorDetailProductModelList();
        _getController.itemPage.value = 1;
        _getController.addAuthorDetailProductModelList(ProductModel.fromJson(jsonDecode(response.body)));
      }else{
        _getController.addAuthorDetailProductModelList(ProductModel.fromJson(jsonDecode(response.body)));
        _getController.addItemPage();
      }
    }
  }

  //basket
  //------------------------------------------------------------------------------------------------

  Future<void> getBasket() async {
    var response = await post(Uri.parse(_getCart),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
        'Authorization': 'Bearer ${GetStorage().read('token')}',
      },
    );
    debugPrint('token: ${GetStorage().read('token')}');
    debugPrint('basket: ${response.body}');
    if (response.statusCode == 200) {
      _getController.clearBasketModel();
      _getController.changeBasketModel(BasketModel.fromJson(jsonDecode(response.body)));
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

  Future<void> addToBasket(String count, String productId) async {
    var response = await post(Uri.parse(_addCart),
        headers: {
          'Accept-Language': Get.locale!.languageCode,
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
        body: {
          "count": count,
          "product": productId,
          "type": "active",
          "user": _getController.meModel.value.data?.result?.sId
        }
    );
    debugPrint('basket: ${response.body}');
    if (response.statusCode == 200) {
      getBasket();
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }
}
