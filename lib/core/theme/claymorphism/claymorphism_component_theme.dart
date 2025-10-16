import 'package:flutter/material.dart';

import '../app_component_theme.dart';

class ClaymorphismComponentTheme implements AppComponentTheme {
  BoxDecoration getClayDecoration() => BoxDecoration(
    color: Color(0xFFE0E0E0),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(color: Colors.white, offset: Offset(-5, -5), blurRadius: 10),
      BoxShadow(color: Colors.black12, offset: Offset(5, 5), blurRadius: 10),
    ],
  );

  @override
  Widget buildButton({required Widget child, VoidCallback? onPressed}) {
    return Container(
      decoration: getClayDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTextField({TextEditingController? controller}) {
    return Container(
      decoration: getClayDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  @override
  Widget buildCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Checkbox(value: value, onChanged: onChanged); // Customize if needed
  }
}
