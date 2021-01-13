import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {

  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId = 'AZpEetlGAH3wy7YFtyDHjweVF5-Ah3L0nAC9KaZVAA8-YiTGvxkpsRwo1twk6iZS-wjCrkcBiqVnqdT0';
  String secret = 'EEMS4J-c4AAUSroPFgvVU-4SjBNAvHrEdw7oT0XrhLPoKGG08CafM5B5A5lCYE2-N2Rm2fIU3a8D_Vtt';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post('$domain/v1/oauth2/token?grant_type=client_credentials');
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        print("=================================== Token =====================================") ; 
        print( body["access_token"]) ; 
        print("=================================== End Token =====================================") ; 
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post("$domain/v1/payments/payment",
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

        print("Link Body in CreatePaypalPayment 201 ==========================") ; 
        print("$links") ; 
        print("Link Body in CreatePaypalPayment End 201 ===========================") ; 
     


          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        print("Link Body in CreatePaypalPayment  != 201") ; 
        print("$body") ; 
        print("Link Body in CreatePaypalPayment End != 201") ; 
        throw Exception(body["message"]);
        // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") ; 
      }
    } catch (e) {
      rethrow;
        // print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") ; 

    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("====================== executePayment Return Success =========================") ; 
        print(body['state']) ; 
        print("====================== executePayment Return End Success =================================") ; 
        // return body["id"];
        return body['state'] ; 
      }
        print("====================== executePayment Return faild =========================") ; 
        print(body) ; 
        print("====================== executePayment Return End faild =================================") ; 
      return null;
    } catch (e) {
      rethrow;
    }
  }
}