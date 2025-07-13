import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/components/app_button.dart';
import '../../core/components/app_text_field.dart';
import '../../core/components/cash_in_button.dart';
import '../../core/components/cash_out_button.dart';
import '../../core/components/choice_chips.dart';

class KitchenSink extends StatelessWidget {
  const KitchenSink({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Kitchen Sink')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Primary Button'),
                SizedBox(height: 4),
                AppButton(onPressed: () {}, label: 'Primary Button'),
                SizedBox(height: 16),
                Text('Cash in Button'),
                SizedBox(height: 4),
                CashInButton(),
                SizedBox(height: 16),
                Text('Cash out Button'),
                SizedBox(height: 4),
                CashOutButton(),
                SizedBox(height: 16),

                // choice chips
                Text('Choice Chips'),
                SizedBox(height: 4),
                ChoiceChipsView(
                  choices: ['Choice 1', 'Choice 2', 'Choice 3'],
                  selectedChoice: 'Choice 1',
                  onChanged: (_) {},
                ),
                SizedBox(height: 16),

                // input field
                Text('Input Fields'),
                SizedBox(height: 4),
                Text('Field with Label', style: textTheme.labelSmall),
                SizedBox(height: 2),
                AppInputField(
                  labelText: 'Input Field',
                  // onChanged: (_) {},
                ),

                SizedBox(height: 4),
                Text('Input dropdown', style: textTheme.labelSmall),
                SizedBox(height: 2),
                AppInputField(
                  readOnly: true,
                  labelText: 'Input Field',
                  // onChanged: (_) {},
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),

                SizedBox(height: 16),

                // fonts
                Text('Fonts'),
                SizedBox(height: 4),
                Text('Body Small', style: textTheme.bodySmall),
                Text('Body Medium', style: textTheme.bodyMedium),
                Text('Body Large', style: textTheme.bodyLarge),
                Text('Label Medium', style: textTheme.labelMedium),
                Text('Label Large', style: textTheme.labelLarge),
                Text('Label Small', style: textTheme.labelSmall),
                Text('Title Large', style: textTheme.titleLarge),
                Text('Title Medium', style: textTheme.titleMedium),
                Text('Title Small', style: textTheme.titleSmall),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceChipsView extends ConsumerStatefulWidget {
  const ChoiceChipsView({
    super.key,
    required this.choices,
    required this.selectedChoice,
    required this.onChanged,
  });
  final List<String> choices;
  final String? selectedChoice;
  final Function(String) onChanged;

  @override
  ConsumerState<ChoiceChipsView> createState() => _ChoiceChipsViewState();
}

class _ChoiceChipsViewState extends ConsumerState<ChoiceChipsView> {
  String? selectedChoice;

  @override
  void initState() {
    super.initState();
    selectedChoice = widget.selectedChoice;
  }

  @override
  Widget build(BuildContext context) {
    return ChoiceChips(
      choices: widget.choices,
      selectedChoice: selectedChoice,
      onChanged: (choice) {
        setState(() {
          selectedChoice = choice;
          widget.onChanged(choice);
        });
      },
    );
  }
}
