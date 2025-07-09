import 'package:flutter/material.dart';

/// Utility class for RTL text support
class RtlUtils {
  /// Check if a string contains RTL characters
  static bool containsRtl(String text) {
    // Unicode ranges for RTL scripts
    final rtlRanges = [
      // Arabic
      RegExp(r'[\u0600-\u06FF]'),
      // Hebrew
      RegExp(r'[\u0590-\u05FF]'),
      // Farsi/Persian extensions
      RegExp(r'[\uFB50-\uFDFF]'),
      // Arabic presentation forms
      RegExp(r'[\uFE70-\uFEFF]'),
      // Kurdish
      RegExp(r'[\u0750-\u077F]'),
    ];

    for (final range in rtlRanges) {
      if (range.hasMatch(text)) {
        return true;
      }
    }

    return false;
  }

  /// Wrap text in a Directionality widget if it contains RTL characters
  static Widget wrapWithDirectionality({
    required Widget child,
    required String text,
    TextDirection defaultDirection = TextDirection.ltr,
  }) {
    final isRtl = containsRtl(text);

    if (isRtl) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: child,
      );
    }

    return defaultDirection == TextDirection.rtl
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          )
        : child;
  }

  /// Get the appropriate text direction for a string
  static TextDirection getTextDirection(String text) {
    return containsRtl(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  /// Get a list of supported RTL languages
  static List<String> get supportedRtlLanguages => [
        'ar', // Arabic
        'he', // Hebrew
        'fa', // Persian/Farsi
        'ur', // Urdu
        'ku', // Kurdish
        'sd', // Sindhi
        'dv', // Dhivehi
      ];

  /// Check if a language code is RTL
  static bool isRtlLanguage(String languageCode) {
    return supportedRtlLanguages.contains(languageCode.toLowerCase());
  }
}
