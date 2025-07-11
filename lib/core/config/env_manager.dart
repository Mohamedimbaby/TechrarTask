import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvManager {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');

    } catch (e) {
      debugPrint('Error loading environment files: $e');
    }
  }

  // API Configuration
  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'https://api.default.com';
  static String get apiVersion => dotenv.env['API_VERSION'] ?? 'v1';

  // Theme Configuration
  static Color get primaryColor =>
      Color(int.parse(dotenv.env['PRIMARY_COLOR'] ?? '0xFF6200EE'));
  static Color get secondaryColor =>
      Color(int.parse(dotenv.env['SECONDARY_COLOR'] ?? '0xFF03DAC6'));
  static Color get errorColor =>
      Color(int.parse(dotenv.env['ERROR_COLOR'] ?? '0xFFB00020'));

  // Asset Paths
  static String get imagesPath => dotenv.env['IMAGES_PATH'] ?? 'assets/images';
  static String get logoPath =>
      dotenv.env['LOGO_PATH'] ?? '$imagesPath/logo.png';
  static String get defaultAvatarPath =>
      dotenv.env['DEFAULT_AVATAR_PATH'] ?? '$imagesPath/default_avatar.png';

  // Feature Flags
  static bool get enableAnalytics =>
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';
  static bool get enableCrashReporting =>
      dotenv.env['ENABLE_CRASH_REPORTING']?.toLowerCase() == 'true';

  // Cache Configuration
  static int get cacheDurationMinutes =>
      int.parse(dotenv.env['CACHE_DURATION_MINUTES'] ?? '30');
  static int get maxCacheSizeMb =>
      int.parse(dotenv.env['MAX_CACHE_SIZE_MB'] ?? '100');

  // Network Configuration
  static int get timeoutSeconds =>
      int.parse(dotenv.env['TIMEOUT_SECONDS'] ?? '30');
  static int get retryAttempts =>
      int.parse(dotenv.env['RETRY_ATTEMPTS'] ?? '3');

  // App Configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'TechRar';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static String get buildNumber => dotenv.env['BUILD_NUMBER'] ?? '1';
}
