import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Themes extends ChangeNotifier {
  ThemeData _themeData;

  Themes(this._themeData);

  getTheme() => _themeData;
  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
