import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/main.dart';

import 'package:linkcard/pages/items/items.dart';

class SubCategories extends StatefulWidget {
  final subcat;
  SubCategories({Key key, this.subcat}) : super(key: key);
  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
   
 
  Crud crud = new Crud();
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  
  buildCat(){
         
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: myAppBar(scaffoldkey, "subcategories", context),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: crud.readDataWhere(linkitems, widget.subcat),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0] == "falid") {
                return Center(child: Text("لا يوجد اي منتجات في هذا القسم"));
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return buildItemsList(snapshot.data[i], () {});
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  List gePriceItemsByCountry(items) {
    double price;
    List data = [];
    country = sharedPrefs.getString("country") ; 
    if (country == "usa") {
      price = double.parse(items['items_price'].toString());
      data.add(price);
      data.add("\$");
      return data;
    }
    if (country == "uae") {
      price = double.parse(items['items_price_em'].toString());
      data.add(price);
      data.add("د.ام");
      return data;
    }
    if (country == "ir") {
      price = double.parse(items['items_price_ir'].toString());
      data.add(price);
      data.add("د.ع");
      return data;
    }
    if (country == "sa") {
      price = double.parse(items['items_price_sa'].toString());
      data.add(price);
      data.add("ر.س");
      return data;
    }
    return data;
  }

  buildItemsList(items, function()) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Items(
            items: items,
          );
        }));
      },
      child: Container(
          height: 110,
          child: Card(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: CachedNetworkImage(
                        imageUrl: "$linkupload/items/${items['items_image']}",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text("${items['items_name']}"),
                      subtitle: Text("${items['items_point']} نقطة"),
                    )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(child: Text("السعر")),
                    int.parse(items['items_discount']) == 0
                        ? Text(
                            "${gePriceItemsByCountry(items)[0]} ${gePriceItemsByCountry(items)[1]}  ")
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${gePriceItemsByCountry(items)[0]} ${gePriceItemsByCountry(items)[1]}  ",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red),
                              ),
                              Text(
                                "${gePriceItemsByCountry(items)[0] - gePriceItemsByCountry(items)[0] * (int.parse(items['items_discount']) / 100)} ${gePriceItemsByCountry(items)[1]} ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          )
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
