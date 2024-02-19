import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:ildiz/models/login_model.dart';
import '../pages/sample_page.dart';
import 'get_controller.dart';

class ApiController extends GetxController {
  final GetController _getController = Get.put(GetController());
  static const String _baseUrl = 'https://ildizkitoblari.uz';
  static const String _login = '$_baseUrl/api/v1/auth/login';
  static const String _check = '$_baseUrl/api/v1/user/check';

  //https://ildizkitoblari.uz/api/v1/otp
  static const String _otp = '$_baseUrl/api/v1/otp';

  //https://ildizkitoblari.uz/api/v1/user/create
  static const String _create = '$_baseUrl/api/v1/user/create';

  Future<void> login(String phone, String password) async {
    print('phone: $phone, password: $password');
    //return await post(Uri.parse(_login), body: {'phone': phone, 'password': password});
    var response = await post(Uri.parse(_login), body: {
      'phone': phone,
      'password': password,
      'remember': 'false',
    });
    print(response.body);
    if (response.statusCode == 200) {
      _getController
          .changeLoginModel(LoginModel.fromJson(jsonDecode(response.body)));
      print(_getController.loginModel.value.data!.token);
      //save token getstorage
      GetStorage().write('token', _getController.loginModel.value.data!.token);
      if (GetStorage().read('token') != null) {
        Get.offAll(SamplePage());
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> check(phone) async {
    print('phone: $phone');
    var response = await post(Uri.parse(_check), body: {
      'phone': phone,
      'type': '1',
    });
    if (response.statusCode == 200) {
      print('check: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> otp(phone, type) async {
    print('phone: $phone');
    var response = await post(Uri.parse(_otp), body: {
      'phone': phone,
      'type': type,
    });
    if (response.statusCode == 200) {
      print('otp: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> create(String fullName, String otp, String password, String phone) async {
    print('fullName: $fullName, otp: $otp, password: $password, phone: $phone');
    var response = await post(Uri.parse(_create), body: {
      'full_name': fullName,
      'otp': otp,
      'password': password,
      'phone': phone,
    });
    if (response.statusCode == 200) {
      print('create: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  }


}
