import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget{
  static const String idScreen="registerScreen";
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
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                          TextStyle(color: Colors.grey, fontSize: 10.0,fontFamily: "Brand-Regular")),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle:
                          TextStyle(color: Colors.grey, fontSize: 10.0,fontFamily: "Brand-Regular")),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
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
                      onPressed: () {},
                      onLongPress: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          onPrimary: Colors.white,
                          shadowColor: Colors.red,
                          elevation: 5.0,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)))),
                      child: Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            'Create an Account',
                            style: TextStyle(color: Colors.blue, fontSize: 24.0),
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