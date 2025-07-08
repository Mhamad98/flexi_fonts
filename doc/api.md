# FlexiFonts API Documentation

## Main Classes

### FlexiFontController

The core class that manages font selection and persistence.

#### Constructor

```dart
FlexiFontController({StorageProvider? storageProvider})
```

- `storageProvider`: Optional custom storage provider for font preferences.

#### Properties

- `selectedFont`: The currently selected font option.
- `fontScale`: The current font scale factor.
- `availableFonts`: List of available font options.
- `isInitialized`: Whether the controller has been initialized.

#### Methods

- `initialize({List<FontOption>? customFonts, FontOption? defaultFont, bool includeGoogleFonts = true})`: Initialize the controller with fonts.
- `setFont(FontOption font)`: Set the selected font.
- `setFontScale(double scale)`: Set the font scale factor.
- `addFont(FontOption font)`: Add a custom font to the available fonts.
- `removeFont(FontOption font)`: Remove a font from the available fonts.
- `getTextStyle({TextStyle? baseStyle})`: Get a TextStyle with the selected font applied.
- `applyToTheme(ThemeData theme)`: Apply the selected font to a ThemeData.
- `resetToDefaults()`: Reset to default font and scale.

### FlexiFontSelectorWidget

A widget that displays a list of available fonts and allows the user to select one.

#### Constructor

```dart
FlexiFontSelectorWidget({
  Key? key,
  String title = 'Select Font',
  bool showFontScaleSlider = true,
  bool groupByCategory = false,
  bool showSearch = true,
  bool showResetButton = true,
  String? sampleText,
  Function(FontOption)? onFontSelected,
})
```

- `title`: Title for the font selector.
- `showFontScaleSlider`: Whether to show the font scale slider.
- `groupByCategory`: Whether to group fonts by category.
- `showSearch`: Whether to show a search field.
- `showResetButton`: Whether to show a reset button.
- `sampleText`: Sample text to display in the preview.
- `onFontSelected`: Callback when a font is selected.

### FontOption

Class representing a font option with its properties.

#### Constructor

```dart
FontOption({
  required String fontFamily,
  bool isGoogleFont = true,
  FontCategory category = FontCategory.sansSerif,
  String? displayName,
  String sampleText = 'The quick brown fox jumps over the lazy dog',
})
```

- `fontFamily`: The font family name.
- `isGoogleFont`: Whether this font is from Google Fonts.
- `category`: The category of the font.
- `displayName`: Optional display name (if different from fontFamily).
- `sampleText`: Sample text to display in the preview.

#### Properties

- `name`: Get the display name (falls back to fontFamily if not set).

#### Methods

- `copyWith({...})`: Create a copy of this FontOption with some fields replaced.

### FontCategory

Enum representing different font categories.

```dart
enum FontCategory {
  sansSerif,
  serif,
  display,
  handwriting,
  monospace,
}
```

## Utility Classes

### FontScaleSlider

A widget that allows the user to adjust the font scale.

#### Constructor

```dart
FontScaleSlider({
  Key? key,
  required double value,
  required ValueChanged<double> onChanged,
  double min = 0.8,
  double max = 1.5,
  int? divisions = 7,
  String? label,
})
```

### FontPreviewItem

A widget that displays a preview of a font option.

#### Constructor

```dart
FontPreviewItem({
  Key? key,
  required FontOption fontOption,
  bool isSelected = false,
  VoidCallback? onTap,
  double previewFontSize = 16.0,
  double fontScale = 1.0,
})
```

### FontCategoryFilter

A widget for filtering fonts by category.

#### Constructor

```dart
FontCategoryFilter({
  Key? key,
  FontCategory? selectedCategory,
  required Function(FontCategory?) onCategorySelected,
  bool showAllOption = true,
})
```