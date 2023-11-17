

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_love/theme/dark_theme.dart';
import 'package:lyrics_love/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = lightTheme;

  ThemeData get themeData=> _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData==lightTheme){
      _themeData = darkTheme;
    }
    else{
      _themeData = lightTheme;
    }
  }
}