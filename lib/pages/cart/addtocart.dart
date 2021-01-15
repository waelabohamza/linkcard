import 'package:flutter/foundation.dart';

class AddToCart with ChangeNotifier {
  List listitems = [];
  Map quantity = {};
  int count = 0;
  double price = 0.0;
  // For Coupon
  double discount = 0.0;

  changequantity(key, val) {
    quantity[key] = val;
  }

  applyDiscount(val) {
    discount = val;
    notifyListeners();
  }

  addItems(items, itemsprice) {
    print(items);
    count++;
    if (quantity[items['items_id']] == null ||
        quantity[items['items_id']] == 0) {
      listitems.add(items);
      quantity[items['items_id']] = 1;
      // price += double.parse(items['items_price']);
      // For Coupon ====================================
      price += itemsprice -
          itemsprice * (double.parse(items['items_discount']) / 100);
      // For Coupon ====================================
    } else {
      quantity[items['items_id']] = quantity[items['items_id']] + 1;
      // price += double.parse(items['items_price']);
      price += itemsprice -
          itemsprice * (double.parse(items['items_discount']) / 100);
    }
    notifyListeners();
  }

  removeItems(items, itemsprice) {
    if (quantity[items['items_id']] != null) {
      if (quantity[items['items_id']] == 1) {
        listitems
            .removeWhere((element) => element['items_id'] == items['items_id']);
      }
      if (quantity[items['items_id']] > 0) {
        count--;
        price -= itemsprice -
            itemsprice * (double.parse(items['items_discount']) / 100);
        quantity[items['items_id']] = quantity[items['items_id']] - 1;
      }
    }
    notifyListeners();
  }

  removeAll() {
    quantity.clear();
    listitems.clear();
    count = 0;
    price = 0.0;
    notifyListeners();
  }

  double get totalprice {
    return price;
  }

  double get afterdiscount {
    return price - ((discount / 100) * price);
  }

  int get totalcount {
    return count;
  }

  List get bascket {
    return listitems;
  }
}
