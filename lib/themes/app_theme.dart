import 'package:flutter/material.dart';
import 'package:todo_app/providers/theme_provider.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color onPrimary;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color todoCardBg;
  final Color todoCardShadow;
  final Color inputFillColor;
  final Color completedTodoColor;
  final Color inProgressTodoColor;
  final Color errorColor;
  final Color emptyStateIcon;
  final Color emptyStateText;
  final Color emptyStateSecondaryText;
  final Color completedText;
  final Color divider;

  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.todoCardBg,
    required this.todoCardShadow,
    required this.inputFillColor,
    required this.completedTodoColor,
    required this.inProgressTodoColor,
    required this.errorColor,
    required this.emptyStateIcon,
    required this.emptyStateText,
    required this.emptyStateSecondaryText,
    required this.completedText,
    required this.divider,
  });

  factory AppColors.defaultLight() {
    return const AppColors(
      primary: Color(0xFFBB86FC),
      onPrimary: Colors.black,
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF212121),
      background: Color(0xFFF5F5F5),
      todoCardBg: Color(0xFFFFFFFF),
      todoCardShadow: Color(0x40000000),
      inputFillColor: Color(0xFFEEEEEE),
      completedTodoColor: Color(0xFF4CAF50),
      inProgressTodoColor: Color(0xFFFF9800),
      errorColor: Color(0xFFF44336),
      emptyStateIcon: Color(0xFFBDBDBD),
      emptyStateText: Color(0xFF757575),
      emptyStateSecondaryText: Color(0xFF9E9E9E),
      completedText: Color(0xFF9E9E9E),
      divider: Color(0xFFE0E0E0),
    );
  }

  factory AppColors.defaultDark() => const AppColors(
        primary: Color(0xFF0D7377),
        onPrimary: Colors.white,
        surface: Color(0xFF1E1E1E),
        onSurface: Color(0xFFE0E0E0),
        background: Color(0xFF121212),
        todoCardBg: Color(0xFF2C2C2C),
        todoCardShadow: Color(0x80000000),
        inputFillColor: Color(0xFF3A3A3A),
        completedTodoColor: Color(0xFF66BB6A),
        inProgressTodoColor: Color(0xFFFFB74D),
        errorColor: Color(0xFFEF5350),
        emptyStateIcon: Color(0xFF616161),
        emptyStateText: Color(0xFFBDBDBD),
        emptyStateSecondaryText: Color(0xFF9E9E9E),
        completedText: Color(0xFF9E9E9E),
        divider: Color(0xFF424242),
      );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? onSurface,
    Color? background,
    Color? todoCardBg,
    Color? todoCardShadow,
    Color? inputFillColor,
    Color? completedTodoColor,
    Color? inProgressTodoColor,
    Color? errorColor,
    Color? emptyStateIcon,
    Color? emptyStateText,
    Color? emptyStateSecondaryText,
    Color? completedText,
    Color? divider,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      todoCardBg: todoCardBg ?? this.todoCardBg,
      todoCardShadow: todoCardShadow ?? this.todoCardShadow,
      inputFillColor: inputFillColor ?? this.inputFillColor,
      completedTodoColor: completedTodoColor ?? this.completedTodoColor,
      inProgressTodoColor: inProgressTodoColor ?? this.inProgressTodoColor,
      errorColor: errorColor ?? this.errorColor,
      emptyStateIcon: emptyStateIcon ?? this.emptyStateIcon,
      emptyStateText: emptyStateText ?? this.emptyStateText,
      emptyStateSecondaryText:
          emptyStateSecondaryText ?? this.emptyStateSecondaryText,
      completedText: completedText ?? this.completedText,
      divider: divider ?? this.divider,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      background: Color.lerp(background, other.background, t)!,
      todoCardBg: Color.lerp(todoCardBg, other.todoCardBg, t)!,
      todoCardShadow: Color.lerp(todoCardShadow, other.todoCardShadow, t)!,
      inputFillColor: Color.lerp(inputFillColor, other.inputFillColor, t)!,
      completedTodoColor:
          Color.lerp(completedTodoColor, other.completedTodoColor, t)!,
      inProgressTodoColor:
          Color.lerp(inProgressTodoColor, other.inProgressTodoColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      emptyStateIcon: Color.lerp(emptyStateIcon, other.emptyStateIcon, t)!,
      emptyStateText: Color.lerp(emptyStateText, other.emptyStateText, t)!,
      emptyStateSecondaryText: Color.lerp(
          emptyStateSecondaryText, other.emptyStateSecondaryText, t)!,
      completedText: Color.lerp(completedText, other.completedText, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

abstract class AppThemeConfig {
  ThemeData getThemeData();
}

class AppThemeLight implements AppThemeConfig {
  final ThemeProvider themeProvider;

  AppThemeLight(this.themeProvider);

  @override
  ThemeData getThemeData() {
    return themeProvider.getThemeData();
  }
}

class AppThemeDark implements AppThemeConfig {
  final ThemeProvider themeProvider;

  AppThemeDark(this.themeProvider);

  @override
  ThemeData getThemeData() {
    return themeProvider.getThemeData();
  }
}

extension ThemeDataExtension on ThemeData {
  AppColors get appColors => extension<AppColors>() ?? AppColors.defaultLight();
}
