import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

DateFormat _fmt = DateFormat("dd/MM/yyyy", "pt_BT");
DateFormat _defFmt = DateFormat("yyyy-MM-dd");
DateFormat _timeFormat = DateFormat("HH:mm");
DateFormat _fullWeekDayFmt = DateFormat("E", "pt_BR");
DateFormat _weekDayFmt = DateFormat("E", "pt_BR");
DateFormat _monthFmt = DateFormat("MMMM", "pt_BR");

DateTime get emptyDate => DateTime(1970, 1, 1);

DateTime get lastDate => DateTime(2030, 12, 31);

initializeCountry() => initializeDateFormatting("pt_BR", null);

String formatDate(DateTime date) {
  initializeCountry();
  if (date == null) return "null";
  return _fmt.format(date);
}

DateTime parseDate(String date) {
  return _defFmt.parse(date);
}

String formatDbDate(DateTime date) {
  return _defFmt.format(date);
}

String formatTime(DateTime time) {
  return _timeFormat.format(time);
}

DateTime parseTime(String time) {
  return _timeFormat.parse(time);
}

DateTime parseTimeOfDay(TimeOfDay t) {
  if (t == null) throw NullThrownError();
  return _timeFormat.parse("${t.hour}:${t.minute}");
}

String formatWeekDay(DateTime date) {
  initializeDateFormatting("pt_BR", null);
  return _weekDayFmt.format(date).toUpperCase();
}

String formatSingleLetterWeekDay(DateTime date) {
  initializeDateFormatting("pt_BR", null);
  return _weekDayFmt.format(date)[0].toUpperCase();
}

String formatFullWeekDay(DateTime date) {
  initializeDateFormatting("pt_BR", null);
  return _fullWeekDayFmt.format(date).toLowerCase();
}

String formatMonthName(DateTime date) {
  initializeCountry();
  return _monthFmt.format(date).toUpperCase();
}

String formatFullDayString(DateTime date) {
  //"02 de Março de 2018, Quarta-Feira"
  initializeCountry();
  return DateFormat("dd 'de' MMMM 'de' yyyy, EEEE", "pt_BR").format(date);
}

List<DateTime> buildDateRangeList(DateTime inicio, DateTime termino) {
  initializeDateFormatting("pt_BR", null);
  if (inicio.isAfter(termino)) throw Exception(Errors.datasInvalidas);
  final List<DateTime> dateList = [];
  var currentDay = inicio;

  while (currentDay.isBefore(termino)) {
    dateList.add(currentDay);
    currentDay = currentDay.add(Duration(days: 1));

    if (dateList.length > 50) {
      break;
    }
  }

  dateList.add(currentDay);

  return dateList;
}

int countWeekDayInRange(DateTime inicio, DateTime termino, int dayToCount) {
  initializeDateFormatting("pt_BR", null);
  if (inicio.isAfter(termino)) throw Exception(Errors.datasInvalidas);
  int count = 0;
  DateTime currentDay = inicio;
  while (currentDay.isBefore(termino)) {
    if (getWeekday(currentDay) == dayToCount) count += 1;
    currentDay = currentDay.add(Duration(days: 1));
  }
  if (getWeekday(currentDay) == dayToCount) count += 1;

  return count;
}

int getWeekday(DateTime date) {
  switch (date.weekday) {
    case DateTime.sunday:
      return 0;
      break;
    case DateTime.monday:
      return 1;
      break;
    case DateTime.tuesday:
      return 2;
      break;
    case DateTime.wednesday:
      return 3;
      break;
    case DateTime.thursday:
      return 4;
      break;
    case DateTime.friday:
      return 5;
      break;
    case DateTime.saturday:
      return 6;
      break;
    default:
      return -1;
  }
}

bool isToday(DateTime date) {
  initializeCountry();
  final dif = DateTime.now().difference(date);
  return dif.inHours >= 0 && dif.inMinutes <= (23 * 60) + 59;
}

bool isSameDay(DateTime date1, DateTime date2){
  initializeCountry();
  final dif = date1.difference(date2);
  return dif.inHours >= 0 && dif.inMinutes <= (23 * 60) + 59;
}

List<CalendarioDTO> prepareCalendario({
  @required DateTime start,
  @required DateTime end,
  @required List<AulasSemanaDTO> aulasSemana,
}) {
  final rightEnd = end.add(Duration(days: 1));
  final calendario = List<CalendarioDTO>();
  for (var m = start.month; m <= rightEnd.month; m++) {
    final inCalendario = CalendarioDTO(mes: m, dates: []);

    while (m == start.month && start.isBefore(rightEnd)) {
      inCalendario.dates.add(
        DataDTO(
          date: start,
          aulas: aulasSemana.where((aulas) => aulas.weekDay == getWeekday(start)).toList(),
        ),
      );
      start = start.add(Duration(days: 1));
    }
    calendario.add(inCalendario);
  }

  return calendario;
}

List<DateTime> leftFillCalendar(List<DateTime> daysOnMonth) {
  final daysToShow = List<DateTime>();

  var start = daysOnMonth.first;
  while (start.weekday != DateTime.sunday) {
    daysToShow.add(null);
    start = start.subtract(Duration(days: 1));
  }

  return daysToShow..addAll(daysOnMonth);
}
