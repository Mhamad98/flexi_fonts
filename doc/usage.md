# FlexiFonts Usage Guide

This guide explains how to use the FlexiFonts package in your Flutter application.

## Basic Setup

### 1. Add the package to your pubspec.yaml

```yaml
dependencies:
  flexi_fonts: ^0.1.0
```

### 2. Initialize the controller

In your `main.dart` file, initialize the FlexiFontController:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flexi_fonts/flexi_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the FlexiFontController
  final fontController = FlexiFontController();
  await fontController.initialize();
  
  runApp(
    ChangeNotifierProvider.value(
      value: fontController,
      child: const MyApp(),
    ),
  );
}
```

### 3. Apply the font to your app's theme

In your `MyApp` widget, apply the selected font to your theme:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final fontController = Provider.of<FlexiFontController>(context);
    
    return MaterialApp(
      title: 'FlexiFonts Demo',
      theme: fontController.applyToTheme(
        ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
```

## Adding the Font Selector

Add the `FlexiFontSelectorWidget` to your app to allow users to select fonts:

```dart
FlexiFontSelectorWidget(
  title: 'Choose a Font',
  showFontScaleSlider: true,
  groupByCategory: true,
  showSearch: true,
)
```

You can add this widget to a dialog, a drawer, or a dedicated screen in your app.

## Applying Fonts to Specific Text

You can apply the selected font to specific text using the controller:

```dart
Text(
  'This text uses the selected font',
  style: fontController.getTextStyle(
    baseStyle: TextStyle(fontSize: 16.0),
  ),
)
```

## Advanced Usage

### Custom Fonts

You can add custom fonts to the controller:

```dart
fontController.addFont(
  FontOption(
    fontFamily: 'MyCustomFont',
    isGoogleFont: false,
    category: FontCategory.serif,
  ),
);
```

### Font Categories

Group fonts by category in the selector:

```dart
FlexiFontSelectorWidget(
  groupByCategory: true,
)
```

### RTL Support

The package supports RTL languages like Arabic and Kurdish:

```dart
Directionality(
  textDirection: TextDirection.rtl,
  child: Text(
    'هذا النص هو مثال لنص يمكن أن يستبدل',
    style: fontController.getTextStyle(),
  ),
)
```

### Font Scaling

Allow users to adjust the font scale:

```dart
FlexiFontSelectorWidget(
  showFontScaleSlider: true,
)
```

## Complete Example

See the `example` folder for a complete working example of the FlexiFonts package.