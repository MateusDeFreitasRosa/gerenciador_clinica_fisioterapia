import 'package:fisio_studio/widgets/custom_buttom.dart';
import 'package:fisio_studio/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CadastroPaciente extends StatelessWidget {
  const CadastroPaciente({ Key? key }) : super(key: key);

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
                          hintText: 'Endereço',
                          icon: const Icon(
                            Icons.work,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      CustomButtom(
                        label: 'Cadastrar',
                        onPressed: () {},
                      )
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