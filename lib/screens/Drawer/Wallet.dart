import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String amt = " 0.00";
  String dollar = "\$";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Wallet"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: Text(
                "Total Balance",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Text(
              dollar + amt,
              style: const TextStyle(fontSize: 54),

            ),
            TextButton(
              onPressed: () {},
              child: const Text("Manage >",style: TextStyle(fontSize: 20),
              ),
            ),Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Price \n",style: TextStyle(fontSize: 16, color: Colors.grey),),
                  Text("Per-rental: \$1.00 to start",style: TextStyle(fontSize: 16, color: Colors.grey),),
                  Text("Per-minute: \$0.15",style: TextStyle(fontSize: 16, color: Colors.grey),),
                  Text("Max-charge: \$12.00 per day",style: TextStyle(fontSize: 16, color: Colors.grey),),

                ],),
            )
          ],
        ),
      ),
    );
  }
}
