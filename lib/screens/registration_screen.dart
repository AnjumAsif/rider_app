import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/screens/main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String idScreen = "registerScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firebaseAuth = FirebaseAuth.instance;
  String name;
  String email;
  String password;
  String mobileNumber;

  void registerUser(BuildContext context) async {
    final userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((onError) {
      displayMessage("Error: " + onError.toString());
    });
    if (userCredential != null) {
      User userData = userCredential.user;
      //save data into firebase
      Map userMapData = {"name": name, "email": email, "phone": mobileNumber};
      userRef.child(userData.uid).set(userMapData);
      displayMessage('Congratulations, Your account has been created');
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      //show error message
      displayMessage('User has not been created');
    }
  }

  displayMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 55.0),
              Image(
                image: AssetImage("images/logo.png"),
                width: 200,
                height: 100,
                alignment: Alignment.center,
              ),
              SizedBox(height: 15.0),
              Text(
                "Register as a Rider",
                style: TextStyle(fontSize: 24, fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontFamily: "Brand-Regular")),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontFamily: "Brand-Regular")),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontFamily: "Brand-Regular")),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      onChanged: (value) {
                        mobileNumber = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                              fontFamily: "Brand-Regular")),
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        if (name.length > 4) {
                          displayMessage('Name must be 3 character length');
                        } else if (!email.contains("@")) {
                          displayMessage('Enter valid email id');
                        } else if (mobileNumber.isEmpty) {
                          displayMessage('Mobile number is mandatory.');
                        } else if (password.length < 5) {
                          displayMessage('Password should be 6 character');
                        } else {
                          registerUser(context);
                        }
                      },
                      onLongPress: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          onPrimary: Colors.white,
                          shadowColor: Colors.red,
                          elevation: 5.0,
                          shape: BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'Create an Account',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 24.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "You have an already Account? Login here.",
                        style: TextStyle(fontFamily: "Brand-Regular"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
