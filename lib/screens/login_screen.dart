import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rider_app/main.dart';
import 'package:rider_app/screens/main_screen.dart';
import 'package:rider_app/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailController ;

  String passwordController ;
  bool showSpinner = false;

  final _firebaseAuth = FirebaseAuth.instance;

  void loginAuthenticateUser(BuildContext context) async {

    final user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController, password: passwordController).catchError((onError) {
          setState(() {
            showSpinner=false;
          });
      displayMessage("Error: " + onError.toString());
    })).user;
    if (user != null) {
      setState(() {
        showSpinner=false;
      });
      Navigator.pushNamed(context, MainScreen.idScreen);
    }

    // final User userData = userCredential.user;
    if (user != null) {
      userRef.child(user.uid).once().then((value) => (DataSnapshot snap) {
            if (snap != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.idScreen, (route) => false);
              displayMessage('Your are logged in successfully');
            } else {
              displayMessage('No record found');
              _firebaseAuth.signOut();

            }
          });
    }
  }

  displayMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
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
                  "Login as a Rider",
                  style: TextStyle(fontSize: 24, fontFamily: "Brand-Bold"),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      TextFormField(
                        onChanged: (value){
                          emailController=value;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                        onChanged: (value){
                          passwordController=value;
                        },
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.0,
                                fontFamily: "Brand-Regular")),
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {

                          if (emailController.isEmpty) {
                            displayMessage('Enter valid email id');
                          } else if (passwordController.isEmpty) {
                            displayMessage('Mobile number is mandatory.');
                          }
                          else{
                            setState(() {
                              showSpinner=true;
                            });
                          loginAuthenticateUser(context);}
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
                              'Login',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 24.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text(
                          "Do not have an Account? Register here.",
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
      ),
    );
  }
}
