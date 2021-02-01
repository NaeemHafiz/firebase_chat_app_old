import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/screens/user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          centerTitle: true, // this is all you need
          title: Text(Constant.USER_TABLE),
        ),
        backgroundColor: Colors.green,
        body: User(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
