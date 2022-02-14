import 'package:fisio_studio/controllers/cadastroClienteFuncionario.dart';
import 'package:fisio_studio/models/data_paciente.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:fisio_studio/widgets/delete_button.dart';
import 'package:flutter/material.dart';

class CadastroPaciente extends StatefulWidget {
  final DataPaciente? dataPaciente;
  final bool isEditPage;

  const CadastroPaciente({Key? key, this.isEditPage = false, this.dataPaciente})
      : super(key: key);

  @override
  State<CadastroPaciente> createState() => _CadastroPacienteState();
}

class _CadastroPacienteState extends State<CadastroPaciente> {
  String? name;
  String? adress;
  String? date;
  String? phone;
  String? cpf;

  void updateName(name) {
    setState(() => this.name = name);
  }

  void updateAdress(adress) {
    setState(() => this.adress = adress);
  }

  void updateDate(date) {
    setState(() => this.date = date);
  }

  void updatePhone(phone) {
    setState(() => this.phone = phone);
  }

  void updateCPF(cpf) {
    setState(() => this.cpf = cpf);
  }

  void sendData() {
    //TODO: Realizar uma validação dos dados antes de enviar...

    //Enviar os dados para o servidor.

    Map<String, dynamic> dataPaciente = {
      'nome': name,
      'endereco': adress,
      'data_de_nascimento': date,
      'inicio_na_empresa': '11/12/2020',
      'telefone': phone,
      'CPF': cpf,
      'privilegio': 'Gerente'
    };

    if (!widget.isEditPage) {
      cadastrarClienteFuncionario(dataPaciente, 'cadastroCliente');
    }
    //cadastrarClienteFuncionario(dataFuncionario, '/funcionario');
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
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit:
                              widget.isEditPage && widget.dataPaciente != null
                                  ? widget.dataPaciente!.name
                                  : '',
                          hintText: 'Nome paciente',
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onChanged: updateName,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit:
                              widget.isEditPage && widget.dataPaciente != null
                                  ? widget.dataPaciente!.birthDate
                                  : '',
                          hintText: 'Data de Nascimento',
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white,
                          ),
                          onChanged: updateDate,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit:
                              widget.isEditPage && widget.dataPaciente != null
                                  ? widget.dataPaciente!.phone
                                  : '',
                          hintText: 'Telefone',
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          onChanged: updatePhone,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit:
                              widget.isEditPage && widget.dataPaciente != null
                                  ? widget.dataPaciente!.cpf
                                  : '',
                          hintText: 'Documento CPF',
                          icon: const Icon(Icons.contacts, color: Colors.white),
                          onChanged: updateCPF,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 30),
                        child: CustomTextFiled(
                          labelInit:
                              widget.isEditPage && widget.dataPaciente != null
                                  ? widget.dataPaciente!.adress
                                  : '',
                          hintText: 'Endereço',
                          icon: const Icon(
                            Icons.work,
                            color: Colors.white,
                          ),
                          onChanged: updateAdress,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtom(
                            label: widget.isEditPage ? 'Editar' : 'Cadastrar',
                            onPressed: sendData,
                          ),
                          widget.isEditPage
                              ? DeleteButton(
                                  idRemove: widget.dataPaciente!.id,
                                  type: 'paciente',
                                )
                              : Container(),
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
