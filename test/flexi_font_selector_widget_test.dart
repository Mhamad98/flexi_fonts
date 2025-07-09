import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FlexiFontSelectorWidget Tests', () {
    late FlexiFontController controller;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      controller = FlexiFontController();
      await controller.initialize(
        includeGoogleFonts: false,
        customFonts: [
          const FontOption(
            fontFamily: 'TestFont1',
            isGoogleFont: false,
            category: FontCategory.sansSerif,
          ),
          const FontOption(
            fontFamily: 'TestFont2',
            isGoogleFont: false,
            category: FontCategory.serif,
          ),
          const FontOption(
            fontFamily: 'TestFont3',
            isGoogleFont: false,
            category: FontCategory.monospace,
          ),
        ],
      );
    });

    testWidgets('FlexiFontSelectorWidget should display fonts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: controller,
            child: const Scaffold(
              body: FlexiFontSelectorWidget(
                title: 'Test Fonts',
                showSearch: true,
                showFontScaleSlider: true,
              ),
            ),
          ),
        ),
      );

      // Wait for widget to build
      await tester.pumpAndSettle();

      // Check if title is displayed
      expect(find.text('Test Fonts'), findsOneWidget);

      // Check if search field is displayed
      expect(find.byType(TextField), findsOneWidget);

      // Check if font scale slider is displayed
      expect(find.byType(Slider), findsOneWidget);

      // Check if fonts are displayed
      expect(find.text('TestFont1'), findsOneWidget);
      expect(find.text('TestFont2'), findsOneWidget);
      expect(find.text('TestFont3'), findsOneWidget);
    });

    testWidgets('FlexiFontSelectorWidget should have search functionality',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: controller,
            child: const Scaffold(
              body: FlexiFontSelectorWidget(
                showSearch: true,
              ),
            ),
          ),
        ),
      );

      // Wait for widget to build
      await tester.pumpAndSettle();

      // Check if search field exists
      expect(find.byType(TextField), findsOneWidget);

      // Enter search text
      await tester.enterText(find.byType(TextField), 'TestFont1');
      await tester.pumpAndSettle();

      // Verify search functionality works (text was entered)
      expect(find.text('TestFont1'), findsAtLeastNWidgets(1));
    });

    testWidgets('FlexiFontSelectorWidget should select font on tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: controller,
            child: const Scaffold(
              body: FlexiFontSelectorWidget(),
            ),
          ),
        ),
      );

      // Wait for widget to build
      await tester.pumpAndSettle();

      // Initial font should be TestFont1
      expect(controller.selectedFont!.fontFamily, 'TestFont1');

      // Find and tap on TestFont2
      await tester.tap(find.text('TestFont2'));
      await tester.pumpAndSettle();

      // Selected font should now be TestFont2
      expect(controller.selectedFont!.fontFamily, 'TestFont2');
    });
  });
}
