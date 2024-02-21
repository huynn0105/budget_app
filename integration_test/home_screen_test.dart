// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:budget_app/main.dart' as app;

// void main() {
//   group('HomeScreen test', () {
//     testWidgets('Verify integration with Transaction',
//         (WidgetTester tester) async {
//       app.main();
//       await tester.pumpAndSettle();
//       await tester.tap(find.byKey(const Key('addNewTransaction')));
//       await tester.pumpAndSettle();
//       await tester.enterText(find.byKey(const Key('moneyTextField')), '100000');
//       await tester.pumpAndSettle();
//       await tester.enterText(find.byKey(const Key('noteTextField')), 'Food');
//       await tester.pumpAndSettle();
//       await tester.tap(find.text('Save'));
//       await tester.pumpAndSettle();
//       expect(find.text('Food'), findsOneWidget);
//       expect(find.byKey(const Key('addNewTransaction')), findsOneWidget);
//     });
//   });
// }
