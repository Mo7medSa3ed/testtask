import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:dio/dio.dart';
//import 'package:http/http.dart' as http;

class API {
  static String _BASEURL =
      'https://phpstack-466670-1463298.cloudwaysapps.com/public/api';

  static Future<Response<dynamic>> signUp(User user) async {
    FormData formData = new FormData.fromMap(user.toJson());
    final Response response =
        await new Dio().post('$_BASEURL/signup', data: formData);
    return response;
  }

  static Future<Response<dynamic>> login(User user) async {
    final Response response = await new Dio().post(
        '$_BASEURL/login?mobile=${user.mobile}&password=${user.password}');

    return response;
  }

  static Future<List<dynamic>> getAllProducts(
      {page = 1, norecord = 4, key_search} ) async {
        Dio dio =new Dio();
    FormData formData = new FormData.fromMap(
        {"page": page, "norecord": norecord, "key_search": key_search});
        print(formData.fields);
        dio.options.headers["authorization"] = "token ${getToken()}";
    final Response response =
        await dio.post('$_BASEURL/products_all', data: formData);
    return response.data['data']['products'];
  }
}
