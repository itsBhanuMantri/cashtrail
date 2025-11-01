import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/components/app_text_field.dart';
import '../../core/components/buttons/app_text_button.dart';
import '../../core/components/choice_chips.dart';
import '../../core/config.dart';
import '../../core/widgets/category_modal.dart';
import '../../db/database.dart';
import '../../providers/category_provider.dart';
import '../../providers/ledger_provider.dart';
import '../../repositories/ledger_repository.dart';

class EditTransactionScreen extends ConsumerStatefulWidget {
  final LedgerData data;
  const EditTransactionScreen({super.key, required this.data});

  @override
  ConsumerState<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState extends ConsumerState<EditTransactionScreen> {
  late final TextEditingController _notesController;
  late final TextEditingController _amountController;

  bool _isLoading = false;
  String _transactionType = 'debit'; // 'credit' or 'debit'
  String? _selectedCategory;
  String? _selectedSubcategory;
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.data.notes);

    // Set initial values
    _selectedCategory =
        widget.data.category.isNotEmpty ? widget.data.category : null;
    _selectedSubcategory =
        widget.data.subcategory.isNotEmpty ? widget.data.subcategory : null;
    _selectedPaymentMethod =
        widget.data.paymentMethod.isNotEmpty ? widget.data.paymentMethod : null;

    // Determine transaction type and amount
    if (widget.data.credit > 0) {
      _transactionType = 'credit';
      _amountController = TextEditingController(
        text: widget.data.credit.toString(),
      );
    } else {
      _transactionType = 'debit';
      _amountController = TextEditingController(
        text: widget.data.debit.toString(),
      );
    }

    // Fetch categories
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryProvider.notifier).fetchAll();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Type Selection
            _buildTransactionTypeCard(theme),

            const SizedBox(height: 24),

            // Amount Field
            _buildAmountField(theme),

            const SizedBox(height: 24),

            // Category and Subcategory
            _buildCategoryFields(theme, categoryState),

            const SizedBox(height: 24),

            // Payment Method
            _buildPaymentMethodField(theme),

            const SizedBox(height: 24),

            // Notes
            _buildNotesField(theme),

            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required bool isRequired,
    Widget? action,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.indigo.shade600),
          const SizedBox(width: 8),
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
          const Spacer(),
          if (action != null) action,
        ],
      ),
    );
  }

  Widget _buildTransactionTypeCard(ThemeData theme) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.swap_horiz,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Transaction Type',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTypeChip(
                    'Credit',
                    'credit',
                    Icons.arrow_upward,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTypeChip(
                    'Debit',
                    'debit',
                    Icons.arrow_downward,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final isSelected = _transactionType == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _transactionType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          icon: Icons.currency_rupee,
          title: 'Amount',
          isRequired: true,
        ),
        AppInputField(
          labelText: 'Enter amount',
          hintText: '₹ 0.00',
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryFields(ThemeData theme, CategoryState categoryState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Section
        _buildSectionHeader(
          icon: Icons.category_outlined,
          title: 'Category',
          isRequired: true,
          action: AppTextButton.small(
            onPressed: () {
              showCategoryModal(context).then((value) {
                if (value != null) {
                  ref.read(categoryProvider.notifier).addCategory(value);
                }
              });
            },
            labelText: '+ Add',
          ),
        ),
        ChoiceChips(
          choices: categoryState.categoriesMap.keys.toList(),
          selectedChoice: _selectedCategory,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
              _selectedSubcategory =
                  null; // Reset subcategory when category changes
            });
          },
        ),

        const SizedBox(height: 16),

        // Subcategory Section
        _buildSectionHeader(
          icon: Icons.subdirectory_arrow_right,
          title: 'Subcategory',
          isRequired: false,
          action: AppTextButton.small(
            onPressed: () {
              if (_selectedCategory == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please select a category first'),
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
                      .addSubcategory(_selectedCategory!, value);
                }
              });
            },
            labelText: '+ Add',
          ),
        ),
        if (_selectedCategory == null)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey.shade600, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Select a category first',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          )
        else
          ChoiceChips(
            choices: categoryState.categoriesMap[_selectedCategory] ?? [],
            selectedChoice: _selectedSubcategory,
            onChanged: (value) {
              setState(() {
                _selectedSubcategory = value;
              });
            },
          ),
      ],
    );
  }

  Widget _buildPaymentMethodField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          icon: Icons.payment,
          title: 'Payment Method',
          isRequired: true,
        ),
        ChoiceChips(
          selectedChoice: _selectedPaymentMethod,
          choices: Config.paymentMethods,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNotesField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          icon: Icons.note_outlined,
          title: 'Notes',
          isRequired: false,
        ),
        AppInputField(
          labelText: 'Add notes (optional)',
          hintText: 'Additional details...',
          controller: _notesController,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => context.pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _saveTransaction,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
                _isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : const Text('Save Changes'),
          ),
        ),
      ],
    );
  }

  Future<void> _saveTransaction() async {
    if (_amountController.text.isEmpty) {
      _showErrorSnackBar('Please enter an amount');
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showErrorSnackBar('Please enter a valid amount');
      return;
    }

    if (_selectedCategory == null) {
      _showErrorSnackBar('Please select a category');
      return;
    }

    if (_selectedPaymentMethod == null) {
      _showErrorSnackBar('Please select a payment method');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(ledgerRepositoryProvider);

      // Calculate new balance
      final currentBalance = await repository.getBalance(
        _transactionType == 'credit'
            ? TransactionType.credit
            : TransactionType.debit,
        amount,
      );

      await repository.updateTransaction(
        id: widget.data.id,
        credit: _transactionType == 'credit' ? amount : 0,
        debit: _transactionType == 'debit' ? amount : 0,
        balance: currentBalance,
        category: _selectedCategory!,
        subcategory: _selectedSubcategory ?? '',
        notes: _notesController.text.trim(),
        paymentMethod: _selectedPaymentMethod!,
      );

      // Refresh the ledger data
      ref.invalidate(ledgerProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Transaction updated successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to update transaction: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
