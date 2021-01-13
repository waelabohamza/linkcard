import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/pages/cart/addtocart.dart';
import 'package:linkcard/pages/items/slider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Items extends StatefulWidget {
  final items;
  Items({Key key, this.items}) : super(key: key);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();

  Crud crud = new Crud();

  String  textwhatsapp  ; 

  int countcode = 0;
  bool loading = true;
  geCountCodes() async {
    var responbebody =
        await crud.readDataWhere(linkCountcodes, widget.items['items_id']);
    countcode = int.parse(responbebody['count'].toString());
    print(countcode);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    geCountCodes();
    textwhatsapp =  " السلام عليكم اريد التواصل لشراء حساب  " +  widget.items['items_name'] ; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      key: appbarkey,
      appBar: myAppBar(appbarkey, "items", context),
      drawer: MyDrawer(),
      bottomNavigationBar: Container(
          height: 60,
          child: Row(
            children: [
              Consumer<AddToCart>(builder: (context, addtocart, child) {
                return Expanded(
                  child: RaisedButton.icon(
                      color: maincolor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (addtocart.quantity[widget.items['items_id']] ==
                            null) {
                          addtocart.changequantity(widget.items['items_id'], 0);
                        }
                        if (int.parse(addtocart
                                .quantity[widget.items['items_id']]
                                .toString()) >=
                            countcode) {
                          print(addtocart.quantity[widget.items['items_id']]);
                          showAlertOneChoose(context, "warning", "هام",
                              "لا يوجد اكود متوفرة للبيع");
                        } else {
                          addtocart.addItems(widget.items);
                        }
                      },
                      icon: Icon(Icons.shopping_basket),
                      label: Container(
                          padding: EdgeInsets.all(10),
                          child: Text("اضافة للسلة"))),
                );
              }),
              VerticalDivider(
                color: Colors.white,
                width: 1,
              ),
              Expanded(
                child: RaisedButton.icon(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      String url = 'https://api.whatsapp.com/send/?phone=96569001503&text=${textwhatsapp}&app_absent=0';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: FaIcon(FontAwesomeIcons.whatsapp),
                    label: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [Text("طرق اخرى")],
                        ))),
              )
            ],
          )),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(children: [
                buildCarousalItems(widget.items['items_imagetwo']),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                          child: Text(
                        "name",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      )),
                      Spacer(),
                      Container(
                          child: Text("price",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.orange)))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                          child: Text("${widget.items['items_name']}",
                              style: Theme.of(context).textTheme.headline6)),
                      Spacer(),
                      Container(
                          child: Text(
                        "${widget.items['items_price']} د.ام",
                        style: Theme.of(context).textTheme.headline6,
                      ))
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("${widget.items['items_desc']}")),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 30),
                  child:
                      Consumer<AddToCart>(builder: (context, addtocart, child) {
                    return Row(
                      children: [
                        Text(
                          "الكمية",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (addtocart
                                        .quantity[widget.items['items_id']] ==
                                    null) {
                                  addtocart.changequantity(
                                      widget.items['items_id'], 0);
                                }
                                if (int.parse(addtocart
                                        .quantity[widget.items['items_id']]
                                        .toString()) >=
                                    countcode) {
                                  print(addtocart
                                      .quantity[widget.items['items_id']]);
                                  showAlertOneChoose(context, "warning", "هام",
                                      "لا يوجد اكود متوفرة للبيع");
                                } else {
                                  addtocart.addItems(widget.items);
                                }
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            "${addtocart.quantity[widget.items['items_id']] ?? 0}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                addtocart.removeItems(widget.items);
                              },
                            ))
                      ],
                    );
                  }),
                ),
                CircularPercentIndicator(
                  animation: true,
                  radius: 130.0,
                  lineWidth: 9.0,
                  percent: countcode / 100,
                  animationDuration: 1000,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Text(
                        "الكمية المتوفرة",
                        style: TextStyle(fontSize: 13),
                      ),
                      new Text("$countcode"),
                    ],
                  ),
                  progressColor: maincolor,
                )
              ])),
    );
  }
}
