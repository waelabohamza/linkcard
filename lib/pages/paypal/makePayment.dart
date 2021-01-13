import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/main.dart';
import 'PaypalPayment.dart';

class MakePayment extends StatefulWidget {
  final price;
  final count;
  final listitems;
  final quantity;
  MakePayment({Key key, this.count, this.listitems, this.price, this.quantity});
  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  Crud crud = new Crud();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: myAppBar(scaffoldKey, "Pay", context),
          body: Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        // make PayPal payment
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (status) async {
                                // payment done
                                print('Status Orders: ' + status);
                                if (status == "APPROVED") {
                                  var data = {
                                    "price": widget.price,
                                    "quantity": widget.quantity,
                                    "items": widget.listitems,
                                    "count": widget.count,
                                    "email": sharedPrefs.getString("email"),
                                    "id": sharedPrefs.getString("id"),
                                    "username":sharedPrefs.getString("username"),
                                    "date": DateTime.now().toString()
                                  };
                                  await crud.addOrders(data);
                                  showAlertOneChoose(context, "success",
                                      "مبروك", "تمت عملية الشراء بنجاح");
                                } else {
                                  showAlertOneChoose(context, "error", "خطا",
                                      "لم تتم عملية الدفع بنجاح");
                                }
                              },
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'شراء الان',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
