import 'package:fisio_studio/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'views/login.dart';

void main() {
  runApp(const InitApp());
}

class InitApp extends StatefulWidget {
  const InitApp({ Key? key }) : super(key: key);

  @override
  InitAppState createState() => InitAppState();
}

class InitAppState extends State<InitApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}