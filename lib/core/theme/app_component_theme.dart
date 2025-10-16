import 'package:flutter/material.dart';

enum AppThemeType { material, claymorphism }

abstract class AppComponentTheme {
  Widget buildButton({required Widget child, VoidCallback? onPressed});
  Widget buildTextField({TextEditingController? controller});
  Widget buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
  });
}
