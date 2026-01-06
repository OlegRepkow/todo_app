import 'dart:ui';

Color _parseColor(dynamic value) {
  if (value == null) {
    throw const FormatException('Color value is null');
  }

  if (value is int) {
    return Color(value);
  }

  if (value is String) {
    String colorString = value.trim();

    if (colorString.startsWith('0x') || colorString.startsWith('0X')) {
      return Color(int.parse(colorString, radix: 16));
    }

    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
      if (colorString.length == 6) {
        colorString = 'FF$colorString';
      }
      return Color(int.parse(colorString, radix: 16));
    }

    return Color(int.parse(colorString));
  }

  throw FormatException('Invalid color format: $value');
}

int _colorToInt(Color color) {
  return ((color.a * 255).round() << 24) |
      ((color.r * 255).round() << 16) |
      ((color.g * 255).round() << 8) |
      (color.b * 255).round();
}

class AppColorsModel {
  AppColorsModel({required this.light, required this.dark});

  final AppColorsData light;
  final AppColorsData dark;

  factory AppColorsModel.fromJson(Map<String, dynamic> json) => AppColorsModel(
      light: AppColorsData.fromJson(Map<String, dynamic>.from(json['light'])),
      dark: AppColorsData.fromJson(Map<String, dynamic>.from(json['dark'])));

  Map<String, dynamic> toJson() => {
        'light': light.toJson(),
        'dark': dark.toJson(),
      };
}

class AppColorsData {
  AppColorsData(
      {required this.divider,
      required this.primary,
      required this.surface,
      required this.onPrimary,
      required this.onSurface,
      required this.background,
      required this.errorColor,
      required this.todoCardBg,
      required this.completedText,
      required this.emptyStateIcon,
      required this.emptyStateText,
      required this.inputFillColor,
      required this.todoCardShadow,
      required this.completedTodoColor,
      required this.inProgressTodoColor,
      required this.emptyStateSecondaryText});

  final Color divider;
  final Color primary;
  final Color surface;
  final Color onPrimary;
  final Color onSurface;
  final Color background;
  final Color errorColor;
  final Color todoCardBg;
  final Color completedText;
  final Color emptyStateIcon;
  final Color emptyStateText;
  final Color inputFillColor;
  final Color todoCardShadow;
  final Color completedTodoColor;
  final Color inProgressTodoColor;
  final Color emptyStateSecondaryText;

  @override
  String toString() {
    return 'AppColorsData(divider: $divider, primary: $primary, surface: $surface, onPrimary: $onPrimary, onSurface: $onSurface, background: $background, errorColor: $errorColor, todoCardBg: $todoCardBg, completedText: $completedText, emptyStateIcon: $emptyStateIcon, emptyStateText: $emptyStateText, inputFillColor: $inputFillColor, todoCardShadow: $todoCardShadow, completedTodoColor: $completedTodoColor, inProgressTodoColor: $inProgressTodoColor, emptyStateSecondaryText: $emptyStateSecondaryText)';
  }

  factory AppColorsData.fromJson(Map<String, dynamic> json) => AppColorsData(
      divider: _parseColor(json['divider']),
      primary: _parseColor(json['primary']),
      surface: _parseColor(json['surface']),
      onPrimary: _parseColor(json['onPrimary']),
      onSurface: _parseColor(json['onSurface']),
      background: _parseColor(json['background']),
      errorColor: _parseColor(json['errorColor']),
      todoCardBg: _parseColor(json['todoCardBg']),
      completedText: _parseColor(json['completedText']),
      emptyStateIcon: _parseColor(json['emptyStateIcon']),
      emptyStateText: _parseColor(json['emptyStateText']),
      inputFillColor: _parseColor(json['inputFillColor']),
      todoCardShadow: _parseColor(json['todoCardShadow']),
      completedTodoColor: _parseColor(json['completedTodoColor']),
      inProgressTodoColor: _parseColor(json['inProgressTodoColor']),
      emptyStateSecondaryText: _parseColor(json['emptyStateSecondaryText']));

  Map<String, dynamic> toJson() => {
        'divider': _colorToInt(divider),
        'primary': _colorToInt(primary),
        'surface': _colorToInt(surface),
        'onPrimary': _colorToInt(onPrimary),
        'onSurface': _colorToInt(onSurface),
        'background': _colorToInt(background),
        'errorColor': _colorToInt(errorColor),
        'todoCardBg': _colorToInt(todoCardBg),
        'completedText': _colorToInt(completedText),
        'emptyStateIcon': _colorToInt(emptyStateIcon),
        'emptyStateText': _colorToInt(emptyStateText),
        'inputFillColor': _colorToInt(inputFillColor),
        'todoCardShadow': _colorToInt(todoCardShadow),
        'completedTodoColor': _colorToInt(completedTodoColor),
        'inProgressTodoColor': _colorToInt(inProgressTodoColor),
        'emptyStateSecondaryText': _colorToInt(emptyStateSecondaryText),
      };
}
