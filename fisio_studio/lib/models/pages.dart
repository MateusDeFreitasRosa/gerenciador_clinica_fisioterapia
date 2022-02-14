import 'package:flutter/material.dart';

Map<int, Map<String, dynamic>> pages = {
  0: {
    'name': 'Tela Inicial',
    'hidden': false,
    'icon': const Icon(
      Icons.home,
      color: Colors.white70,
    )
  },
  1: {
    'name': 'Cadastrar/Editar Funcionários',
    'hidden': false,
    'icon': const Icon(
      Icons.person,
      color: Colors.white70,
    )
  },
  2: {
    'name': 'Cadastrar/Editar Pacientes',
    'hidden': false,
    'icon': const Icon(
      Icons.person,
      color: Colors.white70,
    )
  },
  3: {
    'name': 'Listar Funcionarios',
    'hidden': false,
    'icon': const Icon(
      Icons.list_alt,
      color: Colors.white70,
    )
  },
  4: {
    'name': 'Listar Paciente',
    'hidden': false,
    'icon': const Icon(
      Icons.list_alt,
      color: Colors.white70,
    )
  },
  5: {
    'name': 'Calendario',
    'hidden': false,
    'icon': const Icon(
      Icons.calendar_today,
      color: Colors.white70,
    ),
  },
  6: {
    'name': 'Cadastrar Consulta',
    'hidden': true,
    'icon': const Icon(Icons.calendar_today)
  },
  7: {
    'name': 'Dados da consulta',
    'hidden': true,
    'icon': const Icon(Icons.view_agenda)
  }
};
