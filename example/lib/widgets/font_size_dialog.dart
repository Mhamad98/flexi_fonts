import 'package:flutter/material.dart';
import 'package:flexi_fonts/flexi_fonts.dart';

/// Shows a dialog to adjust the font size
class FontSizeDialog {
  static void show(BuildContext context, FlexiFontController controller, bool isKurdish) {
    final colorScheme = Theme.of(context).colorScheme;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isKurdish ? 'گۆڕینی قەبارەی فۆنت' : 'Adjust Font Size'),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        content: StatefulBuilder(
          builder: (context, setState) => Directionality(
            textDirection: isKurdish ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    isKurdish ? 'نموونەی دەق' : 'Sample Text',
                    style: TextStyle(
                      fontSize: 16 * controller.fontScale,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(Icons.text_decrease, 
                      color: colorScheme.primary,
                      size: 20,
                    ),
                    Expanded(
                      child: FontScaleSlider(
                        value: controller.fontScale,
                        onChanged: (value) {
                          controller.setFontScale(value);
                          setState(() {});
                        },
                        label: isKurdish ? 'قەبارەی فۆنت' : 'Font Size',
                      ),
                    ),
                    Icon(Icons.text_increase, 
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  isKurdish 
                      ? '${(controller.fontScale * 100).round()}٪'
                      : '${(controller.fontScale * 100).round()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isKurdish ? 'داخستن' : 'Close',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: Text(isKurdish ? 'پاشەکەوتکردن' : 'Save'),
          ),
        ],
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
    );
  }
}