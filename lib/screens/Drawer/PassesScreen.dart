import 'package:flutter/material.dart';

class PassesScreen extends StatefulWidget {
  const PassesScreen({Key? key}) : super(key: key);

  @override
  State<PassesScreen> createState() => _PassesScreenState();
}

class _PassesScreenState extends State<PassesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: const Text("Access Pass"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContainer(
                text: "Single Trip",
                subtext: "Good for one, 30 minute trip",
                price: "\$2.95",
                BackgroundColor: Colors.white,
                TextColor: Colors.black,
                PriceColor: const Color(0xFF39D4AA)),
            GestureDetector(
              child: buildContainer(
                  text: "Adventure Pass",
                  subtext: "Unlimited, 2 hour trips",
                  price: "\$10",
                  BackgroundColor: Colors.white,
                  TextColor: Colors.black,
                  PriceColor: const Color(0xFF39D4AA)),
              onTap: () {},
            ),
            GestureDetector(
              child: buildContainer(
                  text: "Monthly Membership",
                  subtext: 'Take unlimited, 45 minute trips',
                  price: "\$29",
                  BackgroundColor: Colors.white,
                  TextColor: Colors.black,
                  PriceColor: const Color(0xFF39D4AA)),
              onTap: () {},
            ),
            GestureDetector(
              child: buildContainer(
                  text: "Annual Membership",
                  subtext: "Take Unlimited, 45 minute trips",
                  price: "\$129",
                  BackgroundColor: const Color(0xFF39D4AA),
                  TextColor: Colors.white,
                  PriceColor: Colors.white),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Padding buildContainer({
    required String text,
    required String subtext,
    required String price,
    required BackgroundColor,
    required TextColor,
    required PriceColor,
  }) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        color: BackgroundColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: TextColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            subtext,
                            style: TextStyle(fontSize: 14, color: TextColor),
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: PriceColor),
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Image.asset(
                      "assets/images/bikeriding1.png",
                      fit: BoxFit.contain,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
