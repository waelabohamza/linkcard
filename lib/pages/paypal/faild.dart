import 'package:flutter/material.dart';

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
        child: Center(
          child: Container(
            child: Text(
                "تم الفشل حاول مجددا يمكنك التواصل مع الدعم الفني في جال حدوث خطأ ما "),
          ),
        ),
        onWillPop: () {
          Navigator.of(context).pushNamed("home");
          return;
        },
      ),
    );
  }
}
