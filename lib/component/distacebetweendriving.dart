import 'package:http/http.dart' as http;
import 'dart:convert';

destanceBetweenDriving(lat, long, destlat, destlong) async {
  var url =
      "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&mode=driving&origins=$lat,$long&destinations=$destlat%2C$destlong&key=AIzaSyDfv8bynd-akV_9fDKloFFLcQ1lMvQADGg";
  var response = await http.post(url);
  var responsebody = jsonDecode(response.body);
  var element = responsebody['rows'][0]['elements'];
  var status = element[0]['status'];
  var distance = element[0]['distance'];
  var duration = element[0]['duration'];
  var distancetext = distance['text'];
  var distancevalue = distance['value'];
  var durationtext = duration['text'];
  var durationvalue = duration['value'];
  print(responsebody);
  print("======================================");
  if (status == "OK") {
    print("distance : $distancetext");
    print("distancevalue : $distancevalue");
    print("durationtext : $durationtext");
    print("durationvalue  : $durationvalue");
  }
  if (status == "ZERO_RESULTS") {
    print(
        " ===================== distance between driving null ===================");
    return null;
  }
  // print(responsebody['rows'][0]['elements'][0]['status']) ;
  print("======================================");

  return responsebody;
}
