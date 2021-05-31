import 'dart:io';
import 'package:linkcard/component/alert.dart';

onWillPop(context) {
    return showAlert(context, "error", "تنبيه", "هل تريد اغلاق التطيبق", () {},
            () {
          exit(0);
        }) ??
        false;
  }