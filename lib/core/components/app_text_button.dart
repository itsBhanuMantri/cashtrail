import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.labelText,
    this.size = 32,
  });

  const AppTextButton.small({
    super.key,
    required this.onPressed,
    required this.labelText,
  }) : size = 12;

  final VoidCallback onPressed;
  final String labelText;
  final double size;

  @override
  Widget build(BuildContext context) {
    final textButtonTheme = Theme.of(context).textButtonTheme;
    final textTheme = Theme.of(context).textTheme;
    if (size == 12) {
      return SizedBox(
        height: 32,
        child: TextButton(
          onPressed: onPressed,
          style: textButtonTheme.style?.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
        style: textTheme.labelSmall?.copyWith(color: Colors.indigo),
      ),
    );
  }
}
