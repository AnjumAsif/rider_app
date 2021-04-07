import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MainScreen extends StatelessWidget {

  static const String idScreen="mainScreen";
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
    );
  }
}
