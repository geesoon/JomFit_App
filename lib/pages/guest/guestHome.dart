import 'package:flutter/material.dart';
import 'package:jomfit/pages/guest/guestEvent.dart';
import 'package:jomfit/pages/guest/guestLogin.dart';
// import 'package:jomfit/pages/login.dart';

class MainGuestHomePage extends StatefulWidget {
  final String email;
  MainGuestHomePage({this.email});
  @override
  State<StatefulWidget> createState() {
    return MainGuestHomeState();
  }
}

class MainGuestHomeState extends State<MainGuestHomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _children = [
    GuestEventPage(),
    GuestLoginPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0)
        _selectedIndex = 0;
      else
        _selectedIndex = 1;
    });
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
