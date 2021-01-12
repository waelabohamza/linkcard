import 'package:flutter/material.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/valid.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/main.dart';

// import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  Crud crud = new Crud();
  signUp() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {
        "email": email.text,
        "password": password.text,
        "username": username.text
      };
      showLoading(context);
      var responsebody = await crud.writeData(linkSignup, data);
      if (responsebody['status'] == "success") {
        sharedPrefs.setString("password", responsebody['password']);
        Navigator.of(context).pop();

        showAlertOneChoose(context, "success", "مبروك", "تم انشاء الحساب بنجاح يمكنك الان تسجيل الدخول");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed("login");
        });
      } else {
        Navigator.of(context).pop();
        showAlertOneChoose(context, "error", "خطأ",
            "البريد الالكتروني موجود سابقا");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  buildTopHeader(),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child:
                          Text("يمكنك تسجيل الدخول اذا كان لديك حساب سابقا")),
                  buildTextFaild("ادخل هنا اسم المستخدم", Icons.person,
                      username, "username"),
                  buildTextFaild("ادخل هنا البريد الالكتروني", Icons.email,
                      email, "email"),
                  buildTextFaild(
                      "ادخل هنا كلمة المرور", Icons.lock, password, "password"),
                  buildTextFaild("اعد كتابة كلمة المرور", Icons.lock,
                      confirmpassword, "confirm"),
                  buildButtonLogin(mdw, Colors.orange, "انشاء الحساب", signUp),
                  buildButtonLogin(mdw, Colors.grey, "صفحة تسجيل الدخول ", () {
                    Navigator.of(context).pushNamed("login");
                  }),
                  buildButtonLogin(mdw, maincolor, "الدخول من دون تسجيل", () {
                    Navigator.of(context).pushReplacementNamed("home");
                  }),
                ],
              ),
            )

            // buildButtonLogin(
            //     mdw, Colors.red, "تسجيل الدخول مع Google", (){}),
          ],
        ),
      ),
    );
  }

  buildTopHeader() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  "AlMutajar AlArabi",
                  style: TextStyle(
                      color: maincolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Be Smart,Conveient",
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/logo.png",
            width: 90,
            height: 90,
          ),
        ],
      ),
    );
  }

  buildTextFaild(
      String hinttext, IconData icon, TextEditingController mycontrole, type) {
    return Container(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          controller: mycontrole,
          validator: (val) {
            if (type == "username") {
              return validInput(val, 2, 30, "يكون اسم المستخدم");
            }
            if (type == "email") {
              return validInput(val, 2, 50, "يكون اسم المستخدم" , "email");
            } else if (type == "password") {
              return validInput(val, 3, 100, "تكون كلمة المرور");
            }
            if (type == "confirm") {
              if (password.text != confirmpassword.text) {
                return "كلمة المرور غير متطابقة";
              }
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: hinttext,
              prefixIcon: Icon(icon),
              contentPadding: EdgeInsets.all(4),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ));
  }

  buildButtonLogin(double mdw, color, String textbutton, function()) {
    return Container(
        width: mdw / 1.3,
        child: RaisedButton(
            textColor: Colors.white,
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: function,
            child: Text("$textbutton")));
  }
}
