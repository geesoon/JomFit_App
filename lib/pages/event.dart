import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jomfit/pages/myappbar.dart';
import 'package:jomfit/pages/myflexiableappbar.dart';
import 'package:jomfit/services/helper-service.dart';
import 'package:jomfit/services/fetchEvent.dart';
import 'package:jomfit/services/removeFav.dart';
import 'package:jomfit/services/storeFav.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Future<Event> event;

  @override
  void initState() {
    super.initState();
    event = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: MyAppBar(),
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar(),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            SizedBox(height: 20.0),
            eventBar(),
            eventList(),
          ]))
        ],
      ),
    );
  }

  Widget eventBar() {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Events in",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              "University Technology Malaysia",
              style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )
          ],
        ));
  }

  Widget eventList() {
    return FutureBuilder<Event>(
        future: event,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.data.length,
              itemBuilder: (BuildContext context, int index) {
                print(snapshot.data);
                return eventCard(snapshot.data, index);
              },
            );
          else
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            );
        });
  }

  Widget eventCard(Event events, int index) {
    return Container(
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2.0,
              ),
            ]),
        child: eventCardContent(events, index));
  }

  Widget eventCardContent(Event events, int index) {
    String filename = events.data[index].filename;
    String url =
        "https://jomfitutm.000webhostapp.com/storage/uploads/" + "$filename";
    return ClipRRect(
      borderRadius: new BorderRadius.circular(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network('$url'),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(events.data[index].eventDate,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.0),
                          Text(events.data[index].title,
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 5.0),
                          Text(events.data[index].venue,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.grey)),
                        ]),
                  ),
                  OutlineButton(
                    child: Text("SHOW",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    color: Colors.redAccent,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildEventDetailDialog(context, events, index),
                      );
                    },
                  )
                ]),
          ),
          Align(
              alignment: Alignment.center,
              child: IconButton(
                  icon: (_isFavorite(events.data[index].isFavourite)
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_border, color: Colors.red)),
                  iconSize: 25.0,
                  onPressed: () {
                    _toggleFavorite(events.data[index]);
                  }))
        ],
      ),
    );
  }

  Widget _buildEventDetailDialog(
      BuildContext context, Event events, int index) {
    return new AlertDialog(
      title: Text(events.data[index].title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 10.0),
            Text(events.data[index].eventDate),
          ]),
          SizedBox(height: 10.0),
          Row(children: [
            Icon(Icons.access_time),
            SizedBox(width: 10.0),
            Text(events.data[index].eventTime),
          ]),
          SizedBox(height: 10.0),
          Row(children: [
            Icon(Icons.place),
            SizedBox(width: 10.0),
            new Flexible(
              child: Text(events.data[index].venue),
            ),
          ]),
          SizedBox(height: 10.0),
          Row(children: [
            Icon(Icons.link),
            SizedBox(width: 10.0),
            new Flexible(
              child: Linkify(
                  onOpen: HelperService().onOpen,
                  text: "${events.data[index].url}"),
            ),
          ]),
          SizedBox(height: 10.0),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        )
      ],
    );
  }

  bool _isFavorite(int isFavourite) {
    if (isFavourite == 1)
      return true;
    else
      return false;
  }

  void _toggleFavorite(Data event) {
    setState(() {
      if (event.isFavourite == 1) {
        var response = removeFav(event.id);
        print(response);
        HelperService().showToast("Unfavorited!");
        setState(() {
          event.isFavourite = 0;
        });
      } else {
        var response = storeFav(event.id);
        print(response);
        HelperService().showToast("Favorited!");
        setState(() {
          event.isFavourite = 1;
        });
      }
    });
  }
}
