import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobapps/main.dart'; // 🔑 Import perbaikan

void main() {
  testWidgets('Smoke test: build MyApp', (WidgetTester tester) async {
    // Membangun aplikasi dan pemicu frame pertama.
    await tester.pumpWidget(const MyApp());

    // Verifikasi bahwa widget MyApp membangun (tidak crash).
    expect(find.byType(MyApp), findsOneWidget);
  });
}
