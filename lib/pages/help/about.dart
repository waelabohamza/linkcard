import 'package:flutter/material.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/linkapi.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();
    Crud crud = new Crud();

    return Scaffold(
      key: appbarkey,
      appBar: myAppBar(appbarkey, "About", context),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: crud.readData(linkHelp),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Text("${snapshot.data['help_about']}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
