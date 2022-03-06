import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/controllers/getClienteAniversariante.dart';
import 'package:fisio_studio/widgets/custom_card_birthday.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  List<CustomCardBirthday> cardsBirthDay = [];
  bool freezeScreen = false;

  void getAniversariantes() async {
    try {
      setState(() => freezeScreen = true);
      print('Cadastro');
      DateTime dateTime = DateTime.now();
      //DateTime dateTimeEnd = DateTime.now().add(const Duration(days: 2));
      int mes = dateTime.month;
      int dia = dateTime.day;

      dynamic aniversariantes =
          await getClienteAniversariante(mes: mes, dia: dia);

      for (var element in aniversariantes['rows']) {
        cardsBirthDay.add(CustomCardBirthday(
            date: DateTime.parse(element['data_de_nascimento']),
            pacienteName: element['nome']));
      }
      setState(() => cardsBirthDay);
      print('Aniversariantes: $aniversariantes');
    } catch (e) {
      print(e);
    } finally {
      setState(() => freezeScreen = false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAniversariantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: freezeScreen,
          child: Column(
            children: [
              Expanded(
                flex: 75,
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
              ),
              const Expanded(
                flex: 10,
                child: IntrinsicHeight(
                  child: Text(
                    'Aniversariantes',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              freezeScreen
                  ? Expanded(
                      flex: 15,
                      child: Container(),
                    )
                  : cardsBirthDay.isEmpty
                      ? const Expanded(
                          flex: 15,
                          child: Center(
                            child: Text(
                              'Não há aniversariantes hoje!',
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ))
                      : Expanded(
                          flex: 15,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: cardsBirthDay))
            ],
          ),
        ));
  }
}
