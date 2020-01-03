import 'package:flutter/material.dart';
import 'package:jomfit/services/fetchProfile.dart';
import 'package:jomfit/services/helper-service.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;
  EditProfilePage({Key key, @required this.profile}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> profileForm = new GlobalKey<FormState>();
  bool validation = false;

  TextEditingController name = TextEditingController();
  TextEditingController matricNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

  @override
  void initState() {
    name.text = widget.profile.data.name;
    matricNo.text = widget.profile.data.matric;
    email.text = widget.profile.data.email;
    phoneNo.text = widget.profile.data.contact;
    return super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            discardChanges();
                          }),
                      Text("Edit Profile",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.0),
                      submitButton(),
                    ]),
                SizedBox(height: 20.0),
                userProfileCard(context),
              ],
            )));
  }

  Future<void> discardChanges() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Discard Changes?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Any changes made will not be saved.'),
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
                HelperService().showToast("Changes Not Saved!");
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  Widget submitButton() {
    return IconButton(
        icon:
            Icon(Icons.done, size: 30.0, color: Theme.of(context).primaryColor),
        onPressed: () {
          if (profileForm.currentState.validate()) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else {
            setState(() {
              validation = true;
            });
          }
          HelperService().showToast("Changes Saved!");
        });
  }

  Widget userProfileCard(BuildContext context) {
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
        // height: 350.0,
        child: Form(
          key: profileForm,
          autovalidate: validation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              editUserName(),
              SizedBox(height: 20.0),
              editMatricNo(),
              SizedBox(height: 20.0),
              editEmail(),
              SizedBox(height: 20.0),
              editPhoneNo(),
              SizedBox(height: 20.0),
              editPassword(),
              SizedBox(height: 20.0),
              confirmPassword(),
              SizedBox(height: 20.0),
            ],
          ),
        ));
  }

  Widget editUserName() {
    return TextFormField(
      controller: name,
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
      onSaved: (String value) {
        name.text = value;
      },
      autocorrect: false,
      validator: (String value) {
        if (value.isEmpty) {
          validation = false;
          return "Name is required";
        }
        return null;
      },
    );
  }

  Widget editMatricNo() {
    return TextFormField(
      controller: matricNo,
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
        filled: true,
        prefixIcon: Icon(Icons.confirmation_number),
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
      onSaved: (String value) {
        matricNo.text = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          validation = false;
          return "Matric number is required";
        }
        return null;
      },
    );
  }

  Widget editEmail() {
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
        filled: true,
        prefixIcon: Icon(Icons.email),
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
      onSaved: (String value) {
        email.text = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return "Email is required";
        }
        return null;
      },
    );
  }

  Widget editPhoneNo() {
    return TextFormField(
      controller: phoneNo,
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
        filled: true,
        prefixIcon: Icon(Icons.phone_android),
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
      onSaved: (String value) {
        phoneNo.text = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return "Phone number is required";
        }
        return null;
      },
    );
  }

  Widget editPassword() {
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
        filled: true,
        hintText: 'Enter new password.(Optional)',
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
      onSaved: (String value) {
        name.text = value;
      },
      autocorrect: false,
      validator: (String value) {
        if (value.isNotEmpty) {
          if (value != passwordConfirmation.text)
            return "Password not the same";
          else if (value.length < 8) {
            return "Password should be longer than 8 characters";
          }
        } else
          return null;
      },
    );
  }

  Widget confirmPassword() {
    return TextFormField(
      controller: passwordConfirmation,
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
        filled: true,
        hintText: 'Confirm new password.(Optional)',
        prefixIcon: Icon(Icons.lock_open),
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
      onSaved: (String value) {
        name.text = value;
      },
      autocorrect: false,
      validator: (String value) {
        if (value.isNotEmpty) {
          if (value != password.text)
            return "Password not the same";
          else if (value.length < 8)
            return "Password should be longer than 8 characters";
        } else
          return null;
      },
    );
  }
}
