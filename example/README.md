# FlexiFonts Example

This example demonstrates how to use the FlexiFonts package in a Flutter application.

## Features Demonstrated

- Initializing the FlexiFontController
- Applying fonts to the app theme
- Using the FlexiFontSelectorWidget
- Applying fonts to specific text
- Font scaling
- RTL text support

## Running the Example

```bash
cd example
flutter pub get
flutter run
```

## Code Structure

- `main.dart`: Entry point of the application
- `home_page.dart`: Main screen with font selector and examples
- `settings_page.dart`: Settings screen with font options

## Screenshots

(Screenshots will be added here)

## Implementation Details

The example app demonstrates how to:

1. Initialize the FlexiFontController in the main.dart file
2. Provide the controller to the app using Provider
3. Apply the selected font to the app's theme
4. Display the FlexiFontSelectorWidget in a modal bottom sheet
5. Apply the selected font to specific text using getTextStyle()
6. Allow users to adjust the font scale
7. Support RTL text for Arabic and other right-to-left languages
