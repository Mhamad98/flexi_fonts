# Migration Guide

This document provides guidance for migrating between different versions of the FlexiFonts package.

## Migrating to 0.2.0 (Future)

### Hive Storage Support

In version 0.2.0, we plan to add support for Hive as an alternative storage provider. To use Hive instead of SharedPreferences:

```dart
// Initialize Hive
await Hive.initFlutter();

// Create a HiveStorageProvider
final hiveStorage = HiveStorageProvider();

// Pass it to the FlexiFontController
final fontController = FlexiFontController(storageProvider: hiveStorage);
await fontController.initialize();
```

### Enhanced Font Categories

Version 0.2.0 will include more detailed font categorization. The `FontCategory` enum will be expanded with additional categories:

```dart
enum FontCategory {
  sansSerif,
  serif,
  display,
  handwriting,
  monospace,
  decorative,
  script,
  blackletter,
  // New categories
  geometric,
  humanist,
  oldStyle,
  slab,
}
```

To migrate, you may need to update any code that relies on the specific enum values.

### Font Size Controls

Version 0.2.0 will include more advanced font size controls:

```dart
FlexiFontSelectorWidget(
  showFontSizeControls: true,
  minFontSize: 12.0,
  maxFontSize: 24.0,
  fontSizeStep: 1.0,
)
```

## Migrating to 0.1.0 (Current)

This is the initial release of the FlexiFonts package. No migration is necessary.