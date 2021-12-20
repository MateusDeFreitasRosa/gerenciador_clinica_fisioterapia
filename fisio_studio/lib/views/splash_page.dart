import 'package:fisio_studio/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: backgroundApp,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'titleLogo',
                        child: Image.asset("images/logo_title.png"),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 100, minHeight: 50),
                      child: Lottie.asset('assets/loading.json'),
                    )
                  ],
                ),
                color: Colors.black26,
              )
            )
          )
        ],
      )
    );
  }
}