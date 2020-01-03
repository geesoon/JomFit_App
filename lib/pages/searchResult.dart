import 'package:flutter/material.dart';
import 'package:jomfit/pages/search.dart';
import 'package:jomfit/pages/searchResultDetail.dart';
import 'package:jomfit/services/fetchSearchResult.dart';

class SearchResultPage extends StatefulWidget {
  final CourtSlot courtslot;
  final String venue;
  final String sports;
  final String date;

  SearchResultPage(
      {Key key,
      @required this.courtslot,
      @required this.venue,
      @required this.sports,
      @required this.date})
      : super(key: key);
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(),
                            ));
                      }),
                  SizedBox(width: 10.0),
                  Text("Search Result",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold))
                ]),
            SizedBox(
              height: 20.0,
            ),
            isEmpty(),
          ],
        ),
      ),
    );
  }

  Widget isEmpty() {
    if (widget.courtslot.data.length == 0) {
      return Center(
        child: Column(
          children: <Widget>[
            Text("There's no result, Try again!",
                style: TextStyle(fontSize: 15.0)),
          ],
        ),
      );
    } else {
      // print("This is the null string" +widget.courtslot.data[0].endTime);
      return Column(
        children: <Widget>[
          Row(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
              child: Text("${widget.courtslot.data.length} slots",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
            ),
          ]),
          resultList(widget.courtslot),
        ],
      );
    }
  }

  Widget resultList(CourtSlot results) {
    print("Search result's length: ${results.data.length}");
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: results.data.length,
      itemBuilder: (BuildContext context, int index) {
        return resultCard(results, index);
      },
    );
  }

  Widget resultCard(CourtSlot result, int index) {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchResultDetailPage(
                                                  resultDetail: result,
                                                  venue: widget.venue,
                                                  sports: widget.sports,
                                                  date: widget.date,
                                                  index: index),
                                        ));
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            "${result.data[index].startTime} - ${result.data[index].endTime}",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5.0),
                                        Text(widget.date,
                                            style: TextStyle(fontSize: 20.0)),
                                        SizedBox(height: 5.0),
                                        Text(widget.venue,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ]),
                      )),
                  icon(widget.sports),
                ])));
  }

  Widget icon(String sports) {
    print("Image icon: " + "$sports");
    if (sports == "Badminton") {
      return Expanded(
        child: Image.asset("assets/icons/badminton.png"),
        flex: 2,
      );
    } else if (sports == "Futsal") {
      return Expanded(
        child: Image.asset("assets/icons/futsal.png"),
        flex: 2,
      );
    } else if (sports == "Gym") {
      return Expanded(
        child: Image.asset("assets/icons/gym.png"),
        flex: 2,
      );
    } else {
      return Expanded(
        child: Image.asset("assets/icons/squash.png"),
        flex: 2,
      );
    }
  }
}
