import 'package:flutter/material.dart';
import 'package:jomfit/pages/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JomFit',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,//The first page when app start up
    );
  }
} 