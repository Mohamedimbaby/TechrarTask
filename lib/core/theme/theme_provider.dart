import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techrar_task/core/config/dependency_injection.dart';

part 'theme_provider.g.dart';

const String _themePrefsKey = 'isDarkMode';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  bool build() {
    // Read initial theme from SharedPreferences
    final prefs = getIt<SharedPreferences>();
    return prefs.getBool(_themePrefsKey) ?? false;
  }

  Future<void> toggleTheme() async {
    final prefs = getIt<SharedPreferences>();
    state = !state;
    await prefs.setBool(_themePrefsKey, state);
  }
}
