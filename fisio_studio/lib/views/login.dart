import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/views/splash_page.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
                      children: const[
                        Expanded(
                          child: LogoBox(),
                        )
                      ],
                    )
                  ),
                  const Expanded(
                    flex: 6,
                    child: AutenticatorBox()
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}



class AutenticatorBox extends StatelessWidget {
  const AutenticatorBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: CustomTextFiled(
                    hintText: 'Usuário',
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: CustomTextFiled(
                    hintText: 'Senha',
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  child: CustomButtom(
                    label: 'Acessar',
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: const Duration(seconds: 2),
                      pageBuilder: (_, __, ___) => const SplashPage()));
                    }
                  ),
                )
              ],
            ),
          )
        )
      ],
    );
  }
}



class LogoBox extends StatelessWidget {
  const LogoBox({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black26,
      ),
      child: Hero(
        tag: 'titleLogo',
        child: Image.asset(
              "images/logo_title.png"),
      ),
    );
  }
}