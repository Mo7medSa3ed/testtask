import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/API.dart';
import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/screans/home.dart';
import 'package:flutter_test_app/screans/signup.dart';
import 'package:flutter_test_app/size_config.dart';
import 'package:flutter_test_app/custum_widget/custum_widget.dart';
import 'package:toast/toast.dart';

class LoginScrean extends StatefulWidget {
  @override
  _LoginScreanState createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  String mobile;
  String password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: loginBody(),
    );
  }

  loginBody() {
    return SafeArea(
        child: Center(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              child: Card(
                  elevation: 12,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 35),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text("Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 28)),
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            ),
                            buildTextFormField(
                                errorText: "please enter your mobile number !",
                                hint: "Enter mobile number",
                                label: "Mobile Number",
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                onsaved: (String value) {
                                  if (value.isNotEmpty) {
                                    mobile = value;
                                  }
                                }),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            buildTextFormField(
                                hint: "Enter password ",
                                label: "Password",
                                icon: Icons.lock,
                                keyboardType: TextInputType.visiblePassword,
                                onsaved: (String value) {
                                  if (value.isNotEmpty) {
                                    password = value;
                                  }
                                }),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            buildRaisedButton(
                                text: "Login",
                                pressed: () async => await login()),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have account? \t'),
                                InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (_) => SignupScrean())),
                                    child: Text(
                                      'Signup',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ))))
        ],
      ),
    )));
  }

  login() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      showDialogWidget(context);
      User user = User(mobile: mobile, password: password);
      final response = await API.login(user);
      Navigator.of(context).pop();
      FocusScope.of(context).requestFocus(FocusNode());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Toast.show(response.data['message'], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        if(response.data['data']!=null){
        saveUser(response.data['data'].toString(), context);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScrean()));
        }
      } else {
       
        Toast.show(response.data['message'].toString(), context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}
