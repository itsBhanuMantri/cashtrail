import 'app_component_theme.dart';
import 'claymorphism/claymorphism_component_theme.dart';
import 'material/material_component_theme.dart';

class ThemeFactory {
  static AppComponentTheme getTheme(AppThemeType type) {
    switch (type) {
      case AppThemeType.claymorphism:
        return ClaymorphismComponentTheme();
      case AppThemeType.material:
        return MaterialComponentTheme();
    }
  }
}
