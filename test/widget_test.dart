import 'package:curso/utils.dart/Formatting.dart';
import 'package:curso/utils.dart/StringUtils.dart';
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

    test("Horas", (){
      final hora = "18:00";
      print(Formatting.parseTime(hora));
      print(Formatting.formatTime(DateTime.now()));      
    });
  });
}
