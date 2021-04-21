import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/screans/home.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScrean extends StatefulWidget {
  @override
  _SplashScreanState createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean> {
  
  SharedPreferences prfs;
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) async {
      timer.cancel();
      Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScrean()));
    });
  }

  /* getData() async {
   
    prfs = await SharedPreferences.getInstance();

    if (prfs.getString('user') != null) {
      dynamic user = await getUserFromPrfs();
      if (user != null) {
       
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScrean()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginScrean()));
      }
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScrean()));
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/images/splash.PNG"),
            ),
            SizedBox(height: 70),
            Text(
              'Splash Test Task',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
