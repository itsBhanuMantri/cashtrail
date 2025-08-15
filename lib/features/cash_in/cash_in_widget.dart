import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/components/buttons/app_button.dart';
import '../../core/components/buttons/app_text_button.dart';
import '../../core/components/app_text_field.dart';
import '../../core/components/choice_chips.dart';
import '../../core/config.dart';
import '../../core/widgets/app_snackbar.dart';
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

    if (formState.amount == null || formState.amount!.isEmpty) {
      AppSnackBar.bad('Please enter an amount');
      return;
    }

    if (formState.category == null) {
      AppSnackBar.bad('Please select a category');
      return;
    }

    if (formState.paymentMethod == null) {
      AppSnackBar.bad('Please select a payment method');
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

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required bool isRequired,
    Widget? action,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.indigo.shade600),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade600,
              ),
            ),
          Spacer(),
          if (action != null) action,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);
    final formState = ref.watch(formProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          final isKeyboardOpen = FocusManager.instance.primaryFocus != null;

          if (isKeyboardOpen) {
            FocusManager.instance.primaryFocus?.unfocus();
          }

          Future.delayed(Duration(milliseconds: 300), () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: Text('Cash In'),
          backgroundColor: Colors.indigo.shade600,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Section
                    _buildSectionHeader(
                      icon: Icons.currency_rupee,
                      title: 'Amount',
                      isRequired: true,
                    ),
                    AppInputField(
                      labelText: 'Enter amount',
                      hintText: '₹ 0.00',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setAmount(value);
                      },
                    ),

                    SizedBox(height: 16),

                    // Category Section
                    _buildSectionHeader(
                      icon: Icons.category_outlined,
                      title: 'Category',
                      isRequired: true,
                      action: AppTextButton.small(
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
                    ),
                    ChoiceChips(
                      choices: categoryState.categoriesMap.keys.toList(),
                      selectedChoice: formState.category,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setCategory(value);
                      },
                    ),

                    SizedBox(height: 16),

                    // Subcategory Section
                    _buildSectionHeader(
                      icon: Icons.subdirectory_arrow_right,
                      title: 'Subcategory',
                      isRequired: false,
                      action: AppTextButton.small(
                        onPressed: () {
                          if (formState.category == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please select a category first'),
                                backgroundColor: Colors.orange.shade600,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            return;
                          }
                          showCategoryModal(context).then((value) {
                            if (value != null) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .addSubcategory(formState.category!, value);
                            }
                          });
                        },
                        labelText: '+ Add',
                      ),
                    ),
                    if (formState.category == null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey.shade600,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Select a category first',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ChoiceChips(
                        choices:
                            categoryState.categoriesMap[formState.category] ??
                            [],
                        selectedChoice: formState.subcategory,
                        onChanged: (value) {
                          ref.read(formProvider.notifier).setSubcategory(value);
                        },
                      ),

                    SizedBox(height: 16),

                    // Payment Method Section
                    _buildSectionHeader(
                      icon: Icons.payment,
                      title: 'Payment Method',
                      isRequired: true,
                    ),
                    ChoiceChips(
                      selectedChoice: formState.paymentMethod,
                      choices: Config.paymentMethods,
                      onChanged: onChoiceChanged,
                    ),

                    SizedBox(height: 16),

                    // Notes Section
                    _buildSectionHeader(
                      icon: Icons.note_outlined,
                      title: 'Notes',
                      isRequired: false,
                    ),
                    AppInputField(
                      labelText: 'Add notes (optional)',
                      hintText: 'Additional details...',
                      maxLines: 2,
                      onChanged: (value) {
                        ref.read(formProvider.notifier).setNotes(value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Save Button - Fixed at bottom
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: Offset(0, -2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: AppButton(
                    onPressed: onSave,
                    label: 'Save Transaction',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
