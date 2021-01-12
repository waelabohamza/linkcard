import 'dart:convert';
import 'package:http/http.dart' as http;

class CheckoutPayment {

  static const String _tokenUrl = "https://api.sandbox.checkout.com/tokens";
  static const String _paymentUrl = "https://api.sandbox.checkout.com/payments";
  static const String publicKey = "pk_test_a4fe23c0-abb3-4115-af75-bff9bb2110ba";
  static const String secretKey = "sk_test_5d58fb86-5f57-40c1-b3ae-cb4d68d6b30e";

  static const Map<String, String> _tokenHeader = {
    "Accept": "application/json",
    "content-type": "application/json",
    'Authorization': publicKey
  };
  static const Map<String, String> _paymentHeader = {
    "Accept": "application/json",
    "content-type": "application/json",
    'Authorization': secretKey
  };

  Future<String> _getToken(PaymentCard card) async {
    Map<String, String> body = {
      'type': 'card',
      'number': card.number,
      'expiry_month': card.expiryMonth,
      'expiry_year': card.expiryYear , 
      "cvv" : card.cvv
    };
    var response = await http.post(_tokenUrl,
        headers: _tokenHeader, body: jsonEncode(body));

    switch (response.statusCode) {
      case 201:
        var data = jsonDecode(response.body);
        return data['token'];
        break;
      default:
        print("${response.statusCode}");
        return "false";
        break;
    }
  }

  Future<bool> makePayment(PaymentCard card, double amount) async {
    String token = await _getToken(card);
    print(token);
    Map<String, dynamic> body = {
      "source": {"type": "token", "token": "$token"},
      "amount":  (amount * 100).toInt(),
      // "amount":  1000,
      "currency": "USD",
    };
    var response = await http.post(_paymentUrl,
        headers: _paymentHeader, body: jsonEncode(body));
    switch (response.statusCode) {
      case 201:
        var data = jsonDecode(response.body);
        print("price : ${ (amount * 1000).toInt()}") ; 
        print(data['approved']);
        return data['approved'];
        break;
      default:
       
        print("invalid payment");
        break;
    }
    return false;
  }
}
class PaymentCard {
  String number, expiryMonth, expiryYear , cvv;
  PaymentCard({this.number, this.expiryMonth, this.expiryYear , this.cvv});
}
