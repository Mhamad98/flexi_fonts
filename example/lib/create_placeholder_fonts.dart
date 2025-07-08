// This is a simple script to create placeholder font files
// Run this with: dart create_placeholder_fonts.dart

// ignore_for_file: avoid_print

import 'dart:io';

void main() async {
  // Create the fonts directory if it doesn't exist
  final fontsDir = Directory('assets/fonts');
  if (!await fontsDir.exists()) {
    await fontsDir.create(recursive: true);
  }

  // List of font files to create
  final fontFiles = [
    // Kurdish fonts
    'NotoSansArabicKurdish-Regular.ttf',
    'NotoSansArabicKurdish-Bold.ttf',
    'Rabar-Regular.ttf',
    'Rabar-Bold.ttf',
    'Unikurd-Regular.ttf',
    'Unikurd-Bold.ttf',
    
    // English fonts
    'Montserrat-Regular.ttf',
    'Montserrat-Bold.ttf',
    'Montserrat-Italic.ttf',
    'PlayfairDisplay-Regular.ttf',
    'PlayfairDisplay-Bold.ttf',
    'PlayfairDisplay-Italic.ttf',
    'FiraCode-Regular.ttf',
    'FiraCode-Bold.ttf',
  ];

  // Create each font file with a small amount of data
  for (final fontFile in fontFiles) {
    final file = File('assets/fonts/$fontFile');
    if (!await file.exists()) {
      await file.writeAsBytes([0, 1, 2, 3, 4]); // Just some placeholder bytes
      print('Created placeholder font: $fontFile');
    }
  }

  print('All placeholder fonts created successfully!');
}