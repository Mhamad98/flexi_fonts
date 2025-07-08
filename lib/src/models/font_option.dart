
/// Enum representing different font categories
enum FontCategory {
  sansSerif,
  serif,
  display,
  handwriting,
  monospace,
}

/// Class representing a font option with its properties
class FontOption {
  /// The font family name
  final String fontFamily;
  
  /// Whether this font is from Google Fonts
  final bool isGoogleFont;
  
  /// The category of the font
  final FontCategory category;
  
  /// Optional display name (if different from fontFamily)
  final String? displayName;
  
  /// Sample text to display in the preview
  final String sampleText;
  
  /// Constructor
  const FontOption({
    required this.fontFamily,
    this.isGoogleFont = true,
    this.category = FontCategory.sansSerif,
    this.displayName,
    this.sampleText = 'The quick brown fox jumps over the lazy dog',
  });
  
  /// Get the display name (falls back to fontFamily if not set)
  String get name => displayName ?? fontFamily;
  
  /// Create a copy of this FontOption with some fields replaced
  FontOption copyWith({
    String? fontFamily,
    bool? isGoogleFont,
    FontCategory? category,
    String? displayName,
    String? sampleText,
  }) {
    return FontOption(
      fontFamily: fontFamily ?? this.fontFamily,
      isGoogleFont: isGoogleFont ?? this.isGoogleFont,
      category: category ?? this.category,
      displayName: displayName ?? this.displayName,
      sampleText: sampleText ?? this.sampleText,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FontOption && other.fontFamily == fontFamily;
  }
  
  @override
  int get hashCode => fontFamily.hashCode;
}