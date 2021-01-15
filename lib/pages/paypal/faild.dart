import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkcard/const.dart';
import 'package:url_launcher/url_launcher.dart';

class Faild extends StatefulWidget {
  final approve;
  Faild({Key key, this.approve}) : super(key: key);

  @override
  _FaildState createState() => _FaildState();
}

class _FaildState extends State<Faild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('هام'),
      ),
      body: WillPopScope(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  "تم الفشل حاول مجددا يمكنك التواصل مع الدعم الفني في حال حدوث خطأ ما "),
            ),
            InkWell(
              onTap: () async {
                String text =
                    "السلام انا زبون واريد التواصل مع الدعم الفني من اجل مشكلة في الطلب";
                String url =
                    'https://api.whatsapp.com/send/?phone=96569001503&text=$text&app_absent=0';
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
                      "تواصل مع الدعم الفني ",
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
            )
          ],
        ),
        onWillPop: () {
          Navigator.of(context).pushNamed("home");
          return;
        },
      ),
    );
  }
}
