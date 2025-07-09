import 'package:flutter/material.dart';

class CustomColor {
  late final MaterialColor _color;
  CustomColor(Color color) {
    _color = _generateMaterialColor(color);
  }

  MaterialColor get color => _color;

  MaterialColor _generateMaterialColor(Color color) {
    return MaterialColor(color.toARGB32(), {
      50: _tintColor(color, 0.9),
      100: _tintColor(color, 0.8),
      200: _tintColor(color, 0.6),
      300: _tintColor(color, 0.4),
      400: _tintColor(color, 0.2),
      500: color,
      600: _shadeColor(color, 0.1),
      700: _shadeColor(color, 0.2),
      800: _shadeColor(color, 0.3),
      900: _shadeColor(color, 0.4),
    });
  }

  Color _tintColor(Color color, double factor) => Color.fromRGBO(
    (color.r + ((255 - color.r) * factor)).round(),
    (color.g + ((255 - color.g) * factor)).round(),
    (color.b + ((255 - color.b) * factor)).round(),
    1,
  );

  Color _shadeColor(Color color, double factor) => Color.fromRGBO(
    (color.r * (1 - factor)).round(),
    (color.g * (1 - factor)).round(),
    (color.b * (1 - factor)).round(),
    1,
  );
}
