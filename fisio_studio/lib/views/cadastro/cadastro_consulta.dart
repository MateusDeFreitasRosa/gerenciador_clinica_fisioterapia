import 'package:fisio_studio/controllers/cadastroConsulta.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

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

  dynamic _convert(date) {
    dynamic dateList = date.toIso8601String().split('T');
    dateList[1] = dateList[1].split('.')[0];
    return dateList.join(' ');
  }

  void _send() {
    DateTime start = DateTime(widget.dateTime.year, widget.dateTime.month,
        widget.dateTime.day, timeOfDayStart.hour, timeOfDayStart.minute);

    DateTime end = DateTime(widget.dateTime.year, widget.dateTime.month,
        widget.dateTime.day, timeOfDayEnd.hour, timeOfDayEnd.minute);

    Map<String, dynamic> obj = {
      'pacienteCPF': cpfPaciente,
      'funcionarioCPF': cpfProfissional,
      'tipo': tipoConsulta,
      'inicio': _convert(start),
      'fim': _convert(end),
      'valor': valorConsulta,
    };
    cadastrarConsulta(obj, 'cadastroConsulta');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
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
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(vertical: 10),
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
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          hintText: 'Tipo Consulta',
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onChanged: (value) {
                            tipoConsulta = value;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          hintText: 'Valor consulta',
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onChanged: (String value) {
                            valorConsulta =
                                double.parse(value.replaceAll(',', '.'));
                          },
                        ),
                      ),
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
            ),
          )
        ],
      ),
    );
  }
}
