import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:ildiz/models/login_model.dart';
import '../models/me_models.dart';
import '../models/menu_model.dart';
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
  static const String _menu = '$_baseUrl/api/v1/menu/list/?for_mobile=true';


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
        print(_getController.loginModel.value.data!.token);
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
      print('check: ${response.body}');
      if (jsonDecode(response.body)['status'] == true) {
        print(_getController.phoneController.text);
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
      print('otp: ${response.body}');
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
    print('fullName: $fullName, otp: $otp, password: $password, phone: $phone');
    var response = await post(Uri.parse(_create),
        body: {
          'full_name': fullName,
          'otp': otp.toString(),
          'password': password,
          'phone': phone,
        }
    );
    if (response.statusCode == 200|| response.statusCode == 201) {
      print('create: ${response.body}');
      if (jsonDecode(response.body)['status'] == true) {
        _getController.changeLoginModel(LoginModel.fromJson(jsonDecode(response.body)));
        _getController.changeMeModel(MeModel.fromJson(jsonDecode(response.body)));
        print(_getController.loginModel.value.data!.token);
        GetStorage().write('token', _getController.loginModel.value.data!.token);
        Get.offAll(SamplePage());
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
    var response = await get(Uri.parse(_me), headers: {
      'Authorization': 'Bearer ${GetStorage().read('token')}',
    });
    print('me: ${response.body}');
    if (response.statusCode == 200) {
      _getController.changeMeModel(MeModel.fromJson(jsonDecode(response.body)));
    } else if (response.statusCode == 401) {
      Get.offAll(const OnboardingPage());
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
      print('checkOtp: ${response.body}');
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
    print(response.body);
    if (response.statusCode == 200) {
      print('passwordUpdate: ${response.body}');
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
    //'Accept-Language': 'uz',
    var response = await get(Uri.parse(_menu),
      headers: {
        'Accept-Language': Get.locale!.languageCode,
      },
    );
    print('menu: ${response.body}');
    if (response.statusCode == 200) {
      _getController.changeMenuModel(MenuModel.fromJson(jsonDecode(response.body)));
    } else {
      showToast(Get.context, 'Xatolik', 'Server bilan bog\'lanishda xatolik', true, 3);
    }
  }

}
