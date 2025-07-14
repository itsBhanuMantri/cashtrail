import 'package:flutter/material.dart';

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
    print('bhanu: choices $choices');
    if (choices.isEmpty) {
      return SizedBox.shrink();
    }
    print('bhanu: coming here ${choices.length}');
    print('bhanu: coming here ${choices[0]}');
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
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          height: 32,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
            child: Text(
              choice,
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 32,
        child: OutlinedButton(
          onPressed: () {
            onChanged(choice);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            side: BorderSide(color: Colors.indigo, width: 1),
          ),
          child: Text(
            choice,
            style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
