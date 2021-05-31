import 'dart:io';

import 'package:flutter/material.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/exitapp.dart';
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
  List horzintalList = [
    {"image": "assets/sale.png" ,  "type" : "sale"},
    {"image": "assets/social2.png" , "type" : "social"},
    {"image": "assets/sale.png"},
  ];

  GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();
  Crud crud = new Crud();
  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
        drawerScrimColor: Colors.transparent,
        key: appbarkey,
        // appBar: myAppBar(appbarkey, "home", context),
        drawer: MyDrawer(),
        body: WillPopScope(
            child: Container(
                color: Colors.grey[900],
                // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    SizedBox(height: 20),
                    Container(
                        height: 150,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.separated(
                            separatorBuilder: (context, i) {
                              return SizedBox(width: 10);
                            },
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: horzintalList.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 130,
                                  color: Colors.black,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    "${horzintalList[i]['image']}",
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            })),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
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
            onWillPop: () {
              onWillPop(context);
              return;
            }));
  }
}
