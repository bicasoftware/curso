import 'package:flutter/material.dart';

class Strings {
  static const String appName = 'iCurso';
  static const String opcoes = 'Opções';
  static const String informacoes = 'Informações';
  static const String periodos = 'Períodos';
  static const String periodo = 'Período';
  static const String trocarPeriodo = 'Trocar Período';
  static const String materias = 'Matérias';
  static const String materiasNoDia = 'Matérias no dia';
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
  static const String editarPeriodo = 'Período';
  static const String novoPeriodo = 'Novo Período';
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
  static const String removerProva = 'Deseja excluir a Prova?';
  static const String selectCor = 'Selecione uma Cor';
  static const String materiasVazias = 'Adicionar Matéria';
  static const String adicionar = 'Adicionar';
  static const String numPeriodo = 'Ordem do Período';
  static const String inicioAula = 'Inicio da Aula';
  static const String terminoAula = 'Término da Aula';
  static const String mes = 'Mês';
  static const String semAulasHoje = 'Nenhuma aula nessa data';
  static const String parciais = 'Parciais';
  static const String dataProva = 'Data da Prova';
  static const String valorReprovacao = "Valores de Reprovação";
  static const String aulas_e_horarios = "Aulas e Horários";
}

class Arrays {
  static const weekDaySigla = ["D", "S", "T", "Q", "Q", "S", "S"];
  static const weekDayShort = ["DOM", "SEG", "TER", "QUA", "QUI", "SEX", "SAB"];
  static const weekDayLong = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
  static const mediaAprovacao = [6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10];
  static const meses = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  static const opcoes = [Strings.opcoes];
  static const temas = [Strings.claro, Strings.escuro];

  static List<int> materialColors = <int>[
    Colors.red.value,
    Colors.redAccent.value,
    Colors.pink.value,
    Colors.pinkAccent.value,
    Colors.purple.value,
    Colors.purpleAccent.value,
    Colors.deepPurple.value,
    Colors.deepPurpleAccent.value,
    Colors.indigo.value,
    Colors.indigoAccent.value,
    Colors.blue.value,
    Colors.blueAccent.value,
    Colors.lightBlue.value,
    Colors.lightBlueAccent.value,
    Colors.cyan.value,
    Colors.cyanAccent.value,
    Colors.teal.value,
    Colors.tealAccent.value,
    Colors.green.value,
    Colors.greenAccent.value,
    Colors.lightGreen.value,
    Colors.lightGreenAccent.value,
    Colors.lime.value,
    Colors.limeAccent.value,
    Colors.yellow.value,
    Colors.yellowAccent.value,
    Colors.amber.value,
    Colors.amberAccent.value,
    Colors.orange.value,
    Colors.orangeAccent.value,
    Colors.deepOrange.value,
    Colors.deepOrangeAccent.value,
    Colors.brown.value,
    Colors.grey.value,
    Colors.blueGrey.value,
  ];
}

class Errors {
  static const errNomeMateria = "Indique um nome com mais de 3 letras";
  static const errSigla = "Sigla não pode estar vazia";
  static const horariosIguaisInvalidos = "Horários iguais não são permitidos";
  static const horariosInvalidos = "Horários inválidos";
  static const datasInvalidas = "Datas inválidas";
}
