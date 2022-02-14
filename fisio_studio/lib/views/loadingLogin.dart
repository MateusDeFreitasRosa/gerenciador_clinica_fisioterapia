import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/views/home_screen.dart';
import 'package:fisio_studio/views/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:dio/dio.dart';

class SplashPage extends StatefulWidget {
  final String username;
  final String password;
  const SplashPage({Key? key, this.password = '', this.username = ''})
      : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void nextpage() {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (_, __, ___) => const HomePage()));
  }

  void previouspage() {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (_, __, ___) => const LoginPage()));
  }

  Future<bool> login(String username, String password) async {
    print('Tentando logar');
    print('Username: $username\nSenha: $password');
    if (username != '' && password != '') {
      //403 error
      //200 liberado!

      var dio = Dio();

      try {
        dio.options.headers['nome_de_usuario'] = username;
        dio.options.headers['senha'] = password;

        final response = await dio.get(urlRequest['get']['login']);

        if (response.statusCode! < 300) {
          return true;
        }
      } catch (e) {
        if (e is DioError) {
          print('Error no login? $e');
        }
        return false;
      }
    }
    return false;
  }

  void requestLogin() async {
    print('Requisitando login');
    if (await login(widget.username, widget.password)) {
      nextpage();
    } else {
      previouspage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestLogin();
  }

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
                        constraints:
                            BoxConstraints(maxHeight: 100, minHeight: 50),
                        child: Lottie.asset('assets/loading.json'),
                      )
                    ],
                  ),
                  color: Colors.black26,
                )))
      ],
    ));
  }
}
