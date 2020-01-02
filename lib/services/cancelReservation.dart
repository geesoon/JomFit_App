import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:jomfit/services/helper-service.dart';

Future<String> cancelReservation(int bookingID) async {
  String token = await HelperService().getStringValuesSF("tokenValue");
  final response = await http.get(
      'https://jomfitutm.000webhostapp.com/api/cancelreservation' +
          "?book_id=" +
          "$bookingID",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  print("Cancel booking api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return CancelReservation(response.body).text;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to cancel this booking');
  }
}

class CancelReservation {
  String text;
  CancelReservation(this.text);
}
