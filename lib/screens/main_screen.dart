import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider_app/widget/divider.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  double bottomPadding=0.0;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.000465, 75.633749),
    zoom: 14.4746,
  );

  //variable declaration for show current location
  Position currentPosition;
  var geoLocator = Geolocator();

  void locationPosition() async {
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    LatLng latLng = LatLng(pos.latitude, pos.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLng, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                                fontSize: 12.0, fontFamily: "Brand-Bold"),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Visit Profile")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DividerWidget(),
              SizedBox(
                height: 12.0,
              ),
              //drawer body
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontFamily: "Brand-Bold", fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(fontFamily: "Brand-Bold", fontSize: 15.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontFamily: "Brand-Bold", fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.only(bottom: bottomPadding),
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                bottomPadding=300.0;
              });
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locationPosition();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 265.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 10.0,
                      offset: Offset(0.7, 0.7))
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "Hi there, ",
                      style: TextStyle(
                          fontSize: 10.0, fontFamily: "Brand-Regular"),
                    ),
                    Text(
                      "Where to Go?, ",
                      style:
                          TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7))
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Search Drop off",
                              style: TextStyle(
                                  fontFamily: "Brand-Regular", fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Home',
                              style: TextStyle(fontFamily: "Brand-Regular"),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              'Your living home address',
                              style: TextStyle(
                                  fontFamily: "Brand-Regular",
                                  fontSize: 12.0,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DividerWidget(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Work',
                              style: TextStyle(fontFamily: "Brand-Regular"),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              'Your office address',
                              style: TextStyle(
                                  fontFamily: "Brand-Regular",
                                  fontSize: 12.0,
                                  color: Colors.black54),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
