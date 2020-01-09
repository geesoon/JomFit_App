import 'package:flutter/material.dart';
import 'package:jomfit/pages/bookingDetail.dart';
import 'package:jomfit/pages/category.dart';
import 'package:jomfit/pages/searchResult.dart';
import 'package:jomfit/pages/venue.dart';
import 'package:jomfit/services/fetchCurrentBooking.dart';
import 'package:jomfit/services/fetchSearchResult.dart';
import 'package:jomfit/services/helper-service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool connection = false;
  GlobalKey<FormState> searchForm = GlobalKey<FormState>();
  TextEditingController date =
      TextEditingController(text: HelperService().defaultDate(DateTime.now()));
  TextEditingController time = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController venue = TextEditingController();

  bool validation = false;
  Map selectedCategory;
  Map selectedVenue;

  Future<CurrentBooking> currBooking;
  CourtSlot courtslot;

  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    currBooking = fetchCurrentBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Hi Gee Soon"), centerTitle: true),
      body: ListView(
        children: <Widget>[
          searchPageLayer(context),
        ],
      ),
    );
  }

  Widget searchPageLayer(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: Column(children: [
          pageBar(),
          searchBox(),
        ]));
  }

  Widget pageBar() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 10.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Search",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
        ]));
  }

  Widget searchBox() {
    return Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: searchForm,
          autovalidate: validation,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15),
                inputCategory(),
                SizedBox(height: 20),
                inputVenue(),
                SizedBox(height: 25),
                inputDate(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.play_circle_filled),
                    iconSize: 50.0,
                    color: Colors.redAccent,
                    onPressed: () async {
                      try {
                        String formatdate =
                            HelperService().searchDateFormat(selectedDate);
                        courtslot = await fetchSearchResult(
                            formatdate, category.text, venue.text);
                        HelperService().showToast("Here's your search result.");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultPage(
                                  courtslot: courtslot,
                                  venue: venue.text,
                                  sports: category.text,
                                  date: formatdate),
                            ));
                      } on Exception catch (error) {
                        print("${error.toString()}");
                        HelperService().showToast("${error.toString()}");
                      }
                    },
                  ),
                ),
                currentBooking(),
                bookingList(context)
              ]),
        ));
  }

  Widget currentBooking() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Current Booking",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget inputDate() {
    return TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.black),
          hintText: 'Select date',
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.only(
            top: 18.0,
            right: 18.0,
            bottom: 18.0,
            left: 25.0,
          ),
          errorStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        controller: date,
        readOnly: true,
        onTap: () => openDatePicker(),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter a date';
          }
          return null;
        });
  }

  Widget inputCategory() {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: Icon(Icons.star, color: Colors.black),
        hintText: 'Select sports',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.only(
          top: 18.0,
          right: 18.0,
          bottom: 18.0,
          left: 25.0,
        ),
        errorStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      controller: category,
      readOnly: true,
      onTap: () => goToCategoryPage(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please select a category.';
        }
        return null;
      },
    );
  }

  Widget inputVenue() {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: Icon(Icons.place, color: Colors.black),
        hintText: 'Select venue',
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.only(
          top: 18.0,
          right: 18.0,
          bottom: 18.0,
          left: 25.0,
        ),
        errorStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      controller: venue,
      readOnly: true,
      onTap: () => goToVenuePage(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please select a venue.';
        }
        return null;
      },
    );
  }

  Widget bookingList(BuildContext context) {
    return FutureBuilder<CurrentBooking>(
        future: currBooking,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.data.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return bookingCard(snapshot.data, index, context);
              },
            );
          else
            return CircularProgressIndicator();
        });
  }

  Widget bookingCard(CurrentBooking booking, int index, BuildContext context) {
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
                Colors.redAccent,
              ])),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: new Image(
              image: new AssetImage(icon(booking.data[index].sport)),
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
            ),
            title: Text(
              booking.data[index].sport,
              style: TextStyle(fontSize: 18.0),
            ),
            subtitle: Text(booking.data[index].reserveAt),
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

  String icon(String sports) {
    if (sports == "Badminton") {
      return "assets/icons/badminton.png";
    } else if (sports == "Futsal") {
      return "assets/icons/futsal.png";
    } else if (sports == "Gym") {
      return "assets/icons/gym.png";
    } else {
      return "assets/icons/squash.png";
    }
  }

  openDatePicker() async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    String datePickerValue = HelperService().defaultDate(pickedDate);

    selectedDate = pickedDate;

    if (pickedDate != null && datePickerValue != date.text) {
      setState(() {
        date.text = HelperService().defaultDate(pickedDate);
      });
    }
  }

  goToCategoryPage() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPage(),
        ));
    print(result);
    if (result != null) {
      setState(() {
        selectedCategory = result;
        category.text = selectedCategory['name'];
        print(selectedCategory['name']);
      });
    }
  }

  goToVenuePage() async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VenuePage(),
        ));
    print(result);
    if (result != null) {
      setState(() {
        selectedVenue = result;
        venue.text = selectedVenue['name'];
        print(selectedVenue['name']);
      });
    }
  }
}
