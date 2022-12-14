import 'package:flutter/material.dart';
import 'package:sanalira/config/theme.dart';

import 'palette.dart';

class Helper {

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value.isEmpty) {
      return 'Lütfen şifrenizi girin';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Büyük, küçük harf, sayı ve özel karakter kullanın. Min 6 karakter!';
      } else {
        return null;
      }
    }
  }



  void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    content: SizedBox(
      height : 70,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.close, color: Colors.white, size: 20),
          SizedBox(
            width: 16,
          ),
          Text(
            message,
            style: CustomTheme.subtitle(context, color: Palette.thirdTextColor),
          ),
        ],
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
  ));
}
}