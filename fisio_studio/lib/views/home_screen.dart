import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:fisio_studio/models/data_paciente.dart';
import 'package:fisio_studio/views/aquisicao_creditos.dart';
import 'package:fisio_studio/views/cadastro/cadastro_consulta.dart';
import 'package:fisio_studio/views/cadastro/cadastro_funcionario.dart';
import 'package:fisio_studio/views/cadastro/cadastro_paciente.dart';
import 'package:fisio_studio/views/listagem/listar_funcionarios.dart';
import 'package:fisio_studio/views/listagem/listar_pacientes.dart';
import 'package:fisio_studio/views/tela_inicial.dart';
import 'package:fisio_studio/views/view_consulta.dart';
import 'package:fisio_studio/widgets/custom_calendar.dart';
import 'package:fisio_studio/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:fisio_studio/models/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController expanded;
  late Animation<double> animation;
  bool isExpanded = false;

  int currentPage = 0;

  bool editFuncionario = false;
  bool editPaciente = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    expanded = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        lowerBound: 0);
    animation = CurvedAnimation(
      parent: expanded,
      curve: Curves.fastOutSlowIn,
    );
    _showFilter();
  }

  bool isEdit = false;
  DataFuncionario dataFuncionario = DataFuncionario(1, 'Mateus', 'Rua rua',
      '14/15/20', '3488888', '121244545', 'Recepcionista', 1);
  DataPaciente dataPaciente =
      DataPaciente(1, 'Mateus', 'Rua rua', '14/15/20', '3488888', '121244545');

  Map<String, dynamic> kwards = {};
  void changePage(int idPage,
      {isFuncionario = false,
      isPaciente = false,
      isEdt = false,
      DataFuncionario? dtFuncionario,
      DataPaciente? dtPaciente,
      dynamic kwd}) {
    print('Change page: $idPage');
    if (pages.containsKey(idPage)) {
      if (kwd != null) {
        setState(() => kwards = kwd);
      }
      setState(() => currentPage = idPage);

      if ([1, 2].contains(currentPage) && isEdt) {
        isEdit = isEdt;
        if (isFuncionario && dtFuncionario != null) {
          dataFuncionario = dtFuncionario;
        } else if (isPaciente && dtPaciente != null) {
          dataPaciente = dtPaciente;
        }
      }
    }
  }

  _showFilter() {
    if (!isExpanded) {
      print('forward');
      expanded.forward();
    } else {
      print('reverse');
      expanded.reverse();
    }
  }

  Widget buildMiddleScren() {
    bool isEdt = isEdit;
    DataFuncionario dtFunc = dataFuncionario;
    DataPaciente dtPac = dataPaciente;

    print('B - ${isEdt}');

    isEdit = false;

    print('A - ${isEdt}');

    return currentPage == 0
        ? const InitScreen()
        : currentPage == 1
            ? CadastroFuncionario(
                isEditPage: isEdt,
                dataFuncionario: dataFuncionario,
                changePage: changePage,
              )
            : currentPage == 2
                ? CadastroPaciente(
                    isEditPage: isEdt,
                    dataPaciente: dataPaciente,
                    changePage: changePage,
                  )
                : currentPage == 3
                    ? ListFuncionarios(
                        changePage: changePage,
                      )
                    : currentPage == 4
                        ? ListPaciente(
                            changePage: changePage,
                          )
                        : currentPage == 5
                            ? CustomCalendar(
                                changePage: changePage,
                              )
                            : currentPage == 6
                                ? CadastroConsulta(
                                    dateTime: kwards['dateTime'],
                                  )
                                : currentPage == 7
                                    ? ViewConsulta(
                                        cpfFuncionario:
                                            kwards['cpfFuncionario'] ?? '',
                                        cpfPaciente:
                                            kwards['cpfPaciente'] ?? '',
                                        descConsulta:
                                            kwards['descConsulta'] ?? '',
                                        descPaciente:
                                            kwards['descPaciente'] ?? '',
                                        tipoConsulta:
                                            kwards['tipoConsulta'] ?? '',
                                        nomeFuncionario:
                                            kwards['nomeFuncionario'] ?? '',
                                        nomePaciente:
                                            kwards['nomePaciente'] ?? '',
                                        id: kwards['id'] ?? '',
                                        startConsulta: kwards['inicio'] ?? '',
                                        endConsulta: kwards['fim'] ?? '',
                                        changePage: changePage,
                                      )
                                    : currentPage == 8
                                        ? const BuyCredits()
                                        : const Scaffold(
                                            backgroundColor: Colors.purple,
                                          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() => isExpanded = !isExpanded);
              _showFilter();
              print('Expande: $expanded');
            },
            padding: const EdgeInsets.only(right: 15),
            autofocus: false,
            alignment: Alignment.center,
            iconSize: 25,
            icon: const Icon(
              Icons.list,
              //color: LightTheme.textColorDarkBlueGrey,
            ),
          ),
          title: Text(pages[currentPage]!['name']),
          backgroundColor: Colors.black87,
          elevation: 4,
          centerTitle: true,
        ),
        body: Container(
          decoration: backgroundApp,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizeTransition(
                  axis: Axis.horizontal,
                  sizeFactor: animation,
                  child: CustomTabBar(
                    changePage: changePage,
                  )),
              Expanded(child: buildMiddleScren())
            ],
          ),
        ));
  }
}
