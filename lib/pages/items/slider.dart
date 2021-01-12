import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/linkapi.dart';

SizedBox buildCarousalItems(image) {
  return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: Carousel(
        images: [
          CachedNetworkImageProvider("$linkupload/items/$image") , 
          // CachedNetworkImageProvider("http://$serverName/upload/slider/1.jpg") , 
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
        overlayShadow: true,
        overlayShadowColors: Colors.white,
        overlayShadowSize: 0.0,
        showIndicator: false ,
      ));
}
