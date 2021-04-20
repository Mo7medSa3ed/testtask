import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/api/API.dart';
import 'package:flutter_test_app/constants/constants.dart';
import 'package:flutter_test_app/custum_widget/custum_widget.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/screans/home.dart';
import 'package:flutter_test_app/screans/login.dart';
import 'package:flutter_test_app/size_config.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:toast/toast.dart';

class SignupScrean extends StatefulWidget {
  @override
  _SignupScreanState createState() => _SignupScreanState();
}

class _SignupScreanState extends State<SignupScrean> {
  String mobile;
  String arName;
  String enName;
  String dateofbirth;
  String password;
  final _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: signupBody(),
    );
  }

  signupBody() {
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
                            Text("Signup",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 28)),
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            ),
                            buildTextFormField(
                                errorText: "please enter your arabic name !",
                                hint: "Enter arabic name",
                                label: "Arabic Name",
                                icon: Icons.text_fields,
                                keyboardType: TextInputType.text,
                                onsaved: (String value) {
                                  if (value.isNotEmpty) {
                                    arName = value;
                                  }
                                }),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            buildTextFormField(
                                errorText: "please enter your english name !",
                                hint: "Enter english name",
                                label: "English Name",
                                icon: Icons.text_fields,
                                keyboardType: TextInputType.text,
                                onsaved: (String value) {
                                  if (value.isNotEmpty) {
                                    enName = value;
                                  }
                                }),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            buildTextFormField(
                                controller: _controller,
                                errorText:
                                    "please enter your higri birthdate !",
                                hint: "Enter higri birthdate",
                                label: "Higri Birthdate",
                                ontap: () {
                                  showHigridatePicker();
                                },
                                icon: Icons.date_range,
                                keyboardType: TextInputType.text,
                                onsaved: (String value) {
                                  if (value.isNotEmpty) {
                                    dateofbirth = value;
                                  }
                                }),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
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
                                text: "Signup",
                                pressed: () async => await signup()),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Do have account? \t'),
                                InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (_) => LoginScrean())),
                                    child: Text(
                                      'Login',
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

  showHigridatePicker() async {
    final picked = await showHijriDatePicker(
      context: context,
      initialDate: new HijriCalendar()
        ..hYear = 1380
        ..hMonth = 12
        ..hDay = 1,
      lastDate: new HijriCalendar.now(),
      firstDate: new HijriCalendar()
        ..hYear = 1380
        ..hMonth = 12
        ..hDay = 1,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null)
      setState(() {
        dateofbirth = picked.toString();
        _controller.text = dateofbirth;
      });
  }

  signup() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      showDialogWidget(context);
      User user = User(
          name_ar: arName,
          birthdate: dateofbirth,
          mobile: mobile,
          name_en: enName,
          password: password);
      final response = await API.signUp(user);
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Toast.show(response.data['message'], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        if (response.data['data'] != null) {
          saveUser(response.data['data'].toString(), context);
          saveToken(response.data['data']['api_token'].toString());
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => HomeScrean()));
        }
      } else {
        Toast.show(response.data['message'], context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }
}
