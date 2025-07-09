import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/font_option.dart';
import 'utils/font_constants.dart';
import 'utils/storage_utils.dart';

/// Controller class for managing font selection and persistence
class FlexiFontController extends ChangeNotifier {
  /// Singleton instance
  static FlexiFontController? _instance;

  /// Get the singleton instance
  factory FlexiFontController({StorageProvider? storageProvider}) {
    _instance ??=
        FlexiFontController._internal(storageProvider: storageProvider);
    return _instance!;
  }

  /// Storage utility for font preferences
  final FontStorageUtils _storage;

  /// Currently selected font option
  FontOption? _selectedFont;

  /// Font scale factor (1.0 is normal)
  double _fontScale = 1.0;

  /// List of available font options
  final List<FontOption> _availableFonts = [];

  /// Whether the controller has been initialized
  bool _initialized = false;

  /// Internal constructor with optional storage provider
  FlexiFontController._internal({StorageProvider? storageProvider})
      : _storage = FontStorageUtils(storage: storageProvider);

  /// Get the currently selected font option
  FontOption? get selectedFont => _selectedFont;

  /// Get the current font scale factor
  double get fontScale => _fontScale;

  /// Get the list of available font options
  List<FontOption> get availableFonts => List.unmodifiable(_availableFonts);

  /// Check if the controller has been initialized
  bool get isInitialized => _initialized;

  /// Initialize the controller with default fonts and load saved preferences
  Future<void> initialize({
    List<FontOption>? customFonts,
    FontOption? defaultFont,
    bool includeGoogleFonts = true,
  }) async {
    if (_initialized) return;

    // Clear existing fonts
    _availableFonts.clear();

    // Add custom fonts if provided
    if (customFonts != null && customFonts.isNotEmpty) {
      _availableFonts.addAll(customFonts);
    }

    // Add Google Fonts if requested
    if (includeGoogleFonts) {
      _availableFonts.addAll(FontConstants.defaultGoogleFonts);
    }

    // Add system fonts
    _availableFonts.addAll(FontConstants.systemFonts);

    // Load saved preferences
    await _loadSavedFont();

    // If no font is selected and a default is provided, use it
    if (_selectedFont == null && defaultFont != null) {
      _selectedFont = _findFontOption(defaultFont.fontFamily) ?? defaultFont;

      // If the default font is not in the available fonts, add it
      if (!_availableFonts.contains(_selectedFont)) {
        _availableFonts.add(_selectedFont!);
      }
    }

    // If still no font is selected, use the first available font
    _selectedFont ??= _availableFonts.isNotEmpty
        ? _availableFonts.first
        : const FontOption(fontFamily: 'Roboto', isGoogleFont: true);

    _initialized = true;
    notifyListeners();
  }

  /// Load the saved font from storage
  Future<void> _loadSavedFont() async {
    try {
      // Load font scale
      _fontScale = await _storage.loadFontScale();

      // Load font family
      final savedFontFamily = await _storage.loadFontFamily();
      if (savedFontFamily == null) return;

      // Load whether it's a Google Font
      final isGoogleFont = await _storage.loadIsGoogleFont();

      // Find the font in available fonts
      _selectedFont = _findFontOption(savedFontFamily);

      // If not found, create a new FontOption
      if (_selectedFont == null) {
        _selectedFont = FontOption(
          fontFamily: savedFontFamily,
          isGoogleFont: isGoogleFont,
        );

        // Add to available fonts if not already there
        if (!_availableFonts.contains(_selectedFont)) {
          _availableFonts.add(_selectedFont!);
        }
      }
    } catch (e) {
      debugPrint('Error loading saved font: $e');
    }
  }

  /// Find a font option by font family name
  FontOption? _findFontOption(String fontFamily) {
    try {
      return _availableFonts.firstWhere(
        (font) => font.fontFamily.toLowerCase() == fontFamily.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Set the selected font and save to storage
  Future<void> setFont(FontOption font) async {
    if (_selectedFont == font) return;

    _selectedFont = font;
    notifyListeners();

    try {
      await _storage.saveFont(font);
    } catch (e) {
      debugPrint('Error saving font preference: $e');
    }
  }

  /// Set the font scale factor and save to storage
  Future<void> setFontScale(double scale) async {
    if (_fontScale == scale) return;

    _fontScale = scale;
    notifyListeners();

    try {
      await _storage.saveFontScale(scale);
    } catch (e) {
      debugPrint('Error saving font scale preference: $e');
    }
  }

  /// Add a custom font to the available fonts
  void addFont(FontOption font) {
    if (_availableFonts.contains(font)) return;

    _availableFonts.add(font);
    notifyListeners();
  }

  /// Remove a font from the available fonts
  void removeFont(FontOption font) {
    if (!_availableFonts.contains(font)) return;

    _availableFonts.remove(font);

    // If the removed font was selected, select the first available font
    if (_selectedFont == font) {
      _selectedFont = _availableFonts.isNotEmpty
          ? _availableFonts.first
          : const FontOption(fontFamily: 'Roboto', isGoogleFont: true);
      notifyListeners();
    }
  }

  /// Get a TextStyle with the selected font applied
  TextStyle getTextStyle({TextStyle? baseStyle}) {
    if (_selectedFont == null) {
      return baseStyle ?? const TextStyle(fontSize: 14.0);
    }

    TextStyle style = baseStyle ?? const TextStyle(fontSize: 14.0);

    // Apply font scale - ensure fontSize is not null
    final fontSize = style.fontSize ?? 14.0;
    style = style.copyWith(fontSize: fontSize * _fontScale);

    // Apply font family
    if (_selectedFont!.isGoogleFont) {
      try {
        // Use Google Fonts if it's a Google Font
        final googleFont = GoogleFonts.getFont(
          _selectedFont!.fontFamily,
          textStyle: style,
        );
        return googleFont;
      } catch (e) {
        // Fallback to system font if Google Font fails
        debugPrint(
            'Error loading Google Font: ${_selectedFont!.fontFamily}. Falling back to system font.');
        return style.copyWith(fontFamily: _selectedFont!.fontFamily);
      }
    } else {
      // Use system font
      return style.copyWith(fontFamily: _selectedFont!.fontFamily);
    }
  }

  /// Apply the selected font to a ThemeData
  ThemeData applyToTheme(ThemeData theme) {
    if (_selectedFont == null) return theme;

    // Ensure all text styles have a fontSize
    final ensuredTextTheme = _ensureTextThemeFontSizes(theme.textTheme);

    // Create text theme with the selected font
    final textTheme = ensuredTextTheme.apply(
      fontFamily:
          _selectedFont!.isGoogleFont ? null : _selectedFont!.fontFamily,
      fontSizeFactor: _fontScale,
    );

    // If it's a Google Font, apply it to each text style
    if (_selectedFont!.isGoogleFont) {
      try {
        final googleFontTextTheme = GoogleFonts.getTextTheme(
          _selectedFont!.fontFamily,
          textTheme,
        );
        return theme.copyWith(textTheme: googleFontTextTheme);
      } catch (e) {
        // Fallback to system font if Google Font fails
        debugPrint(
            'Error loading Google Font: ${_selectedFont!.fontFamily}. Falling back to system font.');
        return theme.copyWith(
          textTheme: textTheme.apply(fontFamily: _selectedFont!.fontFamily),
        );
      }
    }

    return theme.copyWith(textTheme: textTheme);
  }

  /// Ensure all text styles in a TextTheme have a fontSize
  TextTheme _ensureTextThemeFontSizes(TextTheme textTheme) {
    return TextTheme(
      displayLarge: _ensureFontSize(textTheme.displayLarge, 96.0),
      displayMedium: _ensureFontSize(textTheme.displayMedium, 60.0),
      displaySmall: _ensureFontSize(textTheme.displaySmall, 48.0),
      headlineLarge: _ensureFontSize(textTheme.headlineLarge, 40.0),
      headlineMedium: _ensureFontSize(textTheme.headlineMedium, 34.0),
      headlineSmall: _ensureFontSize(textTheme.headlineSmall, 24.0),
      titleLarge: _ensureFontSize(textTheme.titleLarge, 20.0),
      titleMedium: _ensureFontSize(textTheme.titleMedium, 16.0),
      titleSmall: _ensureFontSize(textTheme.titleSmall, 14.0),
      bodyLarge: _ensureFontSize(textTheme.bodyLarge, 16.0),
      bodyMedium: _ensureFontSize(textTheme.bodyMedium, 14.0),
      bodySmall: _ensureFontSize(textTheme.bodySmall, 12.0),
      labelLarge: _ensureFontSize(textTheme.labelLarge, 14.0),
      labelMedium: _ensureFontSize(textTheme.labelMedium, 12.0),
      labelSmall: _ensureFontSize(textTheme.labelSmall, 10.0),
    );
  }

  /// Ensure a TextStyle has a fontSize
  TextStyle? _ensureFontSize(TextStyle? style, double defaultSize) {
    if (style == null) return TextStyle(fontSize: defaultSize);
    if (style.fontSize != null) return style;
    return style.copyWith(fontSize: defaultSize);
  }

  /// Reset to default font and scale
  Future<void> resetToDefaults() async {
    _fontScale = 1.0;
    _selectedFont = _availableFonts.isNotEmpty
        ? _availableFonts.first
        : const FontOption(fontFamily: 'Roboto', isGoogleFont: true);

    notifyListeners();

    try {
      await _storage.resetFontSettings();
    } catch (e) {
      debugPrint('Error resetting font preferences: $e');
    }
  }

  /// Dispose the controller
  @override
  void dispose() {
    // Don't actually dispose the singleton instance
    super.dispose();
  }
}
