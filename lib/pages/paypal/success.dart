import 'package:flutter/material.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/const.dart';

class Success extends StatefulWidget {
  final approve;
  Success({Key key, this.approve}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  GlobalKey<ScaffoldState> appkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(appkey, "success", context),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: WillPopScope(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "تمت عملية الشراء بنجاح لرؤية الاكواد يرجى الدخول الى صفحة مشترياتي  ",
                textAlign: TextAlign.center,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("myorders");
              },
              color: maincolor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text("مشترياتي"),
            )
          ],
        ),
        onWillPop: (){
            Navigator.of(context).pushNamed("home") ; 
           return ; 
        }
      ),),
    );
  }
}
