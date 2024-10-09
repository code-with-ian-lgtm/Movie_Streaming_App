import 'package:flutter/material.dart';
import 'package:movie_app/themes/dark_mode.dart';
import 'package:movie_app/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier{
  //set initial theme
  ThemeData _themeData = lightMode;

  ThemeProvider(){
    setInitialTheme();
  }

  //getter theme
  ThemeData get themeData => _themeData;

  // getter darkmode
  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  //method to toggle theme
  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    } else{
      themeData = lightMode;
    }
  }

  //method to set initial theme

  void setInitialTheme(){
    final brightness = WidgetsBinding.instance.window.platformBrightness;

    if(brightness == Brightness.light){
      _themeData = lightMode;
    } else {
      _themeData = darkMode;
    }
  }
}