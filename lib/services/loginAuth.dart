import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Token> loginAuth(String email, String password) async {
  print('http://jomfitutm.000webhostapp.com/api/login?email=$email&password=$password');
  final response = await http.post(
      'http://jomfitutm.000webhostapp.com/api/login?email=$email&password=$password');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print("Login response code:" + "${response.statusCode}");
    return Token.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw new Exception('Email or password are invalid!');
  }
}

class Token {
  Success success;

  Token({this.success});

  Token.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    return data;
  }
}

class Success {
  String token;

  Success({this.token});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
