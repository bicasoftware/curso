import 'package:curso/utils.dart/Formatting.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(AppEntrance());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });

  group('Datas', () {
    test('parseDate', () {
      Intl.defaultLocale = 'pt_BR';
      final d = Formatting.parseDate("2018-02-03");
      assert(d == DateTime(2018, 02, 03));
    });
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
      final DateTime dtHora = Formatting.parseTime(hora);
      print(dtHora);
      print(Formatting.formatTime(dtHora));
    });

    test("list generate", () {
      print(List.generate(12, (i) => i + 1).join(","));
    });

    test("parse TimeOfDay", () {
      final time = TimeOfDay(hour: 20, minute: 30);
      final DateTime date = Formatting.parseTimeOfDay(time);

      print(date);
    });

    test("Pair", () {
      final p = Pair(first: "Idade", second: 12);
      print(p);

      final pessoa = Pair(first: 23, second: "Itapui");
      print(pessoa);
    });
  });
}
