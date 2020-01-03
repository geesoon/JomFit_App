import 'package:flutter/material.dart';
import 'package:jomfit/pages/favoriteDetail.dart';
import 'package:jomfit/services/fetchFav.dart';
import 'package:jomfit/services/removeFav.dart';

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
        Column(
          // alignment: WrapAlignment.start,
          // crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text("My Favourite",
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ]),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Swipe right to remove",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15.0)),
              ],
            ),
          ],
        ),
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
                if (snapshot.data.data.isEmpty) {
                  return Container(
                    child: Text("No fav"),
                  );
                } else {
                  return Dismissible(
                      // Show a red background as the item is swiped away.
                      background: Container(
                        // color: Colors.,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 40.0,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      direction: DismissDirection.startToEnd,
                      key: Key(snapshot.data.data[index].title),
                      onDismissed: (direction) {
                        setState(() {
                          removeFav(snapshot.data.data[index].id);
                          snapshot.data.data.removeAt(index);
                        });
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${snapshot.data.data[index].title} event unfavourited.")));
                      },
                      child: favoriteCard(snapshot.data, index));
                }
              },
            );
          else
            return CircularProgressIndicator();
        });
  }

  Widget favoriteCard(Favourite fav, int index) {
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
                    flex: 4,
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
                  // Expanded(
                  //     flex: 2,
                  //     child: IconButton(
                  //         icon: Icon(Icons.favorite, color: Colors.red),
                  //         iconSize: 25.0,
                  //         onPressed: () {
                  //           _unFavorite(fav.data[index]);
                  //         })),
                ])));
  }
}
