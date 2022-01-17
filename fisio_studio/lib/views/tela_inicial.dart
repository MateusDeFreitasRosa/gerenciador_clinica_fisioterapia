import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/views/login.dart';
import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: backgroundApp,
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: 'titleLogo',
                                child: Image.asset("images/logo_title.png"),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
