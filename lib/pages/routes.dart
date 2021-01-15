import 'package:flutter/material.dart';
import 'package:linkcard/pages/auth/login.dart';
import 'package:linkcard/pages/cart/basket.dart';
import 'package:linkcard/pages/country.dart';
import 'package:linkcard/pages/help/about.dart';
import 'package:linkcard/pages/help/licence.dart';
import 'package:linkcard/pages/home/home.dart';
import 'package:linkcard/pages/offers/offers.dart';
import 'package:linkcard/pages/orders/myorders.dart';
import './auth/signup.dart';

Map<String, Widget Function(BuildContext)> routes = {
   "home" : (context) => Home()  , 
   "signup" : (context) => SignUp()  , 
   "login" : (context) => Login() , 
   "basket" : (context) => Basket() , 
   "myorders" : (context) => MyOrders() , 
   "offers" : (context) => Offers() , 
   "country" : (context) => Country()  , 
   "licence" : (context) => Licence()  , 
   "about" : (context) => About()
};
