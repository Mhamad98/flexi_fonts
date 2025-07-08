# FlexiFonts

A Flutter package for dynamically changing app fonts at runtime with Google Fonts integration and persistence.

## Features

✅ Google Fonts integration  
✅ Local font family support  
✅ A widget UI to select fonts  
✅ Live font preview before selection  
✅ Persistent font choice using shared_preferences  
✅ Font scaling (optional) for accessibility  
✅ Easy integration with ThemeData and TextStyle  
✅ RTL (Arabic, Kurdish) and multi-language support  

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flexi_fonts: ^0.1.0
```

## Usage

### Basic Setup

1. Initialize the controller in your `main.dart`:

```dart
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

2. Apply the font to your app's theme:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontController = Provider.of<FlexiFontController>(context);
    
    return MaterialApp(
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

### Adding the Font Selector

Add the `FlexiFontSelectorWidget` to your app:

```dart
FlexiFontSelectorWidget(
  title: 'Choose a Font',
  showFontScaleSlider: true,
  groupByCategory: true,
  showSearch: true,
)
```

### Applying Fonts to Specific Text

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

## Future Enhancements

- Font categories (serif, sans-serif, handwriting)
- Font size control
- Saving in Hive (as an alternative to shared_preferences)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
