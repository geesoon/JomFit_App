import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  // final double barHeight = 30.0;

  const MyAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "JomFit",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
