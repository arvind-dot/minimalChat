import 'package:flutter/material.dart';
import 'package:minimal_chat/themes/dark_mode.dart';
import 'package:minimal_chat/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  setThemeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    notifyListeners();
  }
  
}