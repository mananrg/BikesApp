import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_app/screens/SignUpScreens/EnterPhoneNumberScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Position? currentPosition;
  var geolocator = Geolocator();
  var lat;
  var long;

  late String barcodeScanRes;
  GoogleMapController? newGoogleMapController;

  locatePosition() async {
    final prefs = await SharedPreferences.getInstance();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition = position;
    LatLng latingposition = LatLng(position.latitude, position.longitude);
    print("*" * 200);
    print('latitude ${latingposition.latitude}');
    print("*" * 200);
    print('longitude ${latingposition.longitude}');
    print("*" * 200);

    setState(() {
      lat = latingposition.latitude;
      long = latingposition.longitude;
    });
    prefs.setDouble("Long", long);
    prefs.setDouble("Lat", lat);
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      locatePosition();
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Location Denied"),
          content: const Text("Location has been Denied\nYou might have to enable location later in app!"),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView(children: [
            Container(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Welcome to",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Image.asset(
                      'assets/images/logoblack.png',
                      scale: 0.7,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.35,
                    child: Image.asset("assets/images/cycle.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 30, bottom: 30),
                    child: Text(
                      "Round-trip commuter eBikes for \n all-day or overnight rentals",
                      style: TextStyle(fontSize: 18, color: Color(0xFF39D4AA)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF39D4AA),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      child: const Text(
                        'LEARN MORE',
                        style: TextStyle(
                          color: Color(0xFF39D4AA),
                        ),
                      ),
                      onPressed: () {
                        // do something when the button is pressed
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF39D4AA),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // do something when the button is pressed
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const EnterPhone(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
