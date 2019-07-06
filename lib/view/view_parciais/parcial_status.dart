import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

abstract class ParciaisStatus {
  String get title;
  Color get cor;
  Icon get icon;
}

class StatusAprovado implements ParciaisStatus {
  @override
  Color get cor => Colors.lightBlue;

  @override
  String get title => Strings.aprovado;

  @override
  Icon get icon => Icon(Icons.thumb_up, color: Colors.lightBlue);
}

class StatusReprovadoNotas implements ParciaisStatus {
  @override
  Color get cor => Colors.red;

  @override
  String get title => Strings.reprovadoNota;

  @override
  Icon get icon => Icon(Icons.thumb_down, color: Colors.red);
}

class StatusReprovadoFaltas implements ParciaisStatus {
  @override
  Color get cor => Colors.red;

  @override
  String get title => Strings.reprovadoFalta;

  @override
  Icon get icon => Icon(Icons.thumb_down, color: Colors.red);
}

class StatusEmAndamento implements ParciaisStatus {
  @override
  Color get cor => Colors.teal;

  @override
  String get title => Strings.emAndamento;

  @override
  Icon get icon => Icon(Icons.timeline, color: Colors.teal);
}

class StatusDispensado implements ParciaisStatus {
  @override
  Color get cor => Colors.lightBlue;

  @override
  String get title => Strings.dispensado;

  @override
  Icon get icon => Icon(Icons.free_breakfast, color: Colors.lightBlue);
}

class StatusFaltandoValoresNota implements ParciaisStatus {
  @override
  Color get cor => Colors.orange;

  @override
  String get title => Strings.faltandoNotas;

  @override
  Icon get icon => Icon(Icons.warning, color: Colors.orange);
}

class StatusFaltandoNotas implements ParciaisStatus {
  @override
  Color get cor => Colors.orange;

  @override
  String get title => Strings.faltandoIncuirNotas;

  @override
  Icon get icon => Icon(Icons.warning, color: Colors.orange);
}
