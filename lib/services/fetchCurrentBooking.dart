import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:jomfit/services/helper-service.dart';

Future<CurrentBooking> fetchCurrentBooking() async {
  String token = await HelperService().getStringValuesSF("tokenValue");
  final response = await http.get(
      'https://jomfitutm.000webhostapp.com/api/user/reservation',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
  print("Current booking api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return CurrentBooking.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load user current booking');
  }
}

class CurrentBooking {
  List<Data> data;

  CurrentBooking({this.data});

  CurrentBooking.fromJson(Map<String, dynamic> json) {
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
  int id;
  int userId;
  int courtId;
  int courtNum;
  String venue;
  String sport;
  String status;
  String reserveAt;
  String reserveUntil;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.userId,
      this.courtId,
      this.courtNum,
      this.venue,
      this.sport,
      this.status,
      this.reserveAt,
      this.reserveUntil,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courtId = json['court_id'];
    courtNum = json['court_num'];
    venue = json['venue'];
    sport = json['sport'];
    status = json['status'];
    reserveAt = json['reserve_at'];
    reserveUntil = json['reserve_until'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['court_id'] = this.courtId;
    data['court_num'] = this.courtNum;
    data['venue'] = this.venue;
    data['sport'] = this.sport;
    data['status'] = this.status;
    data['reserve_at'] = this.reserveAt;
    data['reserve_until'] = this.reserveUntil;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
