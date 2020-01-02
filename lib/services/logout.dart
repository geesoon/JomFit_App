import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:jomfit/services/helper-service.dart';

Future<void> logout() async {
  String token = await HelperService().getStringValuesSF("tokenValue");
  final response = await http
      .get('https://jomfitutm.000webhostapp.com/api/user/logout', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  print("Current booking api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print("Successfully logout!");
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to logout');
  }
}
