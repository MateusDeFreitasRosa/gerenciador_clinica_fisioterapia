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
      this.id = -1,
      this.changePage})
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

  dynamic changePage;

  final dynamic style = const TextStyle(
    color: Colors.white70,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                                    startConsulta.toString(),
                                    style: style,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    endConsulta.toString(),
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
                            changePage: changePage,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
              // Positioned(
              //     right: 0,
              //     top: 0,
              //     child: TextButton(
              //       onPressed: () {},
              //       child: IntrinsicHeight(
              //         child: Container(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 5, horizontal: 12),
              //           decoration: BoxDecoration(
              //               color: Colors.blue.shade400,
              //               border: Border.all(color: Colors.blue, width: 3),
              //               borderRadius:
              //                   const BorderRadius.all(Radius.circular(10))),
              //           child: const Icon(
              //             Icons.edit,
              //             color: Colors.white,
              //             size: 30,
              //           ),
              //         ),
              //       ),
              //     )),
            ],
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text(
          //       'Anotações sobre a consulta',
          //       style: TextStyle(color: Colors.white, fontSize: 20),
          //     ),
          //     Container(
          //       constraints: const BoxConstraints(
          //           maxHeight: 500,
          //           minHeight: 300,
          //           maxWidth: 700,
          //           minWidth: 350),
          //       width: 200,
          //       height: 200,
          //       child: const TextField(
          //         minLines: 10,
          //         maxLines: 20,
          //         decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.white, width: 2.0),
          //           ),
          //           border: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.white, width: 2.0),
          //           ),
          //         ),
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Salvar',
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //       style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all(Colors.blue),
          //           padding:
          //               MaterialStateProperty.all(const EdgeInsets.all(20))),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
