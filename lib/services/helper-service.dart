import 'package:date_format/date_format.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class HelperService {
  String defaultDate(DateTime date) {
    return formatDate(date, ['dd', ' ', 'MM', ' ', 'yyyy']);
  }

  String searchDateFormat(DateTime pickeddate) {
    final f = new DateFormat('dd-MM-yyyy');
    var date =
        f.format(pickeddate);
    print(date.toString());
    return date.toString();
  }

  void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  addStringToSF(String index, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(index, value);
  }

  Future<String> getStringValuesSF(String index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(index);
  }
}
