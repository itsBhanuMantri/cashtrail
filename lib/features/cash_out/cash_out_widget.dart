import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/components/app_button.dart';
import '../../core/components/app_text_button.dart';
import '../../core/components/app_text_field.dart';
import '../../core/components/choice_chips.dart';
import '../../core/config.dart';
import '../../core/widgets/category_dialog.dart';
import '../../providers/category_provider.dart';
import '../../providers/form_provider.dart';

class CashOutWdiget extends ConsumerStatefulWidget {
  const CashOutWdiget({super.key});

  @override
  ConsumerState<CashOutWdiget> createState() => _CashOutWidgetState();
}

class _CashOutWidgetState extends ConsumerState<CashOutWdiget> {
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
      backgroundColor: Color(0xffe8e8e8),
      appBar: AppBar(title: Text('Cash Out')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount *', style: textTheme.labelSmall),
                    SizedBox(height: 4),
                    AppInputField(
                      labelText: 'Amount *',
                      hintText: 'Amount',
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text('Category *', style: textTheme.labelSmall),
                          Spacer(),
                          AppTextButton.small(
                            onPressed: () {
                              showCategoryModal(context).then((value) {
                                if (value != null) {
                                  ref
                                      .read(categoryProvider.notifier)
                                      .add(value);
                                }
                              });
                            },
                            labelText: '+ Add',
                          ),
                        ],
                      ),
                    ),
                    ChoiceChips(
                      choices: categoryState.categories,
                      selectedChoice: formState.category,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).selectCategory(value);
                      },
                    ),
                    SizedBox(height: 24),
                    Text('Notes', style: textTheme.labelSmall),
                    SizedBox(height: 4),
                    AppInputField(
                      labelText: 'Notes',
                      hintText: 'Notes',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 24),
                    Text('Payment Method', style: textTheme.labelSmall),
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
                Expanded(child: AppButton(label: 'Save', onPressed: onSave)),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
