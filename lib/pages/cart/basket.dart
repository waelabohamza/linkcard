import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/main.dart';
import 'package:linkcard/pages/cart/addtocart.dart';
// import 'package:linkcard/pages/payment/checkout.dart';
import 'package:linkcard/pages/paypal/PaypalPayment.dart';
import 'package:provider/provider.dart';

class Basket extends StatefulWidget {
  Basket({Key key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  GlobalKey<ScaffoldState> appbarkey = new GlobalKey<ScaffoldState>();
  double discount = 0.0;
  double priceafterdiscount;
  TextEditingController coupon = new TextEditingController();

  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      key: appbarkey,
      appBar: myAppBar(appbarkey, "basket", context),
      drawer: MyDrawer(),
      bottomNavigationBar:
          Consumer<AddToCart>(builder: (context, addtocart, child) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildbuttonCoupon(),
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الاجمالي النهائي",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text("قيمة الخصم"),
                          Text(" الاجمالي  "),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${addtocart.afterdiscount}  ",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text("${addtocart.discount} %"),
                          Text("${addtocart.totalprice}  "),
                        ],
                      ),
                    ],
                  )),
              Container(
                child: MaterialButton(
                  minWidth: mdw / 1.060,
                  color: Colors.orange,
                  textColor: Colors.white,
                  onPressed: () {
                    addtocart.removeAll();
                  },
                  child: Text("افراغ السلة"),
                ),
              ),
              Container(
                child: MaterialButton(
                  minWidth: mdw / 1.060,
                  color: maincolor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (addtocart.count > 0) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PaypalPayment(
                          count: addtocart.count,
                          listitems: addtocart.bascket,
                          totalprice: addtocart.afterdiscount,
                          quantity: addtocart.quantity,
                          onFinish: (id) {
                            print("id : $id");
                          },
                        );
                      }));
                    } else {
                      showAlertOneChoose(
                          context, "warning", "تنبيه", "السلة فارغة");
                    }
                  },
                  child: Text("شراء الان"),
                ),
              )
            ],
          ),
        );
      }),
      body: Container(
          child: ListView(
        children: [
          Consumer<AddToCart>(builder: (context, addtocart, child) {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: addtocart.bascket.length,
              itemBuilder: (context, i) {
                return buildItemsList(addtocart.bascket[i], () {});
              },
            );
          }),
        ],
      )),
    );
  }

  buildItemsList(items, function()) {
    return InkWell(
      onTap: () {},
      child: Container(
          height: 170,
          child: Card(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: CachedNetworkImage(
                      imageUrl: "$linkupload/items/${items['items_image']}",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                    )),
                Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text("${items['items_name']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${items['items_point']} نقطة"),
                          Consumer<AddToCart>(
                              builder: (context, addtocart, child) {
                            return Text(
                                " الكميه :  ${addtocart.quantity[items['items_id']]}  ");
                          }),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Consumer<AddToCart>(
                                    builder: (context, addtocart, child) {
                                  return Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: InkWell(
                                            onTap: () async {
                                              if (addtocart.quantity[
                                                      items['items_id']] ==
                                                  null) {
                                                addtocart.changequantity(
                                                    items['items_id'], 0);
                                              }
                                              // ============================ Start Get Count

                                              var responbebody =
                                                  await crud.readDataWhere(
                                                      linkCountcodes,
                                                      items['items_id']);
                                              var countcode = int.parse(
                                                  responbebody['count']
                                                      .toString());

                                              //================================ End Get Count

                                              if (int.parse(addtocart.quantity[
                                                          items['items_id']]
                                                      .toString()) >=
                                                  countcode) {
                                                print(addtocart.quantity[
                                                    items['items_id']]);
                                                showAlertOneChoose(
                                                    context,
                                                    "warning",
                                                    "هام",
                                                    "لا يوجد اكود متوفرة للبيع");
                                              } else {
                                                addtocart.addItems(
                                                    items,
                                                    gePriceItemsByCountry(
                                                        items)[0]);
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: Text(
                                          "${addtocart.quantity[items['items_id']] ?? 0}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: InkWell(
                                            onTap: () {
                                              addtocart.removeItems(
                                                  items,
                                                  gePriceItemsByCountry(
                                                      items)[0]);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ))
                                    ],
                                  );
                                }),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(child: Text("price")),
                    int.parse(items['items_discount']) == 0
                        ? Text(
                            "${gePriceItemsByCountry(items)[0]} ${gePriceItemsByCountry(items)[1]}")
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${gePriceItemsByCountry(items)[0]} ${gePriceItemsByCountry(items)[1]}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red),
                              ),
                              Text(
                                "${gePriceItemsByCountry(items)[0] - gePriceItemsByCountry(items)[0] * (int.parse(items['items_discount']) / 100)}  ${gePriceItemsByCountry(items)[1]}",
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

  buildTextFaild(
      String hinttext, IconData icon, TextEditingController mycontrole, mdw) {
    return Container(
        width: mdw / 1.5,
        padding: EdgeInsets.all(10),
        child: TextFormField(
          controller: mycontrole,
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 16),
              hintText: hinttext,
              prefixIcon: Icon(icon),
              contentPadding: EdgeInsets.all(4),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ));
  }

  buildbuttonCoupon() {
    return Consumer<AddToCart>(builder: (context, addtocart, child) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          textColor: Colors.white,
          color: maincolor,
          onPressed: () {
            showDialogWithForm(
                context, "هام", "الرجاء ادخال كود الخصم في حال توفره", coupon,
                () async {
              showLoading(context);
              var responsebody = await crud.readDataWhere(
                  linkCheckcoupon, coupon.text ?? 0.toString());
              discount = double.parse(responsebody['coupon_discount']);
              Navigator.of(context).pop();

              if (discount != 0.0) {
                Navigator.of(context).pop();
                addtocart.applyDiscount(discount);
              } else {
                addtocart.applyDiscount(0.0);
                showAlertOneChoose(
                    context, "warning", "تنبيه", "كود الخصم غير موجود");
              }
            });
          },
          child: Text("الكوبون في حال توفره"),
        ),
      );
    });
  }

  List gePriceItemsByCountry(items) {
    double price;
    List data = [];
    country = sharedPrefs.getString("country");
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
}
