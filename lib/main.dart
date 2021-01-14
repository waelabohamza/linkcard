import 'package:flutter/material.dart';
import 'package:linkcard/pages/auth/login.dart';

import 'package:linkcard/pages/cart/addtocart.dart';
import 'package:linkcard/pages/home/home.dart';
import 'package:linkcard/pages/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkcard/component/applocal.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


SharedPreferences sharedPrefs;
String userid;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  userid = sharedPrefs.getString("id");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) {
        return ChangeLocale();
      }),
      ChangeNotifierProvider(create: (BuildContext context) {
        return AddToCart();
      })
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF12234b),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userid == null ? Login() : Home(),
      // userid == null ? Login() : Home(),
      routes: routes,
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      locale: Locale("ar",
          ""), // changeLocale.lang, //if want change language insiede application
      localeResolutionCallback: (currentLang, supportLang) {
        if (currentLang != null) {
          for (Locale locale in supportLang) {
            if (locale.languageCode == currentLang.languageCode) {
              print(currentLang.languageCode);
              sharedPrefs.setString("lang", currentLang.languageCode);
              return currentLang;
            }
          }
        }
        return supportLang.first;
      },
    );
  }
}

class ChangeLocale with ChangeNotifier {}
