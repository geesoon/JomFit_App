import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:jomfit/services/helper-service.dart';

Future<StoreFavResponse> storeFav(int eventID) async {
  String token = await HelperService().getStringValuesSF("tokenValue");

  final response = await http.get(
      'https://jomfitutm.000webhostapp.com/api/favourite/store' + "?event_id=" + "$eventID",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  print("Store Favourite api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print(response.body);
    return StoreFavResponse(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to add to favourite');
  }
}

class StoreFavResponse {
  String text;
  StoreFavResponse(this.text);
}
