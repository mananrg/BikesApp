import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/main.dart';
import 'package:uber_app/screens/SignUpScreens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/popup.dart';
import '../MainScreens/HomeScreen.dart';
import 'OtpVerificationScreen.dart';

class EnterPhone extends StatefulWidget {
  const EnterPhone({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<EnterPhone> createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {
  final _focusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = '';
  bool buttonState = false;
  String countrycode = '+1';
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: const Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text("Back")
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // Do something when the button is tapped
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 0.4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                            size: 12,
                            Icons.question_mark_rounded,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Image.asset(
              'assets/images/logoblack.png',
              scale: 0.6,
            ),
            const Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            const Text(
              "Avoid Traffic Today",
              style: TextStyle(fontSize: 20),
            ),
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.34,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _phoneNumber = value;
                    if (kDebugMode) {
                      print(_phoneNumber);
                    }
                    if (_phoneNumber.length == 10) {
                      buttonState = true;
                    } else {
                      buttonState = false;
                    }
                  });
                },
                style: const TextStyle(
                  color: Colors.grey,
                ),
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: Colors.grey,
                  hintText: '(555)-555-5555',
                ),
              ),
            ),
            const Expanded(
              flex: 4,
              child: SizedBox(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: buttonState ? const Color(0xFF39D4AA) : Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextButton(
                onPressed: buttonState
                    ? () async {
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: countrycode + _phoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              EnterPhone.verify = verificationId;
                              showDialog(
                                context: context,
                                builder: (ctx) => PopUpMessage(
                                  title: 'OTP Sent',
                                  message:
                                      'OTP was successfully sent your registered number!',
                                ),
                              );
                              Future.delayed(const Duration(seconds: 6), () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MyVerify(),
                                  ),
                                );
                              });
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (ctx) => PopUpMessage(
                              title: 'Error',
                              message:
                                  'Error sending OTP! /n Please contact administrator for more Information',
                            ),
                          );
                        }

                        // do something when the button is pressed
                      }
                    : null,
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "We'll send a text to verify your phone",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
