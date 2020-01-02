import 'package:flutter/material.dart';
import 'package:jomfit/pages/favoriteDetail.dart';
import 'package:jomfit/services/fetchFav.dart';
import 'package:jomfit/services/helper-service.dart';
// import 'package:jomfit/services/removeFav.dart';
import 'package:jomfit/services/storeFav.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  Future<Favourite> favourite;

  @override
  void initState() {
    super.initState();
    favourite = fetchFav();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20.0),
      child: ListView(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("My Favourite",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        ]),
        SizedBox(height: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            favoriteList(),
          ],
        ),
      ]),
    ));
  }

  Widget favoriteList() {
    return FutureBuilder<Favourite>(
        future: favourite,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.data.length,
              itemBuilder: (BuildContext context, int index) {
                print("Snapshot:" + snapshot.data.toString());
                return favoriteCard(snapshot.data, index);
              },
            );
          else
            return CircularProgressIndicator();
        });
  }

  Widget favoriteCard(Favourite fav, int index) {
    Icon icon = Icon(Icons.favorite, color: Colors.red);
    String filename = fav.data[index].filename;
    String url =
        "https://jomfitutm.000webhostapp.com/storage/uploads/" + "$filename";
    return Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2.0,
              ),
            ]),
        child: ClipRRect(
            borderRadius: new BorderRadius.circular(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(url),
                  ),
                  Expanded(
                    flex: 6,
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: Wrap(children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FavoriteCardDetailPage(
                                            favor: fav, index: index),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text(fav.data[index].eventDate,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5.0),
                                      Text(fav.data[index].title,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(fontSize: 15.0)),
                                      SizedBox(height: 5.0),
                                      Text(fav.data[index].venue,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 13.5,
                                              color: Colors.grey)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        icon: icon,
                        iconSize: 25.0,
                        onPressed: () {
                          // _toggleFavorite();
                          setState(() {
                            var response = storeFav(fav.data[index].id);
                            icon =
                                Icon(Icons.favorite_border, color: Colors.red);
                            print(response);
                            HelperService().showToast("Favorited!");
                          });
                        }),
                  ),
                ])));
  }
}
