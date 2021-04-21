import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/provider/themes.dart';
import 'package:flutter_test_app/screans/allproducts.dart';
import 'package:flutter_test_app/screans/cart.dart';
import 'package:flutter_test_app/screans/home.dart';
import 'package:flutter_test_app/screans/login.dart';
import 'package:flutter_test_app/screans/signup.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  var user;
  var themeProvider;
  var enableDarkTheme = false;

  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    user = jsonDecode(await getUserFromPrfs());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<Themes>(context, listen: true);
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
                margin: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)),
                  accountName: Text(
                    user == null ? '' : user['name_en'].toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                  accountEmail: Text(
                    user == null ? '' : user['mobile'].toString(),
                    style: TextStyle(fontSize: 12),
                  ),
                )),
            ListTile(
              title: Text("Home"),
              onTap: () => go(HomeScrean(), context),
            ),
            ListTile(
              title: Text("Login"),
              onTap: () => go(LoginScrean(), context),
            ),
            ListTile(
              title: Text("Signup"),
              onTap: () => go(SignupScrean(), context),
            ),
            ListTile(
              title: Text("Products"),
              onTap: () => go(AllProducts(), context),
            ),
            ListTile(
              title: Text("Cart"),
              onTap: () => go(CartScrean(), context),
            ),
            ListTile(
                title: Text("SignOut"),
                onTap: () async {
                  await clear();
                  go(LoginScrean(), context);
                }),
            ListTile(
              title: Text("Light/Dark Mode"),
              trailing: Switch(
                  activeColor: Theme.of(context).accentColor,
                  value: enableDarkTheme,
                  onChanged: (value) async {
                    setState(() {
                      enableDarkTheme = value;
                      if (!enableDarkTheme) {
                        themeProvider.setTheme(ThemeData.light());
                      } else {
                        themeProvider.setTheme(ThemeData.dark());
                      }
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

go(screan, context) {
  Navigator.of(context).pop();
  return Navigator.of(context).push(MaterialPageRoute(builder: (_) => screan));
}
