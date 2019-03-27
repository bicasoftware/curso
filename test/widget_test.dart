import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  group("Datas", () {
    test('parseDate', () {
      Intl.defaultLocale = 'pt_BR';
      final d = parseDate("2018-02-03");
      assert(d == DateTime(2018, 02, 03));
    });
  });

  test('list dates', () {
    final inicio = DateTime(2019, 2, 10);
    final termino = DateTime(2019, 3, 10);

    final dates = buildDateRangeList(inicio, termino);
    dates.forEach((d) => print(formatDate(d)));
  });

  test('count weekDays', () {
    final inicio = DateTime(2019, 2, 10);
    print(formatDate(inicio));
    final termino = DateTime(2019, 3, 13);
    print(formatDate(termino));

    final count = countWeekDayInRange(inicio, termino, 0);
    print(count);
  });

  test('isToday', () {
    final hoje = DateTime(2019, 2, 28);
    assert(isToday(hoje));
  });

  test('top level', () {
    final nomes = ["saulo", "henrique", "andrioli"];
    print(parseListAsQuotedString(nomes));

    final numeros = [1, 2, 3, 4, 5, 6, 7, 8];
    print(parseListAsQuotedString(numeros));
  });

  test("mes extenso", () {
    final today = DateTime.now();
    print(formatMonthName(today));
  });

  test("dia extenso", () {
    final diaExtenso = formatFullDayString(DateTime.now());
    print(diaExtenso);
  });

  /* test('get days in range', () async {
    final ini = DateTime.now();
    final end = ini.add(Duration(days: 90));
    final diasPeriodos = await prepareCalendario(start: ini, end: end);

    diasPeriodos.forEach((mes) {
      print("mes: ${mes.first}");
      mes.second.forEach((dia) => print(formatDate(dia)));
    });
  }); */

  /* test('fill Calendar',() async {

    final ini = DateTime.now();
    final end = ini.add(Duration(days: 10));
    final daysOnMonth = await prepareCalendario(start: ini, end: end);
    final daysToShow = leftFillCalendar(daysOnMonth[0].second);

    daysToShow.forEach((d) => print(formatDate(d)));
  }); */

  test("test Streams", () async {
    final _subTest = BehaviorSubject<DateTime>();
    Stream<DateTime> outTest = _subTest.stream;

    final _subNome = BehaviorSubject<String>();
    Stream<String> outNome = _subNome.stream;

    _subTest.sink.add(DateTime.now());
    _subNome.sink.add("Saulo");

    ZipStream([outTest, outNome], (a){
      return []..addAll(a);
    }).listen((List a) {
      print("Data: ${a[0]}, nome: ${a[1]}");
    }).onDone(() {
      _subTest.close();
      _subNome.close();
    });
  });

  test('short weekDay', () {
    final s = formatSingleLetterWeekDay(DateTime.now());
    print(s);
  });

  group("Strings", () {
    test('cammelCase', () {
      final cammeledNome = StringUtils.toCammelCase("SAULO HENRIQUE ANDRIOLI");
      assert(cammeledNome == "Saulo Henrique Andrioli");
    });

    test('parseInt', () {
      assert(StringUtils.isInt("abc") == false);
    });

    test("Horas", () {
      final hora = "18:00";
      final DateTime dtHora = parseTime(hora);
      print(dtHora);
      print(formatTime(dtHora));
    });

    test("list generate", () {
      print(List.generate(12, (i) => i + 1).join(","));
    });

    test("parse TimeOfDay", () {
      final time = TimeOfDay(hour: 20, minute: 30);
      final DateTime date = parseTimeOfDay(time);

      print(date);
    });

    test("Pair", () {
      final p = Pair(first: "Idade", second: 12);
      print(p);

      final pessoa = Pair(first: 23, second: "Itapui");
      print(pessoa);
    });

    test("WeekDayExtenso", () {
      final day = formatWeekDay(DateTime.now());
      final dayFull = formatFullWeekDay(DateTime.now());
      print(day);
      print(dayFull);
    });
  });
}
