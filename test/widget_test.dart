// This is a basic Flutter widget test for the FlexiFonts package.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';

void main() {
  testWidgets('FlexiFontSelectorWidget basic test',
      (WidgetTester tester) async {
    // Create a controller
    final controller = FlexiFontController();
    await controller.initialize(
      includeGoogleFonts: false,
      customFonts: [
        const FontOption(
          fontFamily: 'TestFont',
          isGoogleFont: false,
        ),
      ],
    );

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: controller,
          child: const Scaffold(
            body: FlexiFontSelectorWidget(
              title: 'Test Font Selector',
            ),
          ),
        ),
      ),
    );

    // Verify that the title is displayed
    expect(find.text('Test Font Selector'), findsOneWidget);

    // Verify that the font is displayed
    expect(find.text('TestFont'), findsOneWidget);
  });
}
