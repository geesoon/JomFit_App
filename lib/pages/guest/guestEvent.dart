import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jomfit/pages/myappbar.dart';
import 'package:jomfit/pages/myflexiableappbar.dart';
import 'package:jomfit/services/fetchGuestEvent.dart';
import 'package:jomfit/services/helper-service.dart';

class GuestEventPage extends StatefulWidget {
  @override
  _GuestEventPageState createState() => _GuestEventPageState();
}

class _GuestEventPageState extends State<GuestEventPage> {
  Future<GuestEvent> event;

  @override
  void initState() {
    super.initState();
    event = fetchGuestEvent();
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
    return FutureBuilder<GuestEvent>(
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

  Widget eventCard(GuestEvent events, int index) {
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

  Widget eventCardContent(GuestEvent events, int index) {
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
        ],
      ),
    );
  }

  Widget _buildEventDetailDialog(
      BuildContext context, GuestEvent events, int index) {
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
}
