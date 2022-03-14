import 'package:fisio_studio/widgets/delete.dart';
import 'package:fisio_studio/controllers/getFuncionarios.dart';
import 'package:fisio_studio/controllers/visualization.dart';
import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ListFuncionarios extends StatefulWidget {
  final changePage;
  const ListFuncionarios({Key? key, required this.changePage})
      : super(key: key);

  @override
  State<ListFuncionarios> createState() => _ListFuncionariosState();
}

class _ListFuncionariosState extends State<ListFuncionarios> {
  List<CardFuncionario> cards = [];
  int page = 0;
  int pageSize = 10;
  bool isfreeze = true;

  buildTable() async {
    try {
      dynamic data = await getFuncionarios(page: page, pageSize: pageSize);
      print('Data: ${data}');
      List<dynamic> rows = data['rows'];

      int position = 1;

      rows.forEach((element) {
        print('CPF: ${element['CPF']}');

        DataFuncionario dataFuncionario = DataFuncionario(
            element['id'],
            element['nome_de_usuario'],
            element['endereco'],
            element['data_de_nascimento'],
            element['telefone'],
            element['CPF'],
            element['profissao'],
            element['privilegio']);

        setState(() {
          cards.add(CardFuncionario(
            dataFuncionario: dataFuncionario,
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
              const HeadFuncionarios(),
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

class HeadFuncionarios extends StatelessWidget {
  const HeadFuncionarios({Key? key}) : super(key: key);

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
          Expanded(
            child: Text(
              'Privilégio',
              style: style,
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class CardFuncionario extends StatelessWidget {
  final DataFuncionario dataFuncionario;
  final int pos;
  final changePage;

  const CardFuncionario(
      {Key? key,
      required this.dataFuncionario,
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
                      dataFuncionario.cpf,
                      style: style,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      dataFuncionario.name,
                      style: style,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      dataFuncionario.previlegio.toString(),
                      style: style,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          visualization(context,
                              isFuncionario: true,
                              dataFuncionario: dataFuncionario);
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
                            1,
                            isFuncionario: true,
                            isEdt: true,
                            dtFuncionario: dataFuncionario,
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
                              isFuncionario: true,
                              dataFuncionario: dataFuncionario,
                              changePage: changePage);
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
