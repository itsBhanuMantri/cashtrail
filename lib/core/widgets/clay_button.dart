import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

class ClayButton extends StatelessWidget {
  final String label;
  final MaterialColor? color;
  final VoidCallback onPressed;

  const ClayButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = this.color ?? Colors.indigo;
    // Colors based on your palette
    return Container(
      decoration: BoxDecoration(
        color: color.shade800,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: InnerShadow(
        shadows: [
          Shadow(color: color.shade400, blurRadius: 8, offset: Offset(8, 8)),
          Shadow(color: color.shade800, blurRadius: 8, offset: Offset(-8, -8)),
        ],
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
