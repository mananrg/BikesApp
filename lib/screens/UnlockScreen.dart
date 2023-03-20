import 'package:flutter/material.dart';
import 'package:uber_app/screens/HomeScreen.dart';

class BikesScreen extends StatefulWidget {
  const BikesScreen({Key? key}) : super(key: key);

  @override
  State<BikesScreen> createState() => _BikesScreenState();
}

class _BikesScreenState extends State<BikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:50),
              child: IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }, icon: Icon(Icons.arrow_back_ios)),
            ),
            Center(
              child: Text("Home Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
