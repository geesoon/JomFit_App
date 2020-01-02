import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class VenuePage extends StatelessWidget {
  static const List venue = [
    {
      'name': 'Sport Hall 1',
      'hex_color': '0C0910',
    },
    {
      'name': 'Sport Hall 2',
      'hex_color': 'A393BF',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Venue'),
        ),
        body: ListView.builder(
          itemCount: venue.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: HexColor(venue[index]['hex_color']),
              ),
              title: Text(venue[index]['name'].toString()),
              onTap: () {
                Navigator.pop(context, venue[index]);
              },
            );
          },
        ));
  }
}
