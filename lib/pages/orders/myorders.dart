import 'package:flutter/material.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/main.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();

  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appbarkey,
      appBar: myAppBar(appbarkey, "myorders", context),
      drawer: MyDrawer(),
      body: WillPopScope(child: Container(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Text(
              "مشترياتي",
              style: Theme.of(context).textTheme.headline6,
            ),
           FutureBuilder(
             future: crud.readDataWhere(linkMyorders, sharedPrefs.getString("id")),
             builder: (BuildContext context, AsyncSnapshot snapshot) {
                 if (snapshot.hasData){
                       if(snapshot.data[0] == "falid"){
                             return Center(child: Text("لا يوجد اي طلبات")) ;
                       }
                       return ListView.builder(
                         itemCount: snapshot.data.length,
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemBuilder: (context , i){
                              return ListOrders(
                                catname: snapshot.data[i]['categories_name'],
                                items: snapshot.data[i]['items_name'],
                                subcat: snapshot.data[i]['subcategories_name'],
                                code: snapshot.data[i]['codes_name'],
                                ); 
                       }) ; 
                      
                 }
                 return Center(child: CircularProgressIndicator()) ; 
             },
           ),
          ])), onWillPop: ()
          {
            Navigator.of(context).pushNamed("home")  ;
            return ; 
          }),
    );
  }
}


class ListOrders extends StatelessWidget {

  final catname ; 
  final subcat ; 
  final username ; 
  final code ; 
  final items ; 
  const ListOrders({Key key , this.catname , this.code , this.items , this.subcat , this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("القسم : ", style: TextStyle(fontWeight: FontWeight.bold , color: maincolor)),
                            Text(catname),
                            
                          ]),
                    ),
                          Container(
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Text("القسم الفرعي : ", style: TextStyle(fontWeight: FontWeight.bold , color: maincolor)),
                            Text(subcat)
                          ]),
                    ),
                    Container(
                        width: double.infinity, child: Row(children: [
                          Text("اسم المنتج : ", style: TextStyle(fontWeight: FontWeight.bold , color: maincolor)) ,
                          Text(items) 
                        ],) ),
                    Container(
                      width: double.infinity,
                      child:Row(children: [
                         Text("الكود : " , style: TextStyle(fontWeight: FontWeight.bold , color: maincolor)) , 
                         Text(code) 
                      ],),
                    )
                  ],
                )) ; 
  }
}
