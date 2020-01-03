import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:jomfit/services/helper-service.dart';

Future<CourtSlot> fetchSearchResult(
    String date, String sport, String venue) async {
  String token = await HelperService().getStringValuesSF("tokenValue");
  // print("CourtSlot header token:" + token);
  print('https://jomfitutm.000webhostapp.com/api/court' +
      '?date=' +
      '$date' +
      '&sport=' +
      '$sport' +
      '&venue=' +
      '$venue');
  final response = await http.get(
      'https://jomfitutm.000webhostapp.com/api/court' +
          '?date=' +
          '$date' +
          '&sport=' +
          '$sport' +
          '&venue=' +
          '$venue',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  print("CourtSlot api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return CourtSlot.fromJson(json.decode(response.body));
  } else {
    throw Exception("Court does not exist. Try again.");
  }
}

class CourtSlot {
  List<Data> data;

  CourtSlot({this.data});

  CourtSlot.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String startTime;
  String endTime;

  Data({this.startTime, this.endTime});

  Data.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    print("Starttime in parsing json: " + startTime);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
