import 'package:flutter/material.dart';
import 'package:uber_app/screens/MainScreens/HomeScreen.dart';

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
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>const HomeScreen()));
              }, icon: const Icon(Icons.arrow_back_ios)),
            ),
            const Center(
              child: Text("Home Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
