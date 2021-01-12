import 'package:flutter/material.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/appbar.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/mydrawer.dart';
import 'package:linkcard/component/valid.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/main.dart';
import 'package:linkcard/pages/cart/addtocart.dart';
import 'package:linkcard/pages/payment/payment_card.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  final price;
  final count;
  final listitems;
  final quantity;
  CheckOut({Key key, this.count, this.listitems, this.price, this.quantity})
      : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  GlobalKey<ScaffoldState> scaffodkey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Crud crud = new Crud();

  TextEditingController caccountnumber = new TextEditingController();
  TextEditingController cexpirymonth = new TextEditingController();
  TextEditingController cexpiryyear = new TextEditingController();
  TextEditingController ccvv = new TextEditingController();

  checkOut(mynumber, mycvv, myexpiryMonth, myexpiryYear) async {
    var id = sharedPrefs.getString("id");

    if (id == null) {
      return showAlertOneChoose(context, "error", "خطأ", "يرجى تسجيل الدخول");
    }

    var formdata = formstate.currentState;
    if (formdata.validate()) {
      showLoading(context);
      PaymentCard card = new PaymentCard(
          // بطاقة الزيون
          number: mynumber,
          cvv: mycvv,
          expiryMonth: myexpiryMonth,
          expiryYear: myexpiryYear);
      CheckoutPayment payment = new CheckoutPayment();
      bool res = await payment.makePayment(card, widget.price); // price in cent
      if (res == false) {
        // Orders Faild
        Navigator.of(context).pop();
        showAlertOneChoose(
            context, "error", "حطأ", "البطاقة غير صالحة او هناك خطأ بالادخال");
        print("no");
        return false;
      } else {
        // Orders Success
        print("yes");
        var data = {
          "price": widget.price,
          "quantity": widget.quantity,
          "items": widget.listitems,
          "count": widget.count,
          "email": sharedPrefs.getString("email"),
          "id": sharedPrefs.getString("id"),
          "username": sharedPrefs.getString("username"),
          "date": DateTime.now().toString()
        };
        await crud.addOrders(data);

        Navigator.of(context).pop();

        var prov = Provider.of<AddToCart>(context , listen: false );

        prov.removeAll();
        showAlertOneChoose(context, "success", "مبروك", "تمت العملية بنجاح");
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pushReplacementNamed("myorders");
        });

        return true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    caccountnumber.text = "4242424242424242";

    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffodkey,
      appBar: myAppBar(scaffodkey, "checkout", context),
      drawer: MyDrawer(),
      body: Container(
          child: ListView(
        children: [
          Image.asset("assets/payment.png"),
          Form(
              key: formstate,
              child: Column(
                children: [
                  buildFormCheckOut(
                      caccountnumber, "ادخل رقم البطاقة", "accountnumber"),
                  buildFormCheckOut(ccvv, "ادخل cvv", "cvv"),
                  Row(
                    children: [
                      Expanded(
                        child: buildFormCheckOut(
                            cexpirymonth, "ادخل expiry month", "month"),
                      ),
                      Expanded(
                        child: buildFormCheckOut(
                            cexpiryyear, "ادخل expiry year", "year"),
                      ),
                    ],
                  ),
                  Container(
                    width: mdw / 1.07,
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      color: maincolor,
                      textColor: Colors.white,
                      onPressed: () async {
                        checkOut(caccountnumber.text, ccvv.text,
                            cexpirymonth.text, cexpiryyear.text);
                      },
                      child: Text("ادفع الان ", style: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }

  buildFormCheckOut(TextEditingController mycontol, String hint, String type) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: mycontol,
        validator: (val) {
          if (type == "accountnumber") {
            return validInput(val, 15, 17, "يكون رقم البطاقة", "number");
          }
          if (type == "cvv") {
            return validInput(val, 3, 5, " cvv يكون", "number");
          }
          if (type == "month") {
            return validInput(
                val, 1, 3, "يكون رقم الشهر بهذا الشكل من 1 الى 12", "number");
          }
          if (type == "year") {
            return validInput(
                val, 3, 5, " يجب ان تكون السنة بهذا الشكل مثال 2022", "number");
          }
          return null;
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            hintText: "$hint",
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }
}
