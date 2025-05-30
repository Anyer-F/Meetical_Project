import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meetical_project/main.dart'; // Asegúrate que esta ruta sea correcta

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MeeticalApp());

    // Verifica que el contador empieza en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toca el botón "+" y actualiza la UI.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador incrementó a 1.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
