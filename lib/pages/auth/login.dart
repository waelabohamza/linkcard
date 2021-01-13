import 'package:flutter/material.dart';
import 'package:linkcard/component/alert.dart';
import 'package:linkcard/component/crud.dart';
import 'package:linkcard/component/valid.dart';
import 'package:linkcard/const.dart';
import 'package:linkcard/linkapi.dart';
import 'package:linkcard/main.dart';

// import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController forgetpassword = new TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  forgetPassword() async {
    Navigator.of(context).pop();
    showLoading(context);
    var checkemail = await crud.writeData(
        linkCheckemail, {"email": forgetpassword.text ?? 0.toString()});
    if (checkemail['status'] == "success") {
      var fpassword = checkemail['password'];
      await crud.readData(
          "$linkforgetpassword?email=${forgetpassword.text}&password=$fpassword");
      Navigator.of(context).pop();
      showAlertOneChoose(context, "success", "هام",
          "تم ارسال كلمة السر الى بريدك الرجاء مراجعة البريد الوارد وشكرا");
    } else {
      Navigator.of(context).pop();
      showAlertOneChoose(
          context, "success", "هام", "البريد الالكتروني غير موجود");
    }
  }

  Crud crud = new Crud();
  signIn() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      var data = {"email": email.text, "password": password.text};
      showLoading(context);
      var responsebody = await crud.writeData(linkSignin, data);
      if (responsebody['status'] == "success") {
        var user = responsebody['message'];
        sharedPrefs.setString("id", user['users_id']);
        sharedPrefs.setString("username", user['users_name']);
        sharedPrefs.setString("email", user['users_email']);
        sharedPrefs.setString("password", user['users_password']);
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        Navigator.of(context).pop();
        showAlertOneChoose(context, "error", "خطأ",
            "كلمة المرور او البريد الالكتروني غير صحيح");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Form(
          key: formstate,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTopHeader(),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text("يمكنك تسجيل الدخول اذا كان لديك حساب سابقا")),
                buildTextFaild(
                    "ادخل هنا البريد الالكتروني", Icons.email, email, "email"),
                buildTextFaild(
                    "ادخل هنا كلمة المرور", Icons.lock, password, "password"),
                InkWell(
                  onTap: () {
                    return showDialogWithForm(
                        context,
                        "هل نسيت كلمة المرور",
                        "ادخل البريد الالكتروني لارسال كلمة المرور اليك",
                        forgetpassword,
                        forgetPassword);
                    ;
                  },
                  child: Container(
                      child: Text(
                    " هل نسيت كلمة المرور ?",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
                ),
                buildButtonLogin(mdw, Colors.grey, "تسجيل الدخول", signIn),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child:
                        Text("اذا لم يكن لديك حساب يمكنك انشاء حساب من هنا ")),
                buildButtonLogin(mdw, Colors.orange, "صفحة انشاء الحساب ", () {
                  Navigator.of(context).pushNamed("signup");
                }),
                buildButtonLogin(mdw, maincolor, "الدخول من دون تسجيل", () {
                  Navigator.of(context).pushReplacementNamed("home");
                }),
                // buildButtonLogin(
                //     mdw, Colors.red, "تسجيل الدخول مع Google", (){}),
              ],
            ),
          ),
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
          obscureText: type == "password" ? true : false ,
          controller: mycontrole,
          validator: (val) {
            if (type == "username") {
              return validInput(val, 3, 30, "يكون اسم المستخدم");
            } else if (type == "password") {
              return validInput(val, 3, 30, "تكون كلمة المرور");
            }
            if (type == "email") {
              return validInput(val, 3, 100, "يكون البريد الالكتروني");
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
