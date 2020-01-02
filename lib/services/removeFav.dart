import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:jomfit/services/helper-service.dart';

Future<RemoveFavResponse> removeFav(int eventID) async {
  String token = await HelperService().getStringValuesSF("tokenValue");

  final response = await http.get(
      'https://jomfitutm.000webhostapp.com/api/favourite/unfavourite' +
          "?event_id=" +
          "$eventID",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  print("Remove favourite api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print(response.body);
    return RemoveFavResponse(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to add to favourite');
  }
}

class RemoveFavResponse {
  String text;
  RemoveFavResponse(this.text);
}
