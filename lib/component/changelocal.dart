import 'package:flutter/material.dart';
import 'package:linkcard/main.dart';

class ChangeLocal with ChangeNotifier {
  Locale lang  =  sharedPrefs.getString("lang") == "ar" ? Locale("ar" , "")  : Locale("en" , "")  ;
  changeLocal(Locale newlang) {
    if (newlang == Locale("ar", "")) {
      sharedPrefs.setString("lang", "ar");
    } else {
      sharedPrefs.setString("lang", "en");
    }
      lang = newlang;
      notifyListeners() ; 
  }
}
