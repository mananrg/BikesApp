import 'package:flutter/material.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    onPressed: () {},
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorHeight: 30,

                      onChanged: (value) {
                        _nameController.text = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding:  EdgeInsets.fromLTRB(5, 30, 2, 24),

                        // border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF39D4AA),
                        ),
                      ),
                    ),
                    TextFormField(
                      cursorHeight: 30,
                      onChanged: (value) {
                        _emailController.text = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(5, 40, 2, 24),
                        // border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF39D4AA),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.grey[400],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
