import 'package:fisio_studio/models/data_paciente.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:fisio_studio/widgets/delete_button.dart';
import 'package:flutter/material.dart';

class CadastroPaciente extends StatelessWidget {
  final DataPaciente ? dataPaciente;
  final bool isEditPage; 

  const CadastroPaciente({ Key? key, this.isEditPage=false, this.dataPaciente }) : super(key: key);

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
                          labelInit: isEditPage && dataPaciente != null ? dataPaciente!.name : '',
                          hintText: 'Nome paciente',
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit: isEditPage && dataPaciente != null ? dataPaciente!.birthDate : '',
                          hintText: 'Data de Nascimento',
                          icon: const Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit: isEditPage && dataPaciente != null ? dataPaciente!.phone : '',
                          hintText: 'Telefone',
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit: isEditPage && dataPaciente != null ? dataPaciente!.cpf : '',
                          hintText: 'Documento CPF',
                          icon: const Icon(
                            Icons.contacts,
                            color: Colors.white
                          )
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 30),
                        child: CustomTextFiled(
                          labelInit: isEditPage && dataPaciente != null ? dataPaciente!.adress : '',
                          hintText: 'Endereço',
                          icon: const Icon(
                            Icons.work,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtom(
                            label: isEditPage ? 'Editar' : 'Cadastrar',
                            onPressed: () {},
                          ),

                          isEditPage ? const DeleteButton() : Container(),
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