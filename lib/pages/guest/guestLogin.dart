import 'package:jomfit/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:jomfit/services/helper-service.dart';
import 'package:jomfit/services/loginAuth.dart';

class GuestLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuestLoginPageState();
  }
}

class GuestLoginPageState extends State<GuestLoginPage> {
  Token token;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validation = false;
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          backgroundLayer(context),
          mainLayer(context),
        ],
      ),
    ));
  }

  Widget backgroundLayer(context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.lightGreen[50],
            Theme.of(context).accentColor,
          ])),
    );
  }

  Widget mainLayer(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: loginForm,
        autovalidate: validation,
        child: Column(
          children: <Widget>[
            iconApp(),
            SizedBox(height: 5),
            iconText(),
            SizedBox(
              height: 20,
            ),
            inputEmail(),
            SizedBox(height: 10),
            inputPassword(),
            SizedBox(
              height: 20,
            ),
            submitButton(context),
          ],
        ),
      ),
    ));
  }

  Widget iconText() {
    return Text(
      'JomFit',
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget iconApp() {
    return Image.asset(
      'assets/icons/jomfit.png',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }

  Widget inputEmail() {
    return TextFormField(
      controller: email,
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
        fillColor: Colors.white,
        hintText: 'Email',
        filled: true,
        prefixIcon: Icon(Icons.account_circle),
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
      style: TextStyle(
        fontSize: 16.0,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Email is required";
        }
        return null;
      },
    );
  }

  Widget inputPassword() {
    return TextFormField(
      controller: password,
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
        fillColor: Colors.white,
        hintText: 'Password',
        filled: true,
        prefixIcon: Icon(Icons.lock),
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
      style: TextStyle(
        fontSize: 16.0,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Password is required";
        }
        return null;
      },
      obscureText: true,
    );
  }

  Widget submitButton(context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        color: Colors.blueAccent,
        child: Text(
          'login'.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          if (loginForm.currentState.validate()) {
            try {
              token = await loginAuth(email.text, password.text);
              print(token.success.token);
              HelperService().addStringToSF("tokenValue", token.success.token);
              HelperService().showToast("Welcome back!");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainJomFitPage(
                    email: '${email.text}',
                  ),
                ),
              );
            } on Exception catch (error) {
              HelperService().showToast("${error.toString()}");
            }
          } else {
            setState(() {
              validation = true;
            });
          }
        },
      ),
    );
  }
}
