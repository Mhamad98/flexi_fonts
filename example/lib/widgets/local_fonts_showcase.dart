import 'package:flutter/material.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import '../local_fonts.dart';

/// A widget that showcases local fonts
class LocalFontsShowcase extends StatelessWidget {
  final FlexiFontController fontController;
  final bool isKurdish;

  const LocalFontsShowcase({
    super.key,
    required this.fontController,
    this.isKurdish = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localFonts = LocalFonts.getLocalFonts();

    // Filter fonts based on language
    final filteredFonts = localFonts.where((font) {
      if (isKurdish) {
        return font.sampleText.contains('ئەمە') ||
            font.fontFamily.contains('Kurdish') ||
            font.fontFamily == 'Rabar' ||
            font.fontFamily == 'SarchiaAbdulrahman';
      } else {
        return !font.sampleText.contains('ئەمە') &&
            !font.fontFamily.contains('Kurdish') &&
            font.fontFamily != 'Rabar' &&
            font.fontFamily != 'SarchiaAbdulrahman';
      }
    }).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.font_download_outlined, color: colorScheme.primary),
                const SizedBox(width: 8.0),
                Text(
                  isKurdish ? 'فۆنتە لۆکاڵییەکان' : 'Local Fonts',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24.0),

            // Local fonts list
            ...filteredFonts.map((font) => _buildFontSample(font, context)),

            // Instructions
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: colorScheme.outline.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isKurdish
                        ? 'چۆن فۆنتی لۆکاڵی بەکاربهێنین:'
                        : 'How to use local fonts:',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    isKurdish
                        ? '١. فایلی فۆنتەکان زیاد بکە بۆ پڕۆژەکەت\n'
                            '٢. لە فایلی pubspec.yaml دا تۆماریان بکە\n'
                            '٣. FontOption دروست بکە بۆ هەر فۆنتێک\n'
                            '٤. isGoogleFont: false دابنێ'
                        : '1. Add font files to your project\n'
                            '2. Register them in pubspec.yaml\n'
                            '3. Create FontOption for each font\n'
                            '4. Set isGoogleFont: false',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    isKurdish
                        ? 'تێبینی: فۆنتەکانی ڕابەر و سەرچیا عەبدولڕەحمان فۆنتی لۆکاڵین'
                        : 'Note: Rabar and Sarchia Abdulrahman are local fonts',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSample(FontOption font, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          fontController.setFont(font);
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: fontController.selectedFont?.fontFamily == font.fontFamily
                ? colorScheme.primaryContainer
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: fontController.selectedFont?.fontFamily == font.fontFamily
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.text_fields,
                    size: 16,
                    color: fontController.selectedFont?.fontFamily ==
                            font.fontFamily
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      font.displayName ?? font.fontFamily,
                      style: TextStyle(
                        fontFamily: font.fontFamily,
                        fontWeight: FontWeight.bold,
                        color: fontController.selectedFont?.fontFamily ==
                                font.fontFamily
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (fontController.selectedFont?.fontFamily ==
                      font.fontFamily)
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                ],
              ),
              const SizedBox(height: 8.0),
              Directionality(
                textDirection:
                    isKurdish ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  font.sampleText,
                  style: TextStyle(
                    fontFamily: font.fontFamily,
                    fontSize: 14.0,
                    color: fontController.selectedFont?.fontFamily ==
                            font.fontFamily
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
