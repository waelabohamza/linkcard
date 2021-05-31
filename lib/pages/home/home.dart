import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/pages/home/buildcategories.dart';
import 'package:linkcard/pages/home/slider.dart';
import 'package:linkcard/linkapi.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool> onWillPop() {
    return showAlert(context, "error", "تنبيه", "هل تريد اغلاق التطيبق", () {},
            () {
          exit(0);
        }) ??
        false;
  }

  GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();
  Crud crud = new Crud();
  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
        drawerScrimColor: Colors.transparent,
        key: appbarkey,
        appBar: myAppBar(appbarkey, "home", context),
        drawer: MyDrawer(),
        body: WillPopScope(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: buildCarousal(context)),
                    // InkWell(
                    //   onTap: (){
                    //     Navigator.of(context).pushNamed("offers") ; 
                    //   },
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //           child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: Image.asset(
                    //           "assets/sale.gif",
                    //           width: mdw / 1.06,
                    //         ),
                    //       ))
                    //     ],
                    //   ),
                    // ),
                    Container(
                      child: FutureBuilder(
                        future: crud.readData(linkcategories),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return buildCategories(
                                      snapshot.data[index], index, context);
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 10),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //           child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: Image.asset(
                    //           "assets/a.jpg",
                    //           width: mdw / 1.06,
                    //         ),
                    //       ))
                    //     ],
                    //   ),
                    // ),
                  ],
                )),
            onWillPop: onWillPop));
  }
}
