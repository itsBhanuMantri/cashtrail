import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.size = 32,
  });

  const AppOutlinedButton.small({
    super.key,
    required this.onPressed,
    required this.labelText,
  }) : size = 12;

  final VoidCallback onPressed;
  final String labelText;
  final double size;

  @override
  Widget build(BuildContext context) {
    final outlinedButtonTheme = Theme.of(context).outlinedButtonTheme;
    final textTheme = Theme.of(context).textTheme;
    if (size == 12) {
      return SizedBox(
        height: 32,
        child: OutlinedButton(
          onPressed: onPressed,
          style: outlinedButtonTheme.style?.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
          ),
          child: Text(
            labelText,
            style: textTheme.labelSmall?.copyWith(
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        labelText,
        style: textTheme.labelSmall?.copyWith(color: Colors.indigo),
      ),
    );
  }
}
