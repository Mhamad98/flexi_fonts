import 'package:flutter/material.dart';
import 'package:flexi_fonts/flexi_fonts.dart';

/// A card that displays the current font information
class FontInfoCard extends StatelessWidget {
  final FlexiFontController fontController;
  final bool isKurdish;
  final VoidCallback onChangeTap;

  const FontInfoCard({
    super.key,
    required this.fontController,
    required this.isKurdish,
    required this.onChangeTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.font_download, 
                  color: colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isKurdish 
                        ? 'فۆنتی ئێستا: ${fontController.selectedFont?.fontFamily ?? 'بنەڕەتی'}'
                        : 'Current Font: ${fontController.selectedFont?.fontFamily ?? 'Default'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isKurdish
                        ? 'قەبارە: ${(fontController.fontScale * 100).round()}٪'
                        : 'Scale: ${(fontController.fontScale * 100).round()}%',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: Text(isKurdish ? 'گۆڕین' : 'Change'),
              onPressed: onChangeTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}