import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ParcialStatus {
  final String title;
  final Color cor;

  ParcialStatus({this.title, this.cor});

  factory ParcialStatus.emAndamento() {
    return ParcialStatus(cor: Colors.teal, title: Strings.emAndamento);
  }

  factory ParcialStatus.dispensado() {
    return ParcialStatus(cor: Colors.greenAccent, title: Strings.dispensado);
  }

  factory ParcialStatus.aprovado() {
    return ParcialStatus(cor: Colors.lightBlue, title: Strings.aprovado);
  }

  factory ParcialStatus.reprovado() {
    return ParcialStatus(cor: Colors.deepOrange, title: Strings.reprovado);
  }

  factory ParcialStatus.concluido() {
    return ParcialStatus(cor: Colors.blue, title: Strings.concluido);
  }

  ParcialStatus copyWith({String title, double cor}) {
    return ParcialStatus(
      title: title ?? this.title,
      cor: cor ?? this.cor,
    );
  }
}
