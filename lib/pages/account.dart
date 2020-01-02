import 'package:flutter/material.dart';
import 'package:jomfit/pages/editProfile.dart';
import 'package:jomfit/pages/login.dart';
import 'package:jomfit/services/fetchProfile.dart';
import 'package:jomfit/services/helper-service.dart';
import 'package:jomfit/services/logout.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<Profile> profile;

  @override
  void initState() {
    super.initState();
    profile = fetchProfile();
  }

  Profile userprofile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("My Profile",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.0),
                      IconButton(
                        icon: Icon(Icons.mode_edit,
                            size: 30.0, color: Theme.of(context).primaryColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(profile: userprofile),
                              ));
                        },
                      ),
                    ]),
                SizedBox(height: 20.0),
                profileBuilder(),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: RaisedButton(
                      onPressed: () {
                        logout();
                        HelperService().showToast("You're logout!");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: new Text("LOGOUT"),
                      textColor: Colors.white,
                      color: Colors.redAccent,
                      padding: EdgeInsets.all(15.0),
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget profileBuilder() {
    return FutureBuilder<Profile>(
        future: profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data);
            userprofile = snapshot.data;
            return userProfileCard(snapshot.data);
            // return Container();
          } else
            return CircularProgressIndicator();
        });
  }

  Widget userProfileCard(Profile user) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                spreadRadius: 4.0,
              )
            ],
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.lightGreen[50],
                  Theme.of(context).accentColor,
                ])),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.account_circle,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20.0),
                  new Flexible(
                      child: Text(user.data.name.toUpperCase(),
                          style: TextStyle(fontSize: 18.0))),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.confirmation_number,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20.0),
                  new Flexible(
                      child: Text(user.data.matric.toUpperCase(),
                          style: TextStyle(fontSize: 18.0))),
                ]),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Icon(
                    Icons.email,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20.0),
                  new Flexible(
                      child: Text(user.data.email,
                          style: TextStyle(fontSize: 18.0))),
                ]),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Icon(
                    Icons.phone_android,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20.0),
                  new Flexible(
                      child: Text(user.data.contact.toUpperCase(),
                          style: TextStyle(fontSize: 18.0))),
                ]),
              ],
            )),
          ],
        ));
  }
}
