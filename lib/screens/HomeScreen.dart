import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.grey[800],
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView(
            children: [
              Container(
                color: Colors.black87,
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
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'new user!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: GestureDetector(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 14,
                              ),
                              Text(
                                "My preferences",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
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
                  children: [
                    buildRow(Icons.wallet,"Wallet"),
                    buildRow(Icons.history,"Ride History"),
                    buildRow(Icons.live_help_outlined,"Help"),
                    buildRow(Icons.person_3_sharp,"Operator"),

                  ],
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: const Icon(Icons.menu),
                    ),
                    Image.asset(
                      "assets/images/logoblack.png",
                      scale: 1.3,
                    ),
                    const Icon(Icons.refresh)
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logoblack.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Padding buildRow(IconData icon, String text) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 25),
      child: Row(
        children:  [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(
              icon,
              color: Colors.white54,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 18, color: Colors.white54, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
