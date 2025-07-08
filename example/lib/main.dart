import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';
import 'home_page.dart';
import 'local_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the FlexiFontController with a font that works well with Kurdish
  final fontController = FlexiFontController();
  
  // Get local fonts
  final localFonts = LocalFonts.getLocalFonts();
  
  await fontController.initialize(
    defaultFont: const FontOption(fontFamily: 'Noto Sans Arabic', isGoogleFont: true),
    includeGoogleFonts: true,
    customFonts: [
      // Add local fonts
      ...localFonts,
      
      // Add fonts that work well with Kurdish
      const FontOption(fontFamily: 'Noto Sans Arabic', isGoogleFont: true),
      const FontOption(fontFamily: 'Noto Naskh Arabic', isGoogleFont: true),
      const FontOption(fontFamily: 'Amiri', isGoogleFont: true),
      const FontOption(fontFamily: 'Scheherazade New', isGoogleFont: true),
      const FontOption(fontFamily: 'Lateef', isGoogleFont: true),
      const FontOption(fontFamily: 'Tajawal', isGoogleFont: true),
      const FontOption(fontFamily: 'Cairo', isGoogleFont: true),
      const FontOption(fontFamily: 'Almarai', isGoogleFont: true),
    ],
  );
  
  runApp(
    ChangeNotifierProvider.value(
      value: fontController,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller from the provider
    final fontController = Provider.of<FlexiFontController>(context);
    
    // Apply the selected font to the theme
    return MaterialApp(
      title: 'FlexiFonts Kurdish Demo',
      theme: fontController.applyToTheme(
        ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50), // Kurdish flag green
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
      ),
      darkTheme: fontController.applyToTheme(
        ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50), // Kurdish flag green
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(title: 'فلێکسی فۆنت'),
    );
  }
}