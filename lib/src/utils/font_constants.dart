import '../models/font_option.dart';

/// Constants for font options
class FontConstants {
  /// A curated list of popular Google Fonts
  static final List<FontOption> defaultGoogleFonts = [
    // Sans-serif fonts
    const FontOption(
      fontFamily: 'Roboto',
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Open Sans',
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Lato',
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Montserrat',
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Poppins',
      category: FontCategory.sansSerif,
    ),

    // Serif fonts
    const FontOption(
      fontFamily: 'Merriweather',
      category: FontCategory.serif,
    ),
    const FontOption(
      fontFamily: 'Playfair Display',
      category: FontCategory.serif,
    ),
    const FontOption(
      fontFamily: 'Lora',
      category: FontCategory.serif,
    ),

    // Display fonts
    const FontOption(
      fontFamily: 'Pacifico',
      category: FontCategory.display,
    ),
    const FontOption(
      fontFamily: 'Bebas Neue',
      category: FontCategory.display,
    ),

    // Handwriting fonts
    const FontOption(
      fontFamily: 'Dancing Script',
      category: FontCategory.handwriting,
    ),
    const FontOption(
      fontFamily: 'Caveat',
      category: FontCategory.handwriting,
    ),

    // Monospace fonts
    const FontOption(
      fontFamily: 'Roboto Mono',
      category: FontCategory.monospace,
    ),
    const FontOption(
      fontFamily: 'Source Code Pro',
      category: FontCategory.monospace,
    ),

    // RTL support fonts
    const FontOption(
      fontFamily: 'Amiri',
      category: FontCategory.serif,
      sampleText: 'هذا النص هو مثال لنص يمكن أن يستبدل',
    ),
    const FontOption(
      fontFamily: 'Cairo',
      category: FontCategory.sansSerif,
      sampleText: 'هذا النص هو مثال لنص يمكن أن يستبدل',
    ),
    const FontOption(
      fontFamily: 'Noto Sans Arabic',
      category: FontCategory.sansSerif,
      sampleText: 'هذا النص هو مثال لنص يمكن أن يستبدل',
    ),
    const FontOption(
      fontFamily: 'Noto Kufi Arabic',
      category: FontCategory.sansSerif,
      sampleText: 'هذا النص هو مثال لنص يمكن أن يستبدل',
    ),
  ];

  /// System fonts that are commonly available
  static final List<FontOption> systemFonts = [
    const FontOption(
      fontFamily: 'Arial',
      isGoogleFont: false,
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Helvetica',
      isGoogleFont: false,
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Times New Roman',
      isGoogleFont: false,
      category: FontCategory.serif,
    ),
    const FontOption(
      fontFamily: 'Courier New',
      isGoogleFont: false,
      category: FontCategory.monospace,
    ),
    const FontOption(
      fontFamily: 'Georgia',
      isGoogleFont: false,
      category: FontCategory.serif,
    ),
    const FontOption(
      fontFamily: 'Verdana',
      isGoogleFont: false,
      category: FontCategory.sansSerif,
    ),
    const FontOption(
      fontFamily: 'Tahoma',
      isGoogleFont: false,
      category: FontCategory.sansSerif,
    ),
  ];

  /// Sample text for font previews in different languages
  static const Map<String, String> sampleTexts = {
    'en': 'The quick brown fox jumps over the lazy dog',
    'ar': 'هذا النص هو مثال لنص يمكن أن يستبدل',
    'ku': 'ئەم دەقە نموونەیەکە بۆ دەقێک کە دەکرێت جێگۆڕکێ بکرێت',
  };
}
