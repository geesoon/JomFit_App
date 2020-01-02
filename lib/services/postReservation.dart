import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jomfit/services/fetchSearchResult.dart';
import 'dart:async';
import 'package:jomfit/services/helper-service.dart';

Future<String> bookCourt(String sport, String venue, CourtSlot courtslot,
    String date, int index) async {
  String token = await HelperService().getStringValuesSF("tokenValue");
  // print('https://jomfitutm.000webhostapp.com/api/reservation' +
  //     "?sport=" +
  //     "$sport" +
  //     "&venue=" +
  //     "$venue" +
  //     "&reserve_at=" +
  //     "$date ${courtslot.data[index].startTime}" +
  //     "&reserve_until=" +
  //     "$date ${courtslot.data[index].endTime}");
  final response = await http.post(
      'https://jomfitutm.000webhostapp.com/api/reservation' +
          "?sport=" +
          "$sport" +
          "&venue=" +
          "$venue" +
          "&reserve_at=" +
          "$date ${courtslot.data[index].startTime}" +
          "&reserve_until=" +
          "$date ${courtslot.data[index].endTime}",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  print("Reservation api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print(response.body);
    return Reservation.fromJson(json.decode(response.body)).data.status;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to reserve court');
  }
}

class Reservation {
  Data data;

  Reservation({this.data});

  Reservation.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String sport;
  String venue;
  String reserveAt;
  String reserveUntil;
  int courtNum;
  int courtId;
  int userId;
  String status;

  Data(
      {this.sport,
      this.venue,
      this.reserveAt,
      this.reserveUntil,
      this.courtNum,
      this.courtId,
      this.userId,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    sport = json['sport'];
    venue = json['venue'];
    reserveAt = json['reserve_at'];
    reserveUntil = json['reserve_until'];
    courtNum = json['court_num'];
    courtId = json['court_id'];
    userId = json['user_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sport'] = this.sport;
    data['venue'] = this.venue;
    data['reserve_at'] = this.reserveAt;
    data['reserve_until'] = this.reserveUntil;
    data['court_num'] = this.courtNum;
    data['court_id'] = this.courtId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}
