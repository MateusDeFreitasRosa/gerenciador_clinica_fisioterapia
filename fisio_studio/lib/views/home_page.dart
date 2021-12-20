import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:fisio_studio/models/data_paciente.dart';
import 'package:fisio_studio/views/cadastro_funcionario.dart';
import 'package:fisio_studio/views/cadastro_paciente.dart';
import 'package:fisio_studio/widgets/CustomButtonDrawer.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<int, Map<String, dynamic> > pages = {
    0: {
      'name': 'Tela Inicial',
    },
    1: {
      'name': 'Cadastrar Funcionários',
    },
    2: {
      'name': 'Cadastrar Pacientes',
    },
  };

  int currentPage=0;


  void changeScreen(int idPage) {
    if(pages.containsKey(idPage)) {
      setState(() => currentPage = idPage);
    }
  }

  final DataFuncionario dataFuncionario = DataFuncionario('Mateus', 'Rua rua', '14/15/20', '3488888', '121244545', 'Recepcionista');
  final DataPaciente dataPaciente = DataPaciente('Mateus', 'Rua rua', '14/15/20', '3488888', '121244545');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pages[currentPage]!['name']
        ),
        backgroundColor: Colors.black87,
        elevation: 4,
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                
                CustomButtomDrawer(
                  label: pages[1]!['name']!,
                  onPressed: () {
                    changeScreen(1);
                  },
                ),

                CustomButtomDrawer(
                  label: pages[2]!['name']!,
                  onPressed: () {
                    changeScreen(2);
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: backgroundApp,
        child: Column(
          children: [
            Expanded(
              child: currentPage == 0
              ? const Scaffold(backgroundColor: Colors.amber,)
              : currentPage == 1 
              ? CadastroFuncionario(isEditPage: true, dataFuncionario: dataFuncionario,)
              : currentPage == 2 
              ? CadastroPaciente(isEditPage: true, dataPaciente: dataPaciente,)
              : const Scaffold(backgroundColor: Colors.purple,)
            )
          ],
        ),
      ),
    );
  }
}