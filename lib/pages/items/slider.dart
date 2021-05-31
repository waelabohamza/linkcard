import 'package:flutter/material.dart';
import 'package:linkcard/component/cacheimagenetwork.dart'; 
import 'package:linkcard/linkapi.dart';

SizedBox buildCarousalItems(context, image) {
  return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: cacheImege(context, "$linkupload/items/$image", 250.0));
}
