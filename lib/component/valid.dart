Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String pattern_number = r'(^(?:[+0]9)?[0-9])';
final patternphone = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
RegExp regExp = new RegExp(pattern_number);
validInput(String val, int min, int max,  String textvalid , [type]) {
  if (type == "email") {
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val)) {
      return " عنوان البريد غير صحيح يجب ان يكون على سبيل المثال مثل (example@gmail.com)";
    }
  }
  if (type == "number") {
    RegExp regexnumber = new RegExp(pattern_number);
    if (!regexnumber.hasMatch(val)) {
      return 'الرجاء ادخال ارقام فقط';
      }
  }

  if (type == "phone") {
    RegExp regexphone = new RegExp(patternphone);
    if (!regexphone.hasMatch(val)) {
      return 'الرجاء ادخال رقم هاتف صحيح ';
      }
  }

  if (val.trim().isEmpty) {
    return "لا يمكن ان $textvalid فارغ";
  }
  if (val.trim().length < min) {
    return " لا يمكن ان $textvalid اصفر من $min ";
  }
  if (val.trim().length > max) {
    return " لا يمكن ان $textvalid اكبر من $max ";

  }
}
