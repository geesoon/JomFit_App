import 'package:flutter/material.dart';
import 'package:jomfit/pages/bookingDetail.dart';
import 'package:jomfit/services/fetchCurrentBooking.dart';

class BookingPage extends StatefulWidget {
  final int index;
  final CurrentBooking booking;

  BookingPage({Key key, @required this.index, @required this.booking})
      : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                pageBar(),
                SizedBox(height: 20.0),
                bookingList(widget.booking),
              ],
            )));
  }

  Widget pageBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("My Booking",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget bookingList(CurrentBooking bookings) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: bookings.data.length,
      itemBuilder: (BuildContext context, int index) {
        return bookingCard(bookings, index);
      },
    );
  }

  Widget bookingCard(CurrentBooking booking, int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.09),
              spreadRadius: 2.5,
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.lightGreen[50],
                Theme.of(context).accentColor,
              ])),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.book, color: Colors.redAccent),
            title: Text(
              booking.data[index].sport,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            subtitle: Text(booking.data[index].reserveAt),
            // Text('30 Nov 2019, 1600-1800, Sports hall 1'),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('View Details',
                    style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingDetailPage(index: index, booking: booking),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
