import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/firebase_service.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String? _phoneNumber;
  String? _name;
  String? _email;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _getPhoneNumber();

  }

  Future<void> _getPhoneNumber() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final email = currentUser?.email;
    final name = currentUser?.displayName;
    final phoneNumber = currentUser?.phoneNumber;
    setState(() {
      _phoneNumber = phoneNumber;
      _name = name;
      _email = email;
    });
    if (kDebugMode) {
      print("*" * 100);
      print("Phone number $_phoneNumber");
      print("Name $_name");
      print("Email $_email");
      print("*" * 100);
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    padding: EdgeInsets.all(0),
                  ),
                  TextButton(
                    onPressed: () {
                      _firebaseService
                          .addUser(_nameController.text, _emailController.text,
                              _phoneNumber!)
                          .then((message) {
                        print(
                            message); // prints the message returned by the addUser method
                        if (message == 'User added successfully') {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("User Data Updated"),
                              content: const Text(
                                  "Your data has been successfully updated!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    color: Colors.green
                                    ),

                                    padding: const EdgeInsets.all(14),
                                    child: const Text(
                                      "OKAY",style: TextStyle(color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (message == 'User updated successfully') {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Data Updated"),
                              content: const Text(
                                  "User Data Successfully Updated"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                        color: Colors.green
                                    ),

                                    padding: const EdgeInsets.all(14),
                                    child: const Text(
                                      "OKAY",style: TextStyle(color: Colors.white,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }).catchError((error) {
                        print(
                            error); // prints the error if addUser method fails
                      });
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF39D4AA),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      inputWidget(
                        nameController: _nameController,
                        label: "Name",
                        read: false,
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      TextFormField(
                        readOnly: true,
                        initialValue: _phoneNumber,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(5, 25, 2, 16),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Phone",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFF39D4AA),
                          ),
                        ),
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                      inputWidget(
                        nameController: _emailController,
                        label: "Email",
                        read: false,
                      ),
                      const Divider(thickness: 1, color: Colors.grey),

                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.grey[350],
                ))
          ],
        ),
      ),
    );
  }
}

class inputWidget extends StatelessWidget {
  inputWidget({
    super.key,
    required TextEditingController nameController,
    required String label,
    required bool read,
  })  : _nameController = nameController,
        _read = read,
        _label = label;

  final TextEditingController _nameController;
  final String _label;
  final bool _read;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: false,
      onChanged: (value) {
        _nameController.text = value;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(5, 25, 2, 16),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: _label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Color(0xFF39D4AA),
        ),
      ),
    );
  }
}
