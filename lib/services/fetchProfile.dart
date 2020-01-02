import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:jomfit/services/helper-service.dart';

Future<Profile> fetchProfile() async {
  String token = await HelperService().getStringValuesSF("tokenValue");
  // print("fetchProfile token retrived: $token");

  final response = await http
      .get('https://jomfitutm.000webhostapp.com/api/user/profile', headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  print("Profile api request:" + "${response.statusCode}");
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return Profile.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load user profile');
  }
}

class Profile {
  Data data;

  Profile({this.data});

  Profile.fromJson(Map<String, dynamic> json) {
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
  int id;
  String name;
  String email;
  Null emailVerifiedAt;
  String matric;
  String contact;
  int isAdmin;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.matric,
      this.contact,
      this.isAdmin,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    matric = json['matric'];
    contact = json['contact'];
    isAdmin = json['isAdmin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['matric'] = this.matric;
    data['contact'] = this.contact;
    data['isAdmin'] = this.isAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
