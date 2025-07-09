import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

class ChoiceChips extends StatelessWidget {
  const ChoiceChips({
    super.key,
    required this.choices,
    required this.selectedChoice,
    required this.onChanged,
  });
  final List<String> choices;
  final String? selectedChoice;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ...choices.map(
          (choice) => MyChoiceChip(
            choice: choice,
            isSelected: choice == selectedChoice,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class MyChoiceChip extends StatelessWidget {
  const MyChoiceChip({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.onChanged,
  });
  final String choice;
  final bool isSelected;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (isSelected) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1, 1),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: InnerShadow(
          shadows: [
            Shadow(
              color: Colors.indigo.shade400,
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
            Shadow(
              color: Colors.indigo.shade800,
              blurRadius: 4,
              offset: Offset(-4, -4),
            ),
          ],
          child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              choice,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(16),
              // border: Border.all(color: Colors.teal, width: 2),
            ),
            child: Text(
              choice,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          onChanged(choice);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(16),
            // border: Border.all(color: Colors.teal, width: 2),
          ),
          child: Text(
            choice,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
