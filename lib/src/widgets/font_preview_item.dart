import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/font_option.dart';

/// A widget that displays a preview of a font option
class FontPreviewItem extends StatelessWidget {
  /// The font option to preview
  final FontOption fontOption;
  
  /// Whether this font is currently selected
  final bool isSelected;
  
  /// Callback when the font is selected
  final VoidCallback? onTap;
  
  /// Font size for the preview text
  final double previewFontSize;
  
  /// Font scale factor
  final double fontScale;

  /// Constructor
  const FontPreviewItem({
    super.key,
    required this.fontOption,
    this.isSelected = false,
    this.onTap,
    this.previewFontSize = 16.0,
    this.fontScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Font name
            Row(
              children: [
                Expanded(
                  child: Text(
                    fontOption.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0 * fontScale,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18.0 * fontScale,
                  ),
              ],
            ),
            const SizedBox(height: 8.0),
            
            // Font preview with RTL support
            Builder(
              builder: (context) {
                // Simple RTL detection for Arabic, Hebrew, etc.
                final hasRtlChars = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]').hasMatch(fontOption.sampleText);
                return Directionality(
                  textDirection: hasRtlChars ? TextDirection.rtl : TextDirection.ltr,
                  child: Text(
                    fontOption.sampleText,
                    style: _getPreviewTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Get the text style for the preview text
  TextStyle _getPreviewTextStyle() {
    final baseStyle = TextStyle(
      fontSize: previewFontSize * fontScale,
    );
    
    if (fontOption.isGoogleFont) {
      try {
        return GoogleFonts.getFont(
          fontOption.fontFamily,
          textStyle: baseStyle,
        );
      } catch (e) {
        // Fallback to system font if Google Font fails
        return baseStyle.copyWith(fontFamily: fontOption.fontFamily);
      }
    } else {
      return baseStyle.copyWith(fontFamily: fontOption.fontFamily);
    }
  }
}