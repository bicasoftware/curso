import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

abstract class ParciaisStatus {
  String get title;
  Color get cor;
}

class StatusAprovado implements ParciaisStatus {
  @override
  Color get cor => Colors.green;

  @override
  String get title => Strings.aprovado;
}

class StatusReprovado implements ParciaisStatus {
  @override
  Color get cor => Colors.deepOrange;

  @override
  String get title => Strings.reprovado;
}

class StatusEmAndamento implements ParciaisStatus {
  @override
  Color get cor => Colors.teal;

  @override
  String get title => Strings.emAndamento;
}

class StatusDispensado implements ParciaisStatus {
  @override
  Color get cor => Colors.greenAccent;

  @override
  String get title => Strings.dispensado;
}

class StatusDesconhecido implements ParciaisStatus {
  @override
  Color get cor => Colors.grey;

  @override
  String get title => Strings.desconhecido;
}
