import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fakestore_explorer/main.dart';

void main() {
  testWidgets('App builds without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(storage: null,));
    // apenas assegura que o widget é construído sem exceção
    expect(find.byType(Widget), isNotNull);
  });
}