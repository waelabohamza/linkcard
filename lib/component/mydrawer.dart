import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/main.dart';
import 'package:linkcard/pages/cart/addtocart.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        color: Colors.grey[50],
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300], blurRadius: 2.0, spreadRadius: 1.1)
              ]),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "المتجر العربي",
                            style: TextStyle(
                                color: maincolor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Be Smart,Conveient",
                            style: TextStyle(color: Color(0xFFb71f5a)),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/logo.png",
                      width: 70,
                      height: 70,
                    ),
                  ],
                ),
              ),
              sharedPrefs.getString("id") != null
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: maincolor,
                              radius: 30,
                              child: Text(
                                "${sharedPrefs.getString('username')[0]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              )),
                          Container(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              child:
                                  Text("${sharedPrefs.getString('username')}"))
                        ],
                      ),
                    )
                  : SizedBox(),
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    buildCustomListile("الرئيسية", Icons.home, () {
                      Navigator.of(context).pushNamed("home");
                    }),
                    Divider(
                      color: Colors.grey,
                    ),
                    buildCustomListile("مشترياتي", Icons.shopping_basket, () {
                      Navigator.of(context).pushNamed("myorders");
                    }),
                    Divider(
                      color: Colors.grey,
                    ),
                    buildCustomListile("تغيير البلد", Icons.flag, () {
                      var addtocart =
                          Provider.of<AddToCart>(context, listen: false);
                      addtocart.removeAll();
                      Navigator.of(context).pushNamed("country");
                    }),
                    Divider(
                      color: Colors.grey,
                    ),
                    buildCustomListile("حول التطبيق", Icons.info_sharp, () {
                      Navigator.of(context).pushNamed("about");
                    }),

                    Divider(
                      color: Colors.grey,
                    ),
                    buildCustomListile("الشروط والاحكام", Icons.article_rounded,
                        () {
                      Navigator.of(context).pushNamed("licence");
                    }),
                    Divider(
                      color: Colors.grey,
                    ),
                    sharedPrefs.getString("id") != null
                        ? buildCustomListile("تسجيل الخروج", Icons.exit_to_app,
                            () {
                            sharedPrefs.clear();
                            Navigator.of(context).pushReplacementNamed("login");
                          })
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: buildCustomListile(
                                "تسجيل الدخول", Icons.login, () {
                              Navigator.of(context)
                                  .pushReplacementNamed("login");
                            })),

                    // Divider(
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  String text = "اهلا بكم انا زبون من تطبيق المتجر العربي";
                  String url =
                      'https://api.whatsapp.com/send/?phone=$phonewhatsapp&text=$text&app_absent=0';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 2, left: 15, right: 15),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "contact by ",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebookSquare,
                          color: maincolor,
                          size: 50,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagramSquare,
                          color: maincolor,
                          size: 50,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.twitterSquare,
                          color: maincolor,
                          size: 50,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.telegramPlane,
                          color: maincolor,
                          size: 50,
                        ),
                        onPressed: () {})
                    // Image.asset(
                    //   "assets/social/facebook.png",
                    //   width: 35,
                    //   height: 35,
                    // ),
                    // Image.asset(
                    //   "assets/social/instagram.png",
                    //   width: 35,
                    //   height: 35,
                    // ),
                    // Image.asset(
                    //   "assets/social/twitter.png",
                    //   width: 35,
                    //   height: 35,
                    // ),
                    // Image.asset(
                    //   "assets/social/telegram.png",
                    //   width: 35,
                    //   height: 35,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildCustomListile(String title, IconData icons, function()) {
    return InkWell(
      onTap: function,
      child: Container(
          child: Row(children: [
        Icon(
          icons,
          size: 40,
          color: maincolor,
        ),
        Text(
          "  $title  ",
          style: TextStyle(color: maincolor),
        )
      ])),
    );
  }
}
