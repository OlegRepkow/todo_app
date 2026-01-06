import 'package:flutter/material.dart';
import 'package:todo_app/api/todo_api.dart';
import '../themes/app_theme.dart';
import '../services/storage_service.dart';
import '../models/app_colors_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(this._api, this._storage) {
    _loadInitialTheme();
    _initializeTheme();
  }

  final TodoApi _api;
  final StorageService _storage;
  bool _isDarkMode = false;
  AppColors? _lightColors;
  AppColors? _darkColors;
  bool _isLoading = true;

  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;

  AppColors get lightColors => _lightColors ?? AppColors.defaultLight();
  AppColors get darkColors => _darkColors ?? AppColors.defaultDark();

  void _loadInitialTheme() {
    final cachedIsDarkMode = _storage.getIsDarkMode();
    if (cachedIsDarkMode != null) {
      _isDarkMode = cachedIsDarkMode;
    }
    _loadColorsFromCache();
    _isLoading = false;
  }

  AppThemeConfig get currentThemeConfig =>
      _isDarkMode ? AppThemeDark(this) : AppThemeLight(this);

  Future<void> _initializeTheme() async {
    await _loadThemeFromApi();
    notifyListeners();
  }

  void _loadColorsFromCache() {
    final cachedThemeJson = _storage.getThemeJson();
    if (cachedThemeJson != null) {
      try {
        final theme =
            AppColorsModel.fromJson(Map<String, dynamic>.from(cachedThemeJson));
        _lightColors = _convertToAppColors(theme.light);
        _darkColors = _convertToAppColors(theme.dark);
      } catch (e) {
        _setDefaultColors();
      }
    } else {
      _setDefaultColors();
    }
  }

  void _setDefaultColors() {
    _lightColors = AppColors.defaultLight();
    _darkColors = AppColors.defaultDark();
  }

  Future<void> _loadThemeFromApi() async {
    try {
      final theme = await _api.getTheme();
      _lightColors = _convertToAppColors(theme.light);
      _darkColors = _convertToAppColors(theme.dark);
      await _storage.saveThemeJson(theme.toJson());
    } catch (e) {
      // Keep current colors on error
    }
  }

  AppColors _convertToAppColors(AppColorsData data) {
    return AppColors(
      primary: data.primary,
      onPrimary: data.onPrimary,
      surface: data.surface,
      onSurface: data.onSurface,
      background: data.background,
      todoCardBg: data.todoCardBg,
      todoCardShadow: data.todoCardShadow,
      inputFillColor: data.inputFillColor,
      completedTodoColor: data.completedTodoColor,
      inProgressTodoColor: data.inProgressTodoColor,
      errorColor: data.errorColor,
      emptyStateIcon: data.emptyStateIcon,
      emptyStateText: data.emptyStateText,
      emptyStateSecondaryText: data.emptyStateSecondaryText,
      completedText: data.completedText,
      divider: data.divider,
    );
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _storage.saveIsDarkMode(_isDarkMode);
    notifyListeners();
  }

  ThemeData getThemeData() {
    final colors = _isDarkMode ? darkColors : lightColors;

    return ThemeData(
      useMaterial3: true,
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
    ).copyWith(extensions: [colors]);
  }
}
