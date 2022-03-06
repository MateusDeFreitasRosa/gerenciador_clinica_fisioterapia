import 'package:flutter/material.dart';

const palleteColorTypeAppointment = 'appointmentColors';

const backgroundApp = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("images/background.png"),
    fit: BoxFit.cover,
  ),
);

String urlServer = 'https://fisio-studio.herokuapp.com/';

Map<String, dynamic> urlRequest = {
  'post': {
    'cadastroFuncionario': urlServer + 'funcionario',
    'cadastroCliente': urlServer + 'cliente',
    'cadastroConsulta': urlServer + 'cliente/agendamento'
  },
  'get': {
    'getFuncionario': urlServer + 'funcionario',
    'getCliente': urlServer + 'cliente',
    'getConsultas': urlServer + 'cliente/agendamento/horarios',
    'login': urlServer + 'login',
    'getClienteAniversariante': urlServer + 'cliente/aniversariantes',
  },
  'update': {
    'atualizaFuncionario': urlServer + 'funcionario',
    'atualizaCliente': urlServer + 'cliente',
  },
  'delete': {
    'deleteFuncionario': urlServer + 'funcionario',
    'deleteCliente': urlServer + 'cliente',
    'deleteConsulta': urlServer + 'cliente/agendamento'
  }
};
