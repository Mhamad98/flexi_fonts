import 'package:flutter_test/flutter_test.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FlexiFontController Tests', () {
    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
    });

    test('Controller should initialize with default values', () async {
      final controller = FlexiFontController();
      expect(controller.isInitialized, false);
      expect(controller.selectedFont, null);
      expect(controller.fontScale, 1.0);
      expect(controller.availableFonts, isEmpty);
      
      await controller.initialize(
        includeGoogleFonts: false,
        customFonts: [
          const FontOption(
            fontFamily: 'TestFont',
            isGoogleFont: false,
          ),
        ],
      );
      
      expect(controller.isInitialized, true);
      expect(controller.selectedFont, isNotNull);
      expect(controller.selectedFont!.fontFamily, 'TestFont');
      expect(controller.fontScale, 1.0);
      expect(controller.availableFonts, isNotEmpty);
    });

    test('setFont should update the selected font', () async {
      final controller = FlexiFontController();
      await controller.initialize(
        includeGoogleFonts: false,
        customFonts: [
          const FontOption(
            fontFamily: 'TestFont1',
            isGoogleFont: false,
          ),
          const FontOption(
            fontFamily: 'TestFont2',
            isGoogleFont: false,
          ),
        ],
      );
      
      final newFont = controller.availableFonts.where(
        (font) => font.fontFamily == 'TestFont2',
      ).first;
      
      await controller.setFont(newFont);
      
      expect(controller.selectedFont, newFont);
    });

    test('setFontScale should update the font scale', () async {
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
      
      const newScale = 1.5;
      await controller.setFontScale(newScale);
      
      expect(controller.fontScale, newScale);
    });

    test('getTextStyle should return a TextStyle with the selected font', () async {
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
      
      final style = controller.getTextStyle();
      
      expect(style, isA<TextStyle>());
      expect(style.fontFamily, 'TestFont');
    });

    test('resetToDefaults should reset font and scale', () async {
      final controller = FlexiFontController();
      await controller.initialize(
        includeGoogleFonts: false,
        customFonts: [
          const FontOption(
            fontFamily: 'TestFont1',
            isGoogleFont: false,
          ),
          const FontOption(
            fontFamily: 'TestFont2',
            isGoogleFont: false,
          ),
        ],
      );
      
      final newFont = controller.availableFonts.where(
        (font) => font.fontFamily == 'TestFont2',
      ).first;
      
      await controller.setFont(newFont);
      await controller.setFontScale(1.5);
      
      await controller.resetToDefaults();
      
      expect(controller.fontScale, 1.0);
      expect(controller.selectedFont!.fontFamily, 'TestFont1');
    });
  });
}