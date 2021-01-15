import 'package:flutter/material.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/linkapi.dart';

class Licence extends StatefulWidget {
  Licence({Key key}) : super(key: key);

  @override
  _LicenceState createState() => _LicenceState();
}

class _LicenceState extends State<Licence> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();
    Crud crud = new Crud();

    return Scaffold(
      appBar: myAppBar(appbarkey, "licence", context),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: crud.readData(linkHelp),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Text("${snapshot.data['help_licence']}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
