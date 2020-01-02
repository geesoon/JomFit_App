import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyFlexiableAppBar extends StatelessWidget {
  final double appBarHeight = 30.0;

  const MyFlexiableAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
        margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
        padding: new EdgeInsets.only(top: statusBarHeight),
        height: statusBarHeight + appBarHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Wrap(direction: Axis.horizontal, children: <Widget>[
          Text(
            "Made for ",
            style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black),
          ),
          Text(
            "those who do.",
            style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black),
          ),
          Text(
            " Start looking for your fitness event. ",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.white),
          ),
        ]));
  }
}
