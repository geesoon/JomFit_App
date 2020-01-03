import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<GuestEvent> fetchGuestEvent() async {
  final response =
      await http.get('https://jomfitutm.000webhostapp.com/api/news');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return GuestEvent.fromJson(json.decode(response.body));
  } else if (response.statusCode == 400) {
    throw Exception('Bad request, please try again.');
  }
  // If that response was not OK, throw an error.
  else
    throw Exception('Failed to load post');
}

class GuestEvent {
  List<Data> data;

  GuestEvent({this.data});

  GuestEvent.fromJson(Map<String, dynamic> json) {
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
  String title;
  String description;
  String organiser;
  String url;
  String venue;
  String filename;
  String eventDate;
  String eventTime;
  String createdAt;
  String updatedAt;

  Data({
    this.id,
    this.title,
    this.description,
    this.organiser,
    this.url,
    this.venue,
    this.filename,
    this.eventDate,
    this.eventTime,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    organiser = json['organiser'];
    url = json['url'];
    venue = json['venue'];
    filename = json['filename'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['organiser'] = this.organiser;
    data['url'] = this.url;
    data['venue'] = this.venue;
    data['filename'] = this.filename;
    data['event_date'] = this.eventDate;
    data['event_time'] = this.eventTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}
