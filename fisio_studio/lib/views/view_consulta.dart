import 'package:fisio_studio/widgets/delete_button.dart';
import 'package:flutter/material.dart';

class ViewConsulta extends StatelessWidget {
  ViewConsulta(
      {Key? key,
      this.cpfFuncionario = '',
      this.cpfPaciente = '',
      this.nomeFuncionario = '',
      this.nomePaciente = '',
      this.espcFuncionario = '',
      this.descPaciente = '',
      this.descConsulta = '',
      this.endConsulta = '',
      this.startConsulta = '',
      this.tipoConsulta = '',
      this.id = -1})
      : super(key: key);

  String cpfPaciente;
  String nomePaciente;
  String descPaciente;

  String cpfFuncionario;
  String nomeFuncionario;
  String espcFuncionario;

  String tipoConsulta;
  String descConsulta;
  String startConsulta;
  String endConsulta;
  int id;

  final dynamic style = const TextStyle(
    color: Colors.white70,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dados da consulta',
                  style: TextStyle(
                      color: Colors.blueGrey.shade200,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Paciente',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      IntrinsicWidth(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cpfPaciente,
                              style: style,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              nomePaciente,
                              style: style,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        descPaciente,
                        style: style,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Profissional',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      IntrinsicWidth(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cpfFuncionario,
                              style: style,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            Text(
                              nomeFuncionario,
                              style: style,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        espcFuncionario,
                        style: style,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Consulta',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      IntrinsicWidth(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tipoConsulta,
                              style: style,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              nomeFuncionario,
                              style: style,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        descConsulta,
                        style: style,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Período consulta',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      IntrinsicWidth(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '05/02/2022',
                              style: style,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '8:00 às 9:00',
                              style: style,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IntrinsicWidth(
                    child: Row(
                  children: [
                    DeleteButton(
                      type: 'consulta',
                      idRemove: id,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
