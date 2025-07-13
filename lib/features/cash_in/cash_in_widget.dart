import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/components/app_button.dart';
import '../../core/components/app_text_button.dart';
import '../../core/components/app_text_field.dart';
import '../../core/components/choice_chips.dart';
import '../../core/config.dart';
import '../../core/widgets/category_modal.dart';
import '../../providers/category_provider.dart';
import '../../providers/form_provider.dart';

class CashInWidget extends ConsumerStatefulWidget {
  const CashInWidget({super.key});

  @override
  ConsumerState<CashInWidget> createState() => _CashInWidgetState();
}

class _CashInWidgetState extends ConsumerState<CashInWidget> {
  void onChoiceChanged(String choice) {
    ref.read(formProvider.notifier).setPaymentMethod(choice);
  }

  void onSave() async {
    final formState = ref.read(formProvider);

    if (formState.category == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a category')));
      return;
    }

    if (formState.subcategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a subcategory')));
      return;
    }

    if (formState.amount == null || formState.amount!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter an amount')));
      return;
    }

    if (formState.paymentMethod == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a payment method')));
      return;
    }

    await ref.read(formProvider.notifier).cashIn();
    if (mounted && Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    ref.read(categoryProvider.notifier).fetchAll();
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setAmount(value);
                      },
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
                                      .addCategory(value);
                                }
                              });
                            },
                            labelText: '+ Add',
                          ),
                        ],
                      ),
                    ),
                    ChoiceChips(
                      choices: categoryState.categoriesMap.keys.toList(),
                      selectedChoice: formState.category,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setCategory(value);
                      },
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text('Subcategory *', style: textTheme.labelSmall),
                          Spacer(),
                          AppTextButton.small(
                            onPressed: () {
                              if (formState.category == null) {
                                return;
                              }
                              showCategoryModal(context).then((value) {
                                if (value != null) {
                                  ref
                                      .read(categoryProvider.notifier)
                                      .addSubcategory(
                                        formState.category!,
                                        value,
                                      );
                                }
                              });
                            },
                            labelText: '+ Add',
                          ),
                        ],
                      ),
                    ),
                    ChoiceChips(
                      choices:
                          categoryState.categoriesMap[formState.category] ?? [],
                      selectedChoice: formState.subcategory,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setSubcategory(value);
                      },
                    ),
                    SizedBox(height: 24),
                    Text('Payment Method', style: textTheme.labelSmall),
                    SizedBox(height: 8),
                    ChoiceChips(
                      selectedChoice: formState.paymentMethod,
                      choices: Config.paymentMethods,
                      onChanged: onChoiceChanged,
                    ),
                    SizedBox(height: 24),
                    Text('Notes', style: textTheme.labelSmall),
                    SizedBox(height: 4),
                    AppInputField(
                      labelText: 'Notes',
                      hintText: 'Notes',
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setNotes(value);
                      },
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
