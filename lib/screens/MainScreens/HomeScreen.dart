import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uber_app/screens/Drawer/Help.dart';
import 'package:uber_app/screens/Drawer/Operator.dart';
import 'package:uber_app/screens/Drawer/PassesScreen.dart';
import 'package:uber_app/screens/Drawer/PreferencesScreen.dart';
import 'package:uber_app/screens/Drawer/RideHistory.dart';
import 'package:uber_app/screens/Drawer/Wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SignUpScreens/LoginScreen.dart';
import 'UnlockScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  late CameraPosition _cameraPosition;

  Position? currentPosition;
  var geolocator = Geolocator();

  double latitude = 0.0;
  double longitude = 0.0;

  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();
  String _scanBarcode = 'Unknown';
  late String barcodeScanRes;
  GoogleMapController? newGoogleMapController;

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition = position;
    LatLng latingposition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latingposition, zoom: 12);
    newGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    if (position != null) {
      setState(() {
        latitude = latingposition.latitude;
        longitude = latingposition.longitude;
      });
    }
  }

  Future<void> getSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? savedLatitude = prefs.getDouble('Lat');
    double? savedLongitude = prefs.getDouble('Long');
    if (savedLatitude != null && savedLongitude != null) {
      setState(() {
        latitude = savedLatitude;
        longitude = savedLongitude;
      });
      if (kDebugMode) {
        print("*" * 100);
        print("*" * 100);
        print("Inside Saved Position");
        print("*" * 200);
        print('latitude $latitude');
        print("*" * 200);
        print('longitude $longitude');
        print("*" * 200);
      }
    } else {
      setState(() {
        latitude = 37.43296265331129;
        longitude = -122.08832357078792;
      });
      if (kDebugMode) {
        print("*" * 100);
        print("*" * 100);
        print("Inside Else Position");
        print("*" * 200);
        print('latitude $latitude');
        print("*" * 200);
        print('longitude $longitude');
        print("*" * 200);
      }
    }
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  Future<void> checkLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      // Permission is granted
      _getCurrentLocation();
      getSavedLocation().then((_) {
        _cameraPosition = CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 12,
        );

        newGoogleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(_cameraPosition),
        );
      });
    } else if (status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      final result = await Permission.location.request();
      if (result.isGranted) {
        // Permission granted
        _getCurrentLocation();
        getSavedLocation().then((_) {
          _cameraPosition = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 12,
          );

          newGoogleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(_cameraPosition),
          );
        });
      } else if (result.isDenied || result.isPermanentlyDenied) {
        // Permission has been denied or is restricted, so request it
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Location Denied"),
            content: const Text(
                "You are suggested to enable location in settings and restart app"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green),
                  padding: const EdgeInsets.all(14),
                  child: const Text(
                    "OKAY",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  @override
  void dispose() {
    newGoogleMapController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kLake,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 9, right: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF39D4AA),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        weight: 12,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/logoblack.png",
                    scale: 1.3,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF39D4AA),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: GestureDetector(
                      child: const Icon(Icons.refresh),
                      onTap: () {
                        _getCurrentLocation();
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              bottom: 15,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    scanBarcodeNormal();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF39D4AA),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 3),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.qr_code_2,
                              size: 40,
                              color: Colors.white,
                            ),
                            const Text(
                              'Unlock',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          Container(
            color: const Color(0xFF39D4AA),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text.rich(
                    TextSpan(
                      text: 'Hi ',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'new user!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PreferenceScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.person,
                            color: Colors.black87,
                            size: 14,
                          ),
                          Text(
                            "My preferences",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black87,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildRow(
                      Icons.wallet,
                      "Wallet",
                      const Wallet(),
                    ),
                    buildRow(
                      Icons.history,
                      "Ride History",
                      const RideHistory(),
                    ),
                    buildRow(
                      Icons.live_help_outlined,
                      "Help",
                      const Help(),
                    ),
                    buildRow(
                      Icons.person_3_sharp,
                      "Operator",
                      const Operator(),
                    ),
                    buildRow(
                      Icons.history,
                      "Passes",
                      const PassesScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "LOGOUT",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);

      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('bikeqr')
          .doc(barcodeScanRes)
          .get();
      if (document.exists) {
        // If the document exists, navigate to a different screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const BikesScreen(),
          ),
        );
      } else {
        // If the document doesn't exist, show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid QR Code'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch (e) {
      // If there is an error, show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Padding buildRow(IconData icon, String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                icon,
                color: Colors.black87,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
