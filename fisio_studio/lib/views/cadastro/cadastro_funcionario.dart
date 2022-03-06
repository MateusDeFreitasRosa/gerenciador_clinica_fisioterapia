import 'package:fisio_studio/controllers/cadastroClienteFuncionario.dart';
import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:fisio_studio/widgets/delete_button.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CadastroFuncionario extends StatefulWidget {
  final DataFuncionario? dataFuncionario;
  final bool isEditPage;
  CadastroFuncionario({Key? key, this.dataFuncionario, this.isEditPage = false})
      : super(key: key);

  @override
  _CadastroFuncionarioState createState() => _CadastroFuncionarioState();
}

class _CadastroFuncionarioState extends State<CadastroFuncionario> {
  String? name;
  String? adress;
  String? date;
  String? phone;
  String? cpf;
  String? job;
  String? password;
  bool freezeScreen = false;

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

  void updateJob(job) {
    setState(() => this.job = job);
  }

  void updatePassword(password) {
    setState(() => this.password = password);
  }

  void sendData() async {
    //TODO: Realizar uma validação dos dados antes de enviar...

    //Enviar os dados para o servidor.

    Map<String, dynamic> dataFuncionario = {
      'nome_de_usuario': name,
      'nome': name,
      'senha': password,
      'endereco': adress,
      'data_de_nascimento': date,
      'inicio_na_empresa': '2022-01-01',
      'telefone': phone,
      'CPF': cpf,
      'profissao': job,
      'privilegio': 'Gerente'
    };

    try {
      setState(() => freezeScreen = true);
      if (!widget.isEditPage) {
        dynamic response = await cadastrarClienteFuncionario(
            dataFuncionario, 'cadastroFuncionario');

        if (response['statusCode'] >= 200 && response['statusCode'] < 300) {
          Alert(
              context: context,
              title: response['data'],
              content: const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 75,
              ),
              style: const AlertStyle(
                isCloseButton: false,
              ),
              buttons: [
                DialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Okay!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ))
              ]).show();
        } else {
          Alert(
              context: context,
              title: response['data'],
              content: const Icon(
                Icons.close_rounded,
                color: Colors.red,
                size: 75,
              ),
              style: const AlertStyle(
                isCloseButton: false,
              ),
              buttons: [
                DialogButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Okay!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ))
              ]).show();
        }
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() => freezeScreen = false);
    }

    //cadastrarClienteFuncionario(dataFuncionario, '/funcionario');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        inAsyncCall: freezeScreen,
        child: Column(
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
                            labelInit: widget.isEditPage &&
                                    widget.dataFuncionario != null
                                ? widget.dataFuncionario!.name
                                : '',
                            hintText: 'Nome usuário',
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
                            labelInit: widget.isEditPage &&
                                    widget.dataFuncionario != null
                                ? widget.dataFuncionario!.adress
                                : '',
                            hintText: 'Endereço',
                            icon: const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            onChanged: updateAdress,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextFiled(
                            labelInit: widget.isEditPage &&
                                    widget.dataFuncionario != null
                                ? widget.dataFuncionario!.birthDate
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
                            labelInit: widget.isEditPage &&
                                    widget.dataFuncionario != null
                                ? widget.dataFuncionario!.phone
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
                            labelInit: widget.isEditPage &&
                                    widget.dataFuncionario != null
                                ? widget.dataFuncionario!.cpf
                                : '',
                            hintText: 'Documento CPF',
                            icon:
                                const Icon(Icons.contacts, color: Colors.white),
                            onChanged: updateCPF,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 30),
                          child: CustomTextFiled(
                            labelInit: widget.isEditPage &&
                                    widget.dataFuncionario != null
                                ? widget.dataFuncionario!.job
                                : '',
                            hintText: 'Profissão',
                            icon: const Icon(
                              Icons.work,
                              color: Colors.white,
                            ),
                            onChanged: updateJob,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 30),
                          child: CustomTextFiled(
                            hintText: 'Senha',
                            icon: const Icon(
                              Icons.work,
                              color: Colors.white,
                            ),
                            onChanged: updatePassword,
                            obscureText: true,
                          ),
                        ),
                        /*Slider(
                          value: 180,
                          onChanged: (value) {},
                          min: 30,
                          max: 230,
                          inactiveColor: const Color(0xFF6C6D7B),
                          activeColor: Colors.white,
                          thumbColor: const Color(0xFFEB1555),
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButtom(
                              label: widget.isEditPage ? 'Editar' : 'Cadastrar',
                              onPressed: sendData,
                            ),
                            widget.isEditPage
                                ? DeleteButton(
                                    type: 'funcionario',
                                    idRemove: widget.dataFuncionario!.id,
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
      ),
    );
  }
}
