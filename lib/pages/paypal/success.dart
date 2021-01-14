import 'package:flutter/material.dart';



class Success extends StatefulWidget {
  final approve ; 
  Success({Key key , this.approve}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('هام'),
      ),
      body: Container(child:Text("${widget.approve}"),),
    );
  }
}