import 'package:flutter/material.dart';

class Strings {
  static const String appName = 'iCurso';
  static const String opcoes = 'Opções';
  static const String informacoes = 'Informações';
  static const String periodos = 'Períodos';
  static const String periodo = 'Período';
  static const String materias = 'Matérias';
  static const String materia = 'Matéria';
  static const String sigla = 'Sigla';
  static const String corMateria = 'Cor da Materia';
  static const String cor = 'Cor';
  static const String provas = 'Provas';
  static const String cronograma = 'Cronograma';
  static const String calendario = 'Calendário';
  static const String notificar = 'Notificar';
  static const String tema = 'Tema';
  static const String claro = 'Claro';
  static const String escuro = 'Escuro';
  static const String novoPeriodo = 'Novo Periodo';
  static const String inicioPeriodo = 'Inicio do Período';
  static const String terminoPeriodo = 'Inicio do Período';
  static const String aulasDia = 'Aulas por Dia';
  static const String notaAprovacao = 'Nota de Aprovação';
  static const String presencaObrigatoria = 'Presença obrigatória';
  static const String editar = 'Alterar';
  static const String excluir = 'Excluír';
  static const String salvar = 'Salvar';
  static const String removerMateria = 'Excluír Materia';
  static const String removerPeriodo = 'Excluír Período?';
  static const String selectCor = 'Selecione uma Cor';
  static const String materiasVazias = 'Adicionar Matéria';
}

class Arrays {
  static const weekDayShort = ["DOM", "SEG", "TER", "QUA", "QUI", "SEX", "SAB"];
  static const weekDayLong = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
  static const mediaAprovacao = [6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10];

  static const opcoes = [Strings.opcoes];
  static const temas = [Strings.claro, Strings.escuro];
  static const List<MaterialColor> materialColors = const <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
  ];
}

class Errors {
  static const errNomeMateria = "Indique um nome com mais de 3 letras";
  static const errSigla = "Sigla não pode estar vazia";
}
