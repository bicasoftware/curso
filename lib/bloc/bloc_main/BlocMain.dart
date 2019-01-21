import 'package:bloc/bloc.dart';
import 'package:curso/container/aulas.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/utils.dart/AppBrightness.dart';
import 'package:flutter/material.dart';

class BlocMain extends Bloc<MainEvents, MainState> {
  @override
  MainState get initialState {
    return MainState(
      navPos: 0,
      periodos: [
        Periodos(
          id: 1,
          inicio: DateTime(2019, 01, 12),
          termino: DateTime(2019, 06, 01),
          aulasDia: 4,
          medAprov: 7.0,
          presObrig: 75,
          materias: [
            Materias(
              id: 2,
              idPeriodo: 1,
              nome: "Português",
              sigla: "PORT",
              cor: Colors.blue.value,
              freq: true,
              medAprov: 7.0,
              aulas: [
                Aulas(id: 5, weekDay: 1, ordem: 0),
                Aulas(id: 6, weekDay: 1, ordem: 1),
              ],
            ),
            Materias(
              id: 3,
              idPeriodo: 1,
              nome: "Química",
              sigla: "QUÍ",
              cor: Colors.teal.value,
              freq: true,
              medAprov: 7.0,
              aulas: [
                Aulas(id: 7, weekDay: 1, ordem: 2),
                Aulas(id: 8, weekDay: 1, ordem: 3),
              ],
            ),
            Materias(
              id: 4,
              idPeriodo: 1,
              nome: "Física",
              sigla: "Fis",
              cor: Colors.orange.value,
              freq: true,
              medAprov: 7.0,
              aulas: [
                Aulas(id: 9, weekDay: 2, ordem: 0),
                Aulas(id: 10, weekDay: 2, ordem: 1),
                Aulas(id: 11, weekDay: 2, ordem: 2),
                Aulas(id: 12, weekDay: 2, ordem: 3),
              ],
            ),
            Materias(
              id: 1,
              idPeriodo: 1,
              nome: "Matemática",
              sigla: "MAT",
              freq: true,
              medAprov: 7.0,
              cor: Colors.red.value,
              faltas: [
                Faltas(
                  id: 1,
                  idMateria: 1,
                  numAula: 1,
                  data: DateTime(2019, 2, 16),
                ),
                Faltas(
                  id: 2,
                  idMateria: 1,
                  numAula: 2,
                  data: DateTime(2019, 2, 16),
                ),
              ],
              notas: [
                Notas(
                  id: 1,
                  idMateria: 1,
                  nota: 9.5,
                  data: DateTime(2019, 03, 02),
                ),
                Notas(
                  id: 2,
                  idMateria: 1,
                  nota: 8,
                  data: DateTime(2019, 04, 12),
                )
              ],
              aulas: [
                Aulas(
                  id: 1,
                  idMateria: 1,
                  ordem: 0,
                  weekDay: 3,
                ),
                Aulas(
                  id: 2,
                  idMateria: 1,
                  ordem: 1,
                  weekDay: 3,
                ),
                Aulas(
                  id: 1,
                  idMateria: 1,
                  ordem: 2,
                  weekDay: 3,
                ),
              ],
            ),
          ],
        )
      ],
      brightness: AppBrightness.DARK,
      notify: false,
    );
  }

  @override
  Stream<MainState> mapEventToState(MainState currentState, MainEvents event) async* {
    if (event is SetPosition) {
      yield currentState.copyWith(navPos: event.pos);
    } else if (event is SetNotify) {
      yield currentState.copyWith(notify: event.notify);
    } else if (event is SetBrightness) {
      yield currentState.copyWith(brightness: event.brightness);
    } else if (event is UpdatePeriodo) {
      final periodos = currentState.periodos;
      final index = periodos.indexWhere((it) => it.id == event.periodo.id);
      periodos[index] = periodos[index].copyWith(oldPeriodo: event.periodo);
      yield currentState.copyWith(periodos: periodos);
    } else if (event is InsertPeriodo) {
      yield currentState.copyWith(periodos: currentState.periodos..add(event.periodo));
    }
  }
}
