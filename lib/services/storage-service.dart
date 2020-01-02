import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService{

  Future<void> saveFavoriteData(List list)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('list_favorite',jsonEncode(list));
  }

  Future<List> getFavoriteData()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return jsonDecode(pref.getString('list_favorite'));
  }
}