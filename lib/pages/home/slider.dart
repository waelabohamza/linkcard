import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:linkcard/const.dart';

SizedBox buildCarousal() {
  return SizedBox(
      height: 420.0,
      width: 350.0,
      child: Carousel(
        images: [
          // NetworkImage(
          //     'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
          NetworkImage('http://$serverName/upload/slider/1.jpg'),
          // ExactAssetImage("assets/images/LaunchImage.jpg")
        ],
        boxFit: BoxFit.fill,
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.lightGreenAccent,
        indicatorBgPadding: 5.0,
        // dotBgColor: Colors.purple.withOpacity(0.5),
        borderRadius: false,
        moveIndicatorFromBottom: 180.0,
        noRadiusForIndicator: true,
        overlayShadow: false ,
        overlayShadowColors: Colors.white,
        overlayShadowSize: 0.0,
        showIndicator: false ,
      ));
}


// statusbar color 
// Drawer Elevation 
// Slider overlay 
 
