import 'dart:core';
import 'package:flutter/material.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/main.dart';
import 'package:linkcard/pages/paypal/success.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaypalServices.dart';

class PaypalPayment extends StatefulWidget {
  final totalprice;
  final Function onFinish;

  // For Orders

  final count;
  final listitems;
  final quantity;

  PaypalPayment(
      {this.onFinish,
      this.totalprice,
      this.count,
      this.listitems,
      this.quantity});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  // ============================
  String totalAmount;
  String returnSuccess;
  Crud crud = new Crud();
  //  ==============================

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();
    totalAmount = widget.totalprice.toString();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'المتجر العربي';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    // items هي مجرد تفاصيل ليس له قيمة  ادخل المعلومات يلي بدك ياها
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": totalAmount,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) async {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                await services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  returnSuccess = id;
                  widget.onFinish(id);

                  Navigator.of(context).pop();
                });
                var data = {
                  "price": widget.totalprice,
                  "quantity": widget.quantity,
                  "items": widget.listitems,
                  "count": widget.count,
                  "email": sharedPrefs.getString("email"),
                  "id": sharedPrefs.getString("id"),
                  "username": sharedPrefs.getString("username"),
                  "date": DateTime.now().toString()
                };
                if (returnSuccess == "approved") await crud.addOrders(data);
              } else {
                Navigator.of(context).pop();
              }
              if (returnSuccess == "approved") {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Success(approve: returnSuccess);
                }));
              } else {
                
              }
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
