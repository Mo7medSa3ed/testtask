import 'dart:convert';

import 'package:flutter_test_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUser(user, context) async {
  final prfs = await SharedPreferences.getInstance();

  prfs.setString('user', user);
  final parsed = json.decode(user);
  User u = User.fromJson(parsed);
}

saveToken(token) async {
  final prfs = await SharedPreferences.getInstance();
  prfs.setString('token', token);
}

clear() async {
  final prfs = await SharedPreferences.getInstance();
  prfs.clear();
}

getToken() async {
  final prfs = await SharedPreferences.getInstance();
  return prfs.get('token');
}

Future<dynamic> getUserFromPrfs() async {
  SharedPreferences prfs = await SharedPreferences.getInstance();
  final parsed = prfs.getString("user");
  return parsed;
}
