import 'package:fisio_studio/components.dart';
import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:fisio_studio/models/data_paciente.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void deleteUser(context,
    {isFuncionario = false,
    isPaciente = false,
    DataFuncionario? dataFuncionario,
    DataPaciente? dataPaciente,
    changePage}) {
  // Check!
  if (isFuncionario == isPaciente)
    throw ('isFuncionario e isPacioente, ambos não podem ser iguais. Apenas um deve ser verdadeiro!');

  Alert(
      context: context,
      title:
          'Remover ${isFuncionario ? 'Funcionário: ' + (dataFuncionario!.name) : isPaciente ? 'Paciente: ' + (dataPaciente!.name) : ''}',
      desc:
          'Essa operação não pode ser desfeita, tem certeza que deseja continuar',
      content: isFuncionario
          ? _ContentDeleteFuncionario(
              dataFuncionario: dataFuncionario!,
            )
          : isPaciente
              ? _ContentDeletePaciente(dataPaciente: dataPaciente!)
              : Container(),
      style: AlertStyle(
        isCloseButton: false,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        descStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade700),
      ),
      buttons: [
        DialogButton(
          child: const Text('Remover',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onPressed: () {
            // Deletar funcionario ou paciente.
            Dio dio = Dio();

            String nome = 'ADM';
            String senha = 'senha12345';
            dio.options.headers['nome_de_usuario'] = nome;
            dio.options.headers['senha'] = senha;

            try {
              if (isFuncionario) {
                print('Excluindo funcionario de id: ${dataFuncionario!.id}');
                dio.delete(urlRequest['delete']['deleteFuncionario'], data: {
                  'id': dataFuncionario.id,
                });
                print(' Usuário excluido com sucesso!');
                Navigator.of(context).pop();
                if (changePage != null) {
                  changePage(0);
                }
              } else if (isPaciente) {
                print('Excluindo paciente de id: ${dataPaciente!.id}');
                dio.delete(urlRequest['delete']['deleteCliente'], data: {
                  'id': dataPaciente.id,
                });
                print('Usuário excluido com sucesso!');
                Navigator.of(context).pop();
                if (changePage != null) {
                  changePage(0);
                }
              } else {
                print(
                    'Não foi possivel concluir. Não é um funcionario nem um paciente.');
              }
            } catch (e) {
              print('Erro ao excluir um usuário.');
            }
          },
          color: Colors.red.shade300,
        ),
        DialogButton(
          child: const Text('Cancelar',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.blue,
        )
      ]).show();
}

class _ContentDeleteFuncionario extends StatelessWidget {
  final DataFuncionario dataFuncionario;
  _ContentDeleteFuncionario({Key? key, required this.dataFuncionario})
      : super(key: key);

  TextStyle style = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey)),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Nome: ${dataFuncionario.name}',
                  style: style,
                ),
                leading: const Icon(Icons.person),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'CPF: ${dataFuncionario.cpf}',
                  style: style,
                ),
                leading: const Icon(Icons.person_pin_rounded),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Previlégio: ${dataFuncionario.previlegio}',
                  style: style,
                ),
                leading: const Icon(Icons.star_rate_outlined),
              ))
        ],
      ),
    );
  }
}

class _ContentDeletePaciente extends StatelessWidget {
  final DataPaciente dataPaciente;
  _ContentDeletePaciente({Key? key, required this.dataPaciente})
      : super(key: key);

  TextStyle style = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey)),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Nome: ${dataPaciente.name}',
                  style: style,
                ),
                leading: const Icon(Icons.person),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'CPF: ${dataPaciente.cpf}',
                  style: style,
                ),
                leading: const Icon(Icons.person_pin_rounded),
              )),
        ],
      ),
    );
  }
}
