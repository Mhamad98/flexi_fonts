import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/font_option.dart';

/// Abstract class for storage providers
abstract class StorageProvider {
  /// Save a string value
  Future<bool> saveString(String key, String value);
  
  /// Save a boolean value
  Future<bool> saveBool(String key, bool value);
  
  /// Save a double value
  Future<bool> saveDouble(String key, double value);
  
  /// Get a string value
  Future<String?> getString(String key);
  
  /// Get a boolean value
  Future<bool?> getBool(String key);
  
  /// Get a double value
  Future<double?> getDouble(String key);
  
  /// Remove a value
  Future<bool> remove(String key);
}

/// Implementation of StorageProvider using SharedPreferences
class SharedPreferencesStorage implements StorageProvider {
  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
  
  @override
  Future<bool> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }
  
  @override
  Future<bool> saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }
  
  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  
  @override
  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
  
  @override
  Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }
  
  @override
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

/// Utility class for font storage operations
class FontStorageUtils {
  /// Key for storing font family
  static const String fontFamilyKey = 'flexi_fonts_selected_font_family';
  
  /// Key for storing font scale
  static const String fontScaleKey = 'flexi_fonts_font_scale';
  
  /// Key for storing whether the font is a Google Font
  static const String isGoogleFontKey = 'flexi_fonts_is_google_font';
  
  /// Storage provider
  final StorageProvider _storage;
  
  /// Constructor
  FontStorageUtils({StorageProvider? storage})
      : _storage = storage ?? SharedPreferencesStorage();
  
  /// Save font option
  Future<bool> saveFont(FontOption font) async {
    try {
      await _storage.saveString(fontFamilyKey, font.fontFamily);
      await _storage.saveBool(isGoogleFontKey, font.isGoogleFont);
      return true;
    } catch (e) {
      debugPrint('Error saving font: $e');
      return false;
    }
  }
  
  /// Save font scale
  Future<bool> saveFontScale(double scale) async {
    try {
      return await _storage.saveDouble(fontScaleKey, scale);
    } catch (e) {
      debugPrint('Error saving font scale: $e');
      return false;
    }
  }
  
  /// Load font family
  Future<String?> loadFontFamily() async {
    try {
      return await _storage.getString(fontFamilyKey);
    } catch (e) {
      debugPrint('Error loading font family: $e');
      return null;
    }
  }
  
  /// Load whether the font is a Google Font
  Future<bool> loadIsGoogleFont() async {
    try {
      return await _storage.getBool(isGoogleFontKey) ?? true;
    } catch (e) {
      debugPrint('Error loading isGoogleFont: $e');
      return true;
    }
  }
  
  /// Load font scale
  Future<double> loadFontScale() async {
    try {
      return await _storage.getDouble(fontScaleKey) ?? 1.0;
    } catch (e) {
      debugPrint('Error loading font scale: $e');
      return 1.0;
    }
  }
  
  /// Reset all font settings
  Future<bool> resetFontSettings() async {
    try {
      await _storage.remove(fontFamilyKey);
      await _storage.remove(fontScaleKey);
      await _storage.remove(isGoogleFontKey);
      return true;
    } catch (e) {
      debugPrint('Error resetting font settings: $e');
      return false;
    }
  }
}

// Note: This is a placeholder for future Hive implementation
// To use Hive, you would create a HiveStorage class that implements StorageProvider
/*
class HiveStorage implements StorageProvider {
  // Hive implementation would go here
}
*/