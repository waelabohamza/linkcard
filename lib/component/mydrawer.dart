import 'package:flutter/material.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/main.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(

      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        color: Colors.grey[50],
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)]
              ),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "AlMutajar AlArabi",
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
                      width: 80,
                      height: 80,
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
                    buildCustomListile(
                        "مشترياتي", Icons.shopping_basket, () {
                          Navigator.of(context).pushNamed("myorders") ; 
                        }),
                    Divider(
                      color: Colors.grey,
                    ),
                    buildCustomListile(
                        "حول التطبيق", Icons.info_sharp, () {}),
                    Divider(
                      color: Colors.grey,
                    ),
                    buildCustomListile("الشروط والاحكام", Icons.article_rounded, () {}),
                    Divider(
                      color: Colors.grey,
                    ),

                    // Divider(
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
              Spacer(),
              sharedPrefs.getString("id") != null
                  ? buildCustomListile("تسجيل الخروج", Icons.exit_to_app, () {
                      sharedPrefs.clear();
                      Navigator.of(context).pushReplacementNamed("login");
                    })
                  :Container(
                    padding: EdgeInsets.symmetric(horizontal: 10  ,vertical: 10),
                    child: buildCustomListile("تسجيل الدخول", Icons.login, () {
                      Navigator.of(context).pushReplacementNamed("login");
                    })),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: maincolor, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "contact by online chat",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/social/facebook.png",
                      width: 35,
                      height: 35,
                    ),
                    Image.asset(
                      "assets/social/instagram.png",
                      width: 35,
                      height: 35,
                    ),
                    Image.asset(
                      "assets/social/twitter.png",
                      width: 35,
                      height: 35,
                    ),
                    Image.asset(
                      "assets/social/telegram.png",
                      width: 35,
                      height: 35,
                    ),
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
