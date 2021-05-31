import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/pages/categories/categories.dart';

import '../../const.dart';

buildCategories(categories, int index, context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Categories(
          catid: categories['categories_id'],
        );
      }));
    },
    child: Container(
      decoration: BoxDecoration(
          color:  Colors.black,
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(left: index.isEven ? 10 : 0  , top: 10 ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: "$linkupload/categories/${categories['categories_image']}",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
