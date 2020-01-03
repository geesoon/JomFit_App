import 'package:flutter/material.dart';
import 'package:jomfit/pages/booking.dart';
import 'package:jomfit/pages/search.dart';
import 'package:jomfit/services/cancelReservation.dart';
import 'package:jomfit/services/fetchCurrentBooking.dart';
import 'package:jomfit/services/helper-service.dart';

class BookingDetailPage extends StatefulWidget {
  final int index;
  final CurrentBooking booking;

  BookingDetailPage({Key key, @required this.index, @required this.booking})
      : super(key: key);

  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool reload = false;

  @override
  Widget build(BuildContext context) {
    void updateBooking() {
      setState(() {
        var response = cancelReservation(widget.booking.data[widget.index].id);
        HelperService().showToast("$response!");
      });
    }

    Future<void> confirmDelete() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm cancel?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Cancelled booking cannot be restored.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  updateBooking();
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(
                            index: widget.index, booking: widget.booking),
                      ));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            // Image.asset("assets/images/badminton_detail.jpg"),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              SizedBox(width: 10.0),
              Text("Booking Detail",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold))
            ]),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.booking.data[widget.index].sport,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    Text("Date: ${widget.booking.data[widget.index].reserveAt}",
                        style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 10.0),
                    Text(
                        "Time: ${widget.booking.data[widget.index].reserveUntil}",
                        style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 10.0),
                    Text("Venue: ${widget.booking.data[widget.index].venue}",
                        style: TextStyle(fontSize: 20.0)),
                  ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await confirmDelete();
          setState(() {
            reload = true;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ));
        },
        child: Icon(Icons.delete, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
