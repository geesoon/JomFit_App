import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jomfit/services/fetchFav.dart';
import 'package:jomfit/services/helper-service.dart';

class FavoriteCardDetailPage extends StatelessWidget {
  final Favourite favor;
  final int index;
  FavoriteCardDetailPage({Key key, @required this.favor, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String filename = favor.data[index].filename;
    String url =
        "https://jomfitutm.000webhostapp.com/storage/uploads/" + "$filename";
    return Scaffold(
        // appBar: AppBar(title: Text("Favorite Detail")),
        body: Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          // Padding()
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            SizedBox(width: 10.0),
            Text("Favorite Detail",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold))
          ]),
          SizedBox(height: 15.0),
          Image.network("$url"),
          SizedBox(height: 15.0),
          Text(
            favor.data[index].title,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(favor.data[index].eventDate,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text(
            favor.data[index].venue,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Linkify(
              onOpen: HelperService().onOpen,
              text: favor.data[index].url,
              style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 15.0),
          Text(
            favor.data[index].description,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    ));
  }
}
