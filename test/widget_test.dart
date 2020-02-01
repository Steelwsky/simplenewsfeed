import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simplenewsfeed/main.dart';

void main() {
  Future<void> pumpGivenApp(WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pump();
  }

  testWidgets('expect nothing on screen', (WidgetTester tester) async {
    await pumpGivenApp(tester);
    expect(find.byKey(Key('empty')), findsOneWidget);
  });
}
