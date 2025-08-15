import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_component_theme.dart';
import 'theme_factory.dart';

final themeTypeProvider = StateProvider<AppThemeType>((ref) => AppThemeType.material);

final componentThemeProvider = Provider<AppComponentTheme>((ref) {
  final type = ref.watch(themeTypeProvider);
  return ThemeFactory.getTheme(type);
});
