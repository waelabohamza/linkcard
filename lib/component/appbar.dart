import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/main.dart';
import 'package:linkcard/pages/cart/addtocart.dart';
import 'package:provider/provider.dart';

Widget myAppBar(key, currentpage, context) {
  return AppBar(
      brightness: Brightness.light,
      toolbarHeight: 80.0,
      backgroundColor: Colors.grey[900],
      actions: [
        currentpage == "home"
            ? Container(
                margin: EdgeInsets.only(left: 10, top: 7, bottom: 7),
                child: Image.asset(
                  "assets/logo.png",
                  width: 50,
                  height: 50,
                ),
              )
            : SizedBox(),
        currentpage != "home"
            ? sharedPrefs.getString("country") == "ir"
                ? SizedBox()
                : Consumer<AddToCart>(builder: (context, addtocart, child) {
                    return Badge(
                      position: BadgePosition.topEnd(end: 30, top: 1),
                      badgeContent: Text(
                        '${addtocart.count}',
                        style: TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: maincolor,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed("basket");
                          }),
                    );
                  })
            : SizedBox(),
        currentpage == "home"
            ? SizedBox()
            : IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: maincolor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
      ],
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 40,
          color: maincolor,
        ),
        onPressed: () {
          key.currentState.openDrawer();
        },
      ));
}
/*
,
    Container(
        width: 25,
        height: 25,
          child: Image.asset(
        "assets/menu.png",
    
        width: 20,
        height: 10,
        fit: BoxFit.contain,
      ))
*/
