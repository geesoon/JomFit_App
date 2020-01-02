import 'package:flutter/material.dart';
import 'package:jomfit/pages/event.dart';
import 'package:jomfit/pages/login.dart';
import 'package:jomfit/pages/search.dart';
import 'package:jomfit/pages/favorite.dart';
import 'package:jomfit/pages/account.dart';

class MainJomFitPage extends StatefulWidget {
  final String email;
  MainJomFitPage({this.email});
  @override
  State<StatefulWidget> createState() {
    return MainJomFitState();
  }
}

class MainJomFitState extends State<MainJomFitPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _children = [
    EventPage(),
    SearchPage(),
    FavoritePage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (widget.email == 'guest') {
        if (index == 1 || index == 2 || index == 3) {
          _selectedIndex = 0;
          loginAlert();
        } else
          _selectedIndex = 0;
      } else
        _selectedIndex = index;
      // print(index);
    });
  }

  Future<void> loginAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login to unlock features'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(children: [
                      Icon(Icons.search, color: Colors.redAccent),
                      SizedBox(width: 15.0),
                      Text("Sports hall booking"),
                    ]),
                    SizedBox(height: 10.0),
                    Row(children: [
                      Icon(Icons.favorite, color: Colors.redAccent),
                      SizedBox(width: 15.0),
                      Text("Favorite Event"),
                    ]),
                    SizedBox(height: 10.0),
                    Row(children: [
                      Icon(Icons.book, color: Colors.redAccent),
                      SizedBox(width: 15.0),
                      Text("My Booking"),
                    ]),
                    SizedBox(height: 10.0),
                    Row(children: [
                      Icon(Icons.account_circle, color: Colors.redAccent),
                      SizedBox(width: 15.0),
                      Text("My Account"),
                    ]),
                    SizedBox(height: 10.0),
                    Text("This features are only eligible to UTM students."),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Booking'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
