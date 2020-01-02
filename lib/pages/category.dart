import 'package:flutter/material.dart';
import 'package:native_color/native_color.dart';

class CategoryPage extends StatelessWidget {
  static const List categories = [
    {
      'name': 'Badminton',
      'hex_color': '0C0910',
    },
    {
      'name': 'Squash',
      'hex_color': 'A393BF',
    },
    {
      'name': 'Futsal',
      'hex_color': '945600',
    },
    {
      'name': 'Gym',
      'hex_color': 'C75000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Category'),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: HexColor(categories[index]['hex_color']),
              ),
              title: Text(categories[index]['name'].toString()),
              onTap: () {
                Navigator.pop(context, categories[index]);
              },
            );
          },
        ));
  }
}
