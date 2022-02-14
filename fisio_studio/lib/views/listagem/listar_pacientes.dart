import 'package:fisio_studio/widgets/delete.dart';
import 'package:fisio_studio/controllers/getPaciente.dart';
import 'package:fisio_studio/controllers/visualization.dart';
import 'package:fisio_studio/models/data_paciente.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ListPaciente extends StatefulWidget {
  final changePage;
  const ListPaciente({Key? key, required this.changePage}) : super(key: key);

  @override
  State<ListPaciente> createState() => _ListPacienteState();
}

class _ListPacienteState extends State<ListPaciente> {
  List<CardPaciente> cards = [];
  int page = 0;
  int pageSize = 10;
  bool isfreeze = true;

  buildTable() async {
    try {
      dynamic data = await getPaciente(page: page, pageSize: pageSize);
      print('Data: ${data}');
      List<dynamic> rows = data['rows'];

      int position = 1;
      rows.forEach((element) {
        print('CPF: ${element['CPF']}');
        setState(() {
          cards.add(CardPaciente(
            dataPaciente: DataPaciente(
                element['id'] ?? '',
                element['nome'] ?? 'Sem nome',
                element['endereco'] ?? 'Sem endereço',
                element['data_de_nascimento'] ?? '2000-01-01',
                element['telefone'] ?? '(XX) X XXXX-XXXX',
                element['CPF'] ?? 'XXX-XXX-XXX.XX'),
            pos: position,
            changePage: widget.changePage,
          ));
        });
        position++;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => isfreeze = false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    buildTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: isfreeze,
          child: Column(
            children: [
              const HeadPaciente(),
              Expanded(
                child: cards.length == 0
                    ? Container()
                    : ListView(
                        children: cards,
                      ),
              )
            ],
          ),
        ));
  }
}

class HeadPaciente extends StatelessWidget {
  const HeadPaciente({Key? key}) : super(key: key);

  final TextStyle style = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Text(
            'CPF',
            style: style,
          )),
          Expanded(
            child: Text(
              'Nome',
              style: style,
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class CardPaciente extends StatelessWidget {
  final DataPaciente dataPaciente;
  final int pos;
  final changePage;
  const CardPaciente(
      {Key? key,
      required this.dataPaciente,
      required this.pos,
      required this.changePage})
      : super(key: key);

  final TextStyle style = const TextStyle(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: pos % 2 == 0 ? Colors.black12 : Colors.black26,
        child: InkWell(
          onTap: () {
            print('Tap Here');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      dataPaciente.cpf,
                      style: style,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      dataPaciente.name,
                      style: style,
                    ),
                  ),
                ),
                // Expanded(
                //   child: Container(
                //     child: Text(
                //       previlegio.toString(),
                //       style: style,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          visualization(context,
                              isPaciente: true, dataPaciente: dataPaciente);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius: BorderRadius.circular(2)),
                          child: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changePage(
                            2,
                            isPaciente: true,
                            isEdt: true,
                            dtPaciente: dataPaciente,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(2)),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          deleteUser(context,
                              isPaciente: true, dataPaciente: dataPaciente);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red.shade200,
                              borderRadius: BorderRadius.circular(2)),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
