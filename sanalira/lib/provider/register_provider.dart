import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  bool checkbox = false;

  changeCheckbox() {
    checkbox = !checkbox;
    notifyListeners();
  }
}
