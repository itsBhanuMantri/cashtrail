import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config.dart';
import '../../core/utils/custom_color.dart';
import '../../core/widgets/category_dialog.dart';
import '../../core/widgets/choice_chips.dart';
import '../../core/widgets/clay_button.dart';
import '../../core/widgets/clay_input_field.dart';
import '../../core/widgets/custom_dropdown_field.dart';
import '../../core/widgets/people_dialog.dart';
import '../../providers/category_provider.dart';
import '../../providers/form_provider.dart';
import '../../providers/people_provider.dart';

class CashOutDialog extends ConsumerStatefulWidget {
  const CashOutDialog({super.key});

  @override
  ConsumerState<CashOutDialog> createState() => _CashOutDialogState();
}

class _CashOutDialogState extends ConsumerState<CashOutDialog> {
  void onChoiceChanged(String choice) {
    ref.read(formProvider.notifier).setPaymentMethod(choice);
  }

  void onSave() async {
    final category = ref.read(categoryProvider).selectedCategory;

    if (category == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a category')));
      return;
    }

    await ref.read(formProvider.notifier).cashOut();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryState = ref.watch(categoryProvider);
    final formState = ref.watch(formProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('CASH OUT')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClayInputField(
                      labelText: 'Amount *',
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                    ),
                    SizedBox(height: 24),
                    CustomDropdownField(
                      labelText: 'Category',
                      optionsWidget: () => CategoryDialog(),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 24),
                    ClayInputField(
                      labelText: 'Notes',
                      autofocus: true,
                      maxLines: 4,
                      minLines: 1,
                    ),
                    SizedBox(height: 24),
                    CustomDropdownField(
                      labelText: 'Given to',
                      optionsWidget: () => PeopleDialog(),
                      onChanged: (value) {
                        ref.read(peopleProvider.notifier).select(value);
                      },
                    ),
                    SizedBox(height: 24),
                    Text('Payment Method', style: textTheme.titleSmall),
                    SizedBox(height: 8),
                    ChoiceChips(
                      selectedChoice: formState.paymentMethod,
                      choices: Config.paymentMethods,
                      onChanged: onChoiceChanged,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ClayButton(
                    label: 'Save',
                    onPressed: onSave,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
