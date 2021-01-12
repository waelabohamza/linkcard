import 'package:flutter/material.dart';
import 'package:linkcard/pages/auth/login.dart';
import 'package:linkcard/pages/cart/basket.dart';
import 'package:linkcard/pages/home/home.dart';
import 'package:linkcard/pages/orders/myorders.dart';
import './auth/signup.dart';

Map<String, Widget Function(BuildContext)> routes = {
   "home" : (context) => Home()  , 
   "signup" : (context) => SignUp()  , 
   "login" : (context) => Login() , 
   "basket" : (context) => Basket() , 
   "myorders" : (context) => MyOrders()
};
