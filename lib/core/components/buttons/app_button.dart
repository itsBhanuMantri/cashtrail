import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/providers.dart';

class AppButton extends ConsumerWidget {
  const AppButton({super.key, required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(componentThemeProvider);
    return theme.buildButton(child: Text(label), onPressed: onPressed);
  }
}
