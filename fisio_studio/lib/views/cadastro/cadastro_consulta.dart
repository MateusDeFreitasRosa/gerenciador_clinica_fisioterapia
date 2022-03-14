import 'package:fisio_studio/controllers/cadastroConsulta.dart';
import 'package:fisio_studio/controllers/getCredits.dart';
import 'package:fisio_studio/controllers/sharedPreference.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CadastroConsulta extends StatefulWidget {
  final DateTime dateTime;
  const CadastroConsulta({Key? key, required this.dateTime}) : super(key: key);

  @override
  _CadastroConsultaState createState() => _CadastroConsultaState();
}

class _CadastroConsultaState extends State<CadastroConsulta> {
  late TimeOfDay timeOfDayStart;
  late TimeOfDay timeOfDayEnd;
  String cpfProfissional = '';
  String cpfPaciente = '';
  String tipoConsulta = '';
  double valorConsulta = 0;
  List<String> services = [];
  List<int> servicesAmmout = [];
  int ammoutService = 0;
  bool pacientExists = false;
  bool freezeScreen = false;

  dynamic _convert(date) {
    dynamic dateList = date.toIso8601String().split('T');
    dateList[1] = dateList[1].split('.')[0];
    return dateList.join(' ');
  }

  void _send() async {
    try {
      setState(() => freezeScreen = true);
      DateTime start = DateTime(widget.dateTime.year, widget.dateTime.month,
          widget.dateTime.day, timeOfDayStart.hour, timeOfDayStart.minute);

      DateTime end = DateTime(widget.dateTime.year, widget.dateTime.month,
          widget.dateTime.day, timeOfDayEnd.hour, timeOfDayEnd.minute);

      DateTime hoje = DateTime.now();

      Map<String, dynamic> obj = {
        'pacienteCPF': cpfPaciente,
        'funcionarioCPF': cpfProfissional,
        'tipo': _chosenValue,
        'inicio': _convert(start),
        'fim': _convert(end),
        'hoje': '${hoje.year}-${hoje.month}-${hoje.day}'
        //'valor': valorConsulta,
      };
      dynamic response = await cadastrarConsulta(obj, 'cadastroConsulta');
      print('Data: ${response.data}');
      print('StatusCode: ${response.statusCode}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Alert(
            context: context,
            title: 'Sucesso',
            content: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 75,
            ),
            style: const AlertStyle(
              isCloseButton: false,
            ),
            buttons: [
              DialogButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Okay!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ))
            ]).show();
      } else {
        Alert(
            context: context,
            title: response.data['message'],
            content: const Icon(
              Icons.close_rounded,
              color: Colors.red,
              size: 75,
            ),
            style: const AlertStyle(
              isCloseButton: false,
            ),
            buttons: [
              DialogButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Okay!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ))
            ]).show();
      }
    } catch (e) {
      print('Erro cadastro de consulta: $e');
    } finally {
      setState(() => freezeScreen = false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('Horário pego: ${widget.dateTime}');
    timeOfDayStart =
        TimeOfDay(hour: widget.dateTime.hour, minute: widget.dateTime.minute);

    timeOfDayEnd = TimeOfDay(
        hour: widget.dateTime.hour + 1, minute: widget.dateTime.minute);
    //getServices();
  }

  void setTimePickerStart() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeOfDayStart,
    );
    if (picked != null) {
      setState(() {
        timeOfDayStart = TimeOfDay(hour: picked.hour, minute: picked.minute);
      });
    }
  }

  void setTimePickerEnd() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeOfDayEnd,
    );
    if (picked != null) {
      setState(() {
        timeOfDayEnd = TimeOfDay(hour: picked.hour, minute: picked.minute);
      });
    }
  }

  void _getCredits() async {
    dynamic credits = await getCredits(pacienteCPF: cpfPaciente);

    setState(() {
      if (credits is Map) {
        pacientExists = false;
      } else {
        pacientExists = true;

        for (var cdts in credits) {
          if (services.contains(cdts['tipo'])) {
            servicesAmmout[services.indexOf(cdts['tipo'])] +=
                int.parse(cdts['quantidade'].toString());
          } else {
            services.add(cdts['tipo']);
            servicesAmmout.add(cdts['quantidade']);
          }
        }
      }
    });
  }

  void getServices() async {
    dynamic serv = await loadSharedPreference('services');

    services = [];
    for (var sv in serv) {
      setState(() {
        services.add(sv['tipo']);
      });
    }
  }

  String? _chosenValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: freezeScreen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                '${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Horário de entrada: ${timeOfDayStart.hour} : ${timeOfDayStart.minute}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setTimePickerStart();
                                    },
                                    child: Material(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 5,
                                      child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.alarm_sharp,
                                            size: 32,
                                            color: Colors.white,
                                          )),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  elevation: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade800,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'Horário de saída: ${timeOfDayEnd.hour} : ${timeOfDayEnd.minute}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      setTimePickerEnd();
                                    },
                                    child: Material(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 5,
                                      child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.alarm_sharp,
                                            size: 32,
                                            color: Colors.white,
                                          )),
                                    )),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFiled(
                                hintText: 'CPF Paciente',
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                onChanged: (value) {
                                  cpfPaciente = value;
                                  if (cpfPaciente.length == 11) {
                                    _getCredits();
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextFiled(
                                hintText: 'CPF Profissional',
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                onChanged: (value) {
                                  cpfProfissional = value;
                                },
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.symmetric(vertical: 10),
                            //   child: CustomTextFiled(
                            //     hintText: 'Tipo Consulta',
                            //     icon: const Icon(
                            //       Icons.person,
                            //       color: Colors.white,
                            //     ),
                            //     onChanged: (value) {
                            //       tipoConsulta = value;
                            //     },
                            //   ),
                            // ),
                            // Container(
                            //   margin: const EdgeInsets.symmetric(vertical: 10),
                            //   child: CustomTextFiled(
                            //     hintText: 'Quantidade de horários',
                            //     icon: const Icon(
                            //       Icons.person,
                            //       color: Colors.white,
                            //     ),
                            //     onChanged: (String value) {
                            //       valorConsulta =
                            //           double.parse(value.replaceAll(',', '.'));
                            //     },
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButtom(
                                  label: 'Cadastrar',
                                  onPressed: () {
                                    _send();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              pacientExists && cpfPaciente.length == 11 && services.isEmpty
                  ? Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Paciente sem Créditos!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    )
                  : !pacientExists
                      ? Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            'Paciente não existe!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      : IntrinsicHeight(
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(7)),
                                  padding: const EdgeInsets.all(2),
                                  child: DropdownButton<String>(
                                    focusColor: Colors.white,
                                    value: _chosenValue,
                                    //elevation: 5,
                                    style: const TextStyle(color: Colors.white),
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: Colors.black54,
                                    items: services
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      "Escolha o tipo do serviço",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenValue = value;
                                        ammoutService = servicesAmmout[
                                            services.indexOf(_chosenValue!)];
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  padding: const EdgeInsets.all(7),
                                  margin: const EdgeInsets.all(10),
                                  child:
                                      Text('Você tem $ammoutService créditos'),
                                )
                              ],
                            ),
                          ),
                        )
            ],
          ),
        ));
  }
}
