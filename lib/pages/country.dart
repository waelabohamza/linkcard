import 'package:flutter/material.dart';
import 'package:linkcard/main.dart';
import 'package:linkcard/pages/subcategories/subcategories.dart';

class Country extends StatefulWidget {
  Country({Key key}) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
    

  SubCategories isss = new SubCategories() ; 
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختيار البلد'),
      ),
      body: Container(
          child: ListView(
        children: [
          listCountry("الولايات المتحدة الامريكية", "assets/country/usa.png",
              () {
            sharedPrefs.setString("country", "usa");
            userid = sharedPrefs.getString("id");
            if (userid == null) {
              Navigator.of(context).pushNamed("login");
            } else {
              Navigator.of(context).pushNamed("home");
            }
          }),
          listCountry("الامارات العربية المتحدة", "assets/country/uae.png", () {
            sharedPrefs.setString("country", "uae");
            userid = sharedPrefs.getString("id");
            if (userid == null) {
              Navigator.of(context).pushNamed("login");
            } else {
              Navigator.of(context).pushNamed("home");
            }
          }),
          listCountry("جمهورية العراق", "assets/country/ir.png", () {
            sharedPrefs.setString("country", "ir");
            userid = sharedPrefs.getString("id");
            if (userid == null) {
              Navigator.of(context).pushNamed("login");
            } else {
              Navigator.of(context).pushNamed("home");
            }
          }),
          listCountry("المملكة العربية السعودية", "assets/country/sa.png", () {
            sharedPrefs.setString("country", "sa");
            userid = sharedPrefs.getString("id");
            if (userid == null) {
              Navigator.of(context).pushNamed("login");
            } else {
              Navigator.of(context).pushNamed("home");
            }
          }),
        ],
      )),
    );
  }

  listCountry(String name, String imageurl, function()) {
    return InkWell(
      onTap: function,
      child: Container(
        child: Row(
          children: [
            Container(width: 100, height: 100, child: Image.asset(imageurl)),
            Text("$name")
          ],
        ),
      ),
    );
  }
}
