import 'package:fisio_studio/models/data_funcionario.dart';
import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:fisio_studio/widgets/delete_button.dart';
import 'package:flutter/material.dart';




class CadastroFuncionario extends StatelessWidget {
  final DataFuncionario? dataFuncionario;
  final bool isEditPage; 
  const CadastroFuncionario({ Key? key, this.dataFuncionario, this.isEditPage=false }) : super(key: key);

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
                          labelInit: isEditPage && dataFuncionario != null ? dataFuncionario!.name : '',
                          hintText: 'Nome usuário',
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit: isEditPage && dataFuncionario != null ? dataFuncionario!.adress : '',
                          hintText: 'Endereço',
                          icon: const Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFiled(
                          labelInit: isEditPage && dataFuncionario != null ? dataFuncionario!.birthDate : '',
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
                          labelInit: isEditPage && dataFuncionario != null ? dataFuncionario!.phone : '',
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
                          labelInit: isEditPage && dataFuncionario != null ? dataFuncionario!.cpf : '',
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
                          labelInit: isEditPage && dataFuncionario != null ? dataFuncionario!.job : '',
                          hintText: 'Profissão',
                          icon: const Icon(
                            Icons.work,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      Slider(
                        value: 180,
                        onChanged: (value){

                        },
                        min: 30,
                        max: 230,
                        inactiveColor: const Color(0xFF6C6D7B),
                        activeColor: Colors.white,
                        thumbColor: const Color(0xFFEB1555),
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