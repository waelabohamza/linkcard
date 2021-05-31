import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 

cacheImege(context , url, height , [width]) {
  return CachedNetworkImage(
  imageUrl: url, 
  fit: BoxFit.fill, 
  height: height , 
   width: width,
  placeholder: (context , s) => Container(child: CircularProgressIndicator()),
  );
}
