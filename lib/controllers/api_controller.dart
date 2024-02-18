import 'package:http/http.dart';

class ApiController{
  static const String _baseUrl = 'https://ildizkitoblari.uz';
  static const String _login = '$_baseUrl/api/v1/auth/login';
  static Future<Response> login(String phone, String password) async {
    print('phone: $phone, password: $password');
    //return await post(Uri.parse(_login), body: {'phone': phone, 'password': password});
    var response = await post(Uri.parse(_login), body: {
      'phone': phone,
      'password': password,
      'remember': 'false',
    });
    print(response.body);

    return response;
  }
}