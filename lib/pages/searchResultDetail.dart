import 'package:flutter/material.dart';
import 'package:jomfit/pages/search.dart';
import 'package:jomfit/services/fetchSearchResult.dart';
import 'package:jomfit/services/helper-service.dart';
import 'package:jomfit/services/postReservation.dart';

class SearchResultDetailPage extends StatefulWidget {
  final CourtSlot resultDetail;
  final String venue;
  final String sports;
  final String date;
  final int index;

  SearchResultDetailPage(
      {Key key,
      @required this.resultDetail,
      @required this.venue,
      @required this.sports,
      @required this.date,
      @required this.index})
      : super(key: key);
  _SearchResultDetailPageState createState() => _SearchResultDetailPageState();
}

class _SearchResultDetailPageState extends State<SearchResultDetailPage> {
  String booktext;
  @override
  void initState() {
    booktext = "BOOK";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  SizedBox(width: 10.0),
                  Text("Time Slot Detail",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold))
                ]),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: resultDetail(),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  onPressed: () {
                    Future<String> status = bookCourt(
                        widget.sports,
                        widget.venue,
                        widget.resultDetail,
                        widget.date,
                        widget.index);
                    String res = status.toString();
                    HelperService().showToast(res);
                    setState(() {
                      booktext = "BOOKED";
                    });
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ));
                  },
                  child: new Text("$booktext"),
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: EdgeInsets.all(15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultDetail() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.sports,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text("Date: ${widget.date}", style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 10.0),
            Text("Time: ${widget.resultDetail.data[widget.index].startTime}",
                style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 10.0),
            Text("Venue: ${widget.venue}", style: TextStyle(fontSize: 20.0)),
          ]),
    );
  }
}
