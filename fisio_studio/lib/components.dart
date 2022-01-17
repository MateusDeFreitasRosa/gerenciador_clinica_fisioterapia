import 'package:flutter/material.dart';

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
  },
  'get': {
    'getFuncionario': urlServer + 'funcionario',
    'getCliente': urlServer + 'cliente'
  },
  'update': {
    'atualizaFuncionario': urlServer + 'funcionario',
    'atualizaCliente': urlServer + 'cliente',
  },
  'delete': {
    'deleteFuncionario': urlServer + 'funcionario',
    'deleteCliente': urlServer + 'cliente'
  }
};
