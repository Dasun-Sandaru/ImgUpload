import 'package:flutter/material.dart';
import 'package:imgupload/models/loginData.dart';
import 'package:imgupload/screens/fiveImg_screen.dart';
import 'package:imgupload/screens/login.dart';

import 'screens/upload_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

