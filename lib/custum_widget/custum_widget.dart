import 'package:flutter/material.dart';
import 'package:flutter_test_app/DB/dbhelper.dart';
import 'package:flutter_test_app/size_config.dart';

TextFormField buildTextFormField(
    {label,
    hint,
    ontap = null,
    keyboardType,
    errorText,
    icon,
    controller = null,
    onsaved,
    value,
    secure = false}) {
  return TextFormField(
    readOnly: ontap != null ? true : false,
    onTap: ontap,
    controller: controller,
    onSaved: onsaved,
    validator: (e) => e.toString().isEmpty
        ? secure
            ? 'Please enter your password !'
            : errorText
        : null,
    obscureText: secure,
    keyboardType: keyboardType,
    maxLength: keyboardType == TextInputType.phone ? 11 : null,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(14),
            horizontal: getProportionateScreenWidth(8)),
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        suffixIcon: Icon(icon)),
  );
}

Widget buildRaisedButton({pressed, text, color = Colors.blue}) {
  return Container(
      width: double.infinity,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: color,
          onPressed: pressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          )));
}

buildRaisedButtonForCart({pressed, text, color = Colors.blue, res}) {

  return Container(
      width: double.infinity,
      child: RaisedButton(
          color: color,
          onPressed: res != null ? null : pressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              res != null ? "Added before !!" : text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          )));
}

showDialogWidget(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()));
}
