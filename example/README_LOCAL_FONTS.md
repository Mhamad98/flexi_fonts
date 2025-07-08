# Using Local Fonts with FlexiFonts

This guide explains how to use local fonts with the FlexiFonts package in your Flutter application.

> **Note about the example app**: For simplicity, the example app uses Google Fonts to simulate local fonts. In a real application, you would follow the steps below to use actual local font files.

## Step 1: Add Font Files to Your Project

1. Create a fonts directory in your assets folder:
   ```
   assets/
     fonts/
   ```

2. Add your font files to this directory. Make sure to include different weights and styles if available:
   ```
   assets/
     fonts/
       Montserrat-Regular.ttf
       Montserrat-Bold.ttf
       Montserrat-Italic.ttf
       Rabar-Regular.ttf
       Rabar-Bold.ttf
       ...
   ```

## Step 2: Register Fonts in pubspec.yaml

Add your fonts to the `pubspec.yaml` file:

```yaml
flutter:
  uses-material-design: true
  
  fonts:
    - family: Montserrat
      fonts:
        - asset: assets/fonts/Montserrat-Regular.ttf
        - asset: assets/fonts/Montserrat-Bold.ttf
          weight: 700
        - asset: assets/fonts/Montserrat-Italic.ttf
          style: italic
    
    - family: Rabar
      fonts:
        - asset: assets/fonts/Rabar-Regular.ttf
        - asset: assets/fonts/Rabar-Bold.ttf
          weight: 700
```

## Step 3: Create a Font Options List

Create a class to define your local font options:

```dart
import 'package:flexi_fonts/flexi_fonts.dart';

class LocalFonts {
  static List<FontOption> getLocalFonts() {
    return [
      const FontOption(
        fontFamily: 'Montserrat',
        isGoogleFont: false,  // Important: set to false for local fonts
        category: FontCategory.sansSerif,
        displayName: 'Montserrat',
        sampleText: 'This is a sample text for Montserrat font',
      ),
      const FontOption(
        fontFamily: 'Rabar',
        isGoogleFont: false,  // Important: set to false for local fonts
        category: FontCategory.sansSerif,
        displayName: 'Rabar',
        sampleText: 'ئەمە نموونەیەکە بۆ فۆنتی ڕابەر',
      ),
      // Add more fonts as needed
    ];
  }
}
```

## Step 4: Initialize FlexiFontController with Local Fonts

In your main.dart file, initialize the FlexiFontController with your local fonts:

```dart
import 'local_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final fontController = FlexiFontController();
  
  // Get local fonts
  final localFonts = LocalFonts.getLocalFonts();
  
  await fontController.initialize(
    defaultFont: const FontOption(fontFamily: 'Montserrat', isGoogleFont: false),
    includeGoogleFonts: true,  // Set to false if you only want to use local fonts
    customFonts: [
      // Add local fonts
      ...localFonts,
      
      // You can also add Google Fonts
      const FontOption(fontFamily: 'Roboto', isGoogleFont: true),
    ],
  );
  
  runApp(
    ChangeNotifierProvider.value(
      value: fontController,
      child: const MyApp(),
    ),
  );
}
```

## Important Notes

1. **Set `isGoogleFont: false`** for all local fonts. This tells FlexiFonts to use the local font files instead of trying to load them from Google Fonts.

2. **Font Family Names Must Match**: The `fontFamily` in your FontOption must exactly match the `family` name in your pubspec.yaml.

3. **Font Files Must Be Available**: Make sure all the font files referenced in pubspec.yaml are actually in your assets/fonts directory.

4. **Run flutter pub get**: After updating pubspec.yaml, run `flutter pub get` to update your dependencies.

5. **Testing**: Test your app on different devices to ensure the fonts are loading correctly.

## Troubleshooting

If your local fonts aren't working:

1. Check that the font family names match exactly between pubspec.yaml and your FontOption.
2. Verify that `isGoogleFont` is set to `false` for local fonts.
3. Make sure you've run `flutter pub get` after updating pubspec.yaml.
4. Check that the font files are in the correct location.
5. Try cleaning your project with `flutter clean` and then `flutter pub get`.