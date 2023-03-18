import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class UserAgreement extends StatefulWidget {
  const UserAgreement({Key? key}) : super(key: key);

  @override
  State<UserAgreement> createState() => _UserAgreementState();
}

class _UserAgreementState extends State<UserAgreement> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(height:  size.height,
          
          
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.35,
                child: Image.asset("assets/images/cycle.png"),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18.0,bottom: 24),
                child: Text(
                  "User Agreement",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text.rich(
                  TextSpan(
                    text: 'By tapping “I Agree”, I confirm that I am at least 18 years old, or other legal age of majority, and that I have read and agreed to Metro Mobility’s',
                    style: const TextStyle(fontSize: 16,color: Colors.grey),
                    children: [

                       TextSpan(
                        text: ' User Agreement',
                        style: const TextStyle(fontSize: 16,color: Colors.blue,decoration: TextDecoration.underline,),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Do something when the link is tapped
                          },
                      ), const TextSpan(
                        text: ' and ',
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                      ),  TextSpan(
                        text: 'Privacy Notice.',
                        style: const TextStyle(fontSize: 16,color: Colors.blue, decoration: TextDecoration.underline,),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Do something when the link is tapped
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox(),),
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF39D4AA),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextButton(
                    child: const Text(
                      'I Agree',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // do something when the button is pressed
Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen(),),);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
