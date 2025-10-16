import 'package:flutter/material.dart';

import '../app_component_theme.dart';

class MaterialComponentTheme implements AppComponentTheme {
  @override
  Widget buildButton({required Widget child, VoidCallback? onPressed}) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }

  @override
  Widget buildTextField({TextEditingController? controller}) {
    return TextField(controller: controller);
  }

  @override
  Widget buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Checkbox(value: value, onChanged: onChanged);
  }
}
