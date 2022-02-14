import 'package:fisio_studio/components.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';

class DeleteButton extends StatelessWidget {
  final dynamic type;
  final int idRemove;
  //funcionario, paciente e consulta.
  DeleteButton({Key? key, this.type = 'funcionario', this.idRemove = -1})
      : super(key: key);

  void delete(int id) {
    // Deletar funcionario ou paciente.
    Dio dio = Dio();

    if (id == -1) {
      print('ID inválido!');
      return;
    }

    String nome = 'ADM';
    String senha = 'senha12345';
    dio.options.headers['nome_de_usuario'] = nome;
    dio.options.headers['senha'] = senha;

    print('Chegamos aqui: $id');
    try {
      if (type == 'funcionario') {
        print('Excluindo funcionario de id: ${id}');
        dio.delete(urlRequest['delete']['deleteFuncionario'], data: {
          'id': id,
        });
        print(' Usuário excluido com sucesso!');
      } else if (type == 'paciente') {
        print('Excluindo paciente de id: ${id}');
        dio.delete(urlRequest['delete']['deleteCliente'], data: {
          'id': id,
        });
        print('Usuário excluido com sucesso!');
      } else if (type == 'consulta') {
        print('Excluindo consulta de id: ${id}');
        dio.delete(urlRequest['delete']['deleteConsulta'], data: {
          'id': id,
        });
        print('Consulta excluido com sucesso!');
      } else {
        print(
            'Não foi possivel concluir. Não é um funcionario nem um paciente.');
      }
    } catch (e) {
      print('Erro ao excluir um usuário.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Alert(
            context: context,
            title: type == 'consulta'
                ? 'Tem certeza que deseja excluir essa consulta?'
                : 'Tem certeza que deseja excluir esse usuário?',
            desc: 'Essa ação não poderá ser desfeita',
            style: AlertStyle(
                isCloseButton: false,
                descStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900),
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            buttons: [
              DialogButton(
                color: Colors.blue.shade900,
                child: const Text(
                  "Tenho certeza!",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  delete(idRemove);
                },
              ),
              DialogButton(
                color: Colors.red.shade900,
                child: const Text(
                  "Não tenho certeza!",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]).show();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red[300]!),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: const Icon(
          Icons.delete_forever,
          color: Colors.red,
        ),
      ),
    );
  }
}
