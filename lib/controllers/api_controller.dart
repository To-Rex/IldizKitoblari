import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:ildiz/models/login_model.dart';
import 'get_controller.dart';

class ApiController extends GetxController{
  final GetController _getController = Get.put(GetController());
  static const String _baseUrl = 'https://ildizkitoblari.uz';
  static const String _login = '$_baseUrl/api/v1/auth/login';

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
      _getController.changeLoginModel(LoginModel.fromJson(jsonDecode(response.body)));
      print(_getController.loginModel.value.data!.token);
      //save token getstorage
      GetStorage().write('token', _getController.loginModel.value.data!.token);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}