import 'package:flexi_fonts/flexi_fonts.dart';

/// This class provides a list of local fonts to be used with FlexiFonts
class LocalFonts {
  /// Get a list of local font options
  static List<FontOption> getLocalFonts() {
    return [
      // Actual local Kurdish fonts
      const FontOption(
        fontFamily: 'Rabar',
        isGoogleFont: false,  // This is a local font
        category: FontCategory.sansSerif,
        displayName: 'Rabar',
        sampleText: 'ئەمە نموونەیەکە بۆ فۆنتی ڕابەر',
      ),
      const FontOption(
        fontFamily: 'SarchiaAbdulrahman',
        isGoogleFont: false,  // This is a local font
        category: FontCategory.serif,
        displayName: 'Sarchia Abdulrahman',
        sampleText: 'ئەمە نموونەیەکە بۆ فۆنتی سەرچیا عەبدولڕەحمان',
      ),
      
      // Some Google Fonts for comparison
      const FontOption(
        fontFamily: 'Noto Sans Arabic',
        isGoogleFont: true,
        category: FontCategory.sansSerif,
        displayName: 'Noto Sans Arabic (Google)',
        sampleText: 'ئەمە نموونەیەکە بۆ فۆنتی نۆتۆ سانس',
      ),
      const FontOption(
        fontFamily: 'Montserrat',
        isGoogleFont: true,
        category: FontCategory.sansSerif,
        displayName: 'Montserrat (Google)',
        sampleText: 'This is a sample text for Montserrat font',
      ),
    ];
  }
}