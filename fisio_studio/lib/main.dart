import 'package:fisio_studio/views/home_screen.dart';
import 'package:fisio_studio/views/login.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';

void main() {
  runApp(const InitApp());
}

class InitApp extends StatefulWidget {
  const InitApp({Key? key}) : super(key: key);

  @override
  InitAppState createState() => InitAppState();
}

class InitAppState extends State<InitApp> {
  void setSizeScreen() async {
    Size size = await DesktopWindow.getWindowSize();
    await DesktopWindow.setWindowSize(const Size(1280, 720));

    await DesktopWindow.setMinWindowSize(const Size(1280, 720));
    await DesktopWindow.setMaxWindowSize(const Size(1920, 1080));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSizeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
