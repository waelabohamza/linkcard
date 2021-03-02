import 'package:linkcard/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:linkcard/linkapi.dart';
// import 'package:path/path.dart';
// import 'dart:io';

String basicAuth = 'Basic ' +
    base64Encode(utf8
        .encode('LinkCard5842171Username@@@:LinkCard0942258459Password@@@'));
Map<String, String> myheaders = {
  // 'content-type': 'application/json',
  // 'accept': 'application/json',
  'authorization': basicAuth
};

class Crud {
  readData(String url) async {
    try {
      var response = await http.get(url, headers: myheaders);
      if (response.statusCode == 200) {
        print(response.body);
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("page not found");
      }
    } catch (e) {
      print("error caught : ");
      print(e);
    }
  }

  readDataWhere(String url, String value) async {
    var data;
    data = {"id": value.toString()};
    try {
      var response = await http.post(url, body: data, headers: myheaders);
      if (response.statusCode == 200) {
        print(response.body);
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("page not found");
      }
    } catch (e) {
      print("error caught : ");
      print(e);
    }
  }

  writeData(String url, var data) async {
    try {
      var response = await http.post(url, body: data, headers: myheaders);
      if (response.statusCode == 200) {
        print(response.body);
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("page Not found Write Data ");
      }
    } catch (e) {
      print("error caught : ");
      print(e);
    }
  }

  addOrders(var data) async {
    var url = linkaddorider;
    var response =
        await http.post(url, body: json.encode(data), headers: myheaders);
    if (response.statusCode == 200) {
      print(response.body);
      var responsebody = response.body;
      return responsebody;
    } else {
      print("page Not found");
    }
  }
}
