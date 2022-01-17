import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:fisio_studio/models/data_paciente.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

void visualization(context,
    {title,
    desc,
    isFuncionario = false,
    isPaciente = false,
    DataFuncionario? dataFuncionario,
    DataPaciente? dataPaciente}) {
  // Check!
  if (isFuncionario == isPaciente)
    throw ('isFuncionario e isPacioente, ambos não podem ser iguais. Apenas um deve ser verdadeiro!');

  Alert(
      context: context,
      title: isFuncionario
          ? 'Funcionário'
          : isPaciente
              ? 'Paciente'
              : '',
      content: isFuncionario
          ? _ContentVisualizationFuncionario(
              dataFuncionario: dataFuncionario!,
            )
          : _ContentVisualizationPaciente(
              dataPaciente: dataPaciente!,
            ),
      style:
          const AlertStyle(isCloseButton: false, backgroundColor: Colors.white),
      buttons: [
        DialogButton(
          child: const Text('Fechar',
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

class _ContentVisualizationFuncionario extends StatefulWidget {
  final DataFuncionario dataFuncionario;
  const _ContentVisualizationFuncionario(
      {Key? key, required this.dataFuncionario})
      : super(key: key);

  @override
  __ContentVisualizationFuncionarioState createState() =>
      __ContentVisualizationFuncionarioState();
}

class __ContentVisualizationFuncionarioState
    extends State<_ContentVisualizationFuncionario> {
  TextStyle style = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueGrey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Nome: ${widget.dataFuncionario.name}',
                  style: style,
                ),
                leading: const Icon(Icons.person),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Endereço: ${widget.dataFuncionario.adress}',
                  style: style,
                ),
                leading: const Icon(Icons.home),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Nascimento: ${widget.dataFuncionario.birthDate}',
                  style: style,
                ),
                leading: const Icon(Icons.date_range),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Telefone: ${widget.dataFuncionario.phone}',
                  style: style,
                ),
                leading: const Icon(Icons.phone),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'CPF: ${widget.dataFuncionario.cpf}',
                  style: style,
                ),
                leading: const Icon(Icons.person_pin_rounded),
              )),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                title: Text(
                  'Previlégio: ${widget.dataFuncionario.previlegio}',
                  style: style,
                ),
                leading: const Icon(Icons.star_rate_outlined),
              ))
        ],
      ),
    );
  }
}

class _ContentVisualizationPaciente extends StatefulWidget {
  final DataPaciente dataPaciente;
  const _ContentVisualizationPaciente({Key? key, required this.dataPaciente})
      : super(key: key);

  @override
  __ContentVisualizationPacienteState createState() =>
      __ContentVisualizationPacienteState();
}

class __ContentVisualizationPacienteState
    extends State<_ContentVisualizationPaciente> {
  TextStyle style = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(
                'Nome: ${widget.dataPaciente.name}',
                style: style,
              ),
              leading: const Icon(Icons.person),
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(
                'Endereço: ${widget.dataPaciente.adress}',
                style: style,
              ),
              leading: Icon(Icons.home),
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(
                'Nascimento: ${widget.dataPaciente.birthDate}',
                style: style,
              ),
              leading: const Icon(Icons.date_range),
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(
                'Telefone: ${widget.dataPaciente.phone}',
                style: style,
              ),
              leading: const Icon(Icons.phone),
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(
                'CPF: ${widget.dataPaciente.cpf}',
                style: style,
              ),
              leading: const Icon(Icons.person_pin_rounded),
            )),
      ],
    );
  }
}
