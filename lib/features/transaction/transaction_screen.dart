import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

import '../../db/database.dart';
import '../../providers/ledger_provider.dart';
import 'edit_transaction_screen.dart';

class TransactionScreen extends ConsumerWidget {
  final LedgerData data;
  const TransactionScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isCredit = data.credit > 0;
    final amount = isCredit ? data.credit : data.debit;
    final transactionType = isCredit ? 'Credit' : 'Debit';
    final transactionColor =
        isCredit
            ? TailwindPalette.green.shade600
            : TailwindPalette.red.shade600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _navigateToEdit(context),
            tooltip: 'Edit Transaction',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteConfirmation(context, ref),
            tooltip: 'Delete Transaction',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Amount Card
            _buildAmountCard(
              context,
              theme,
              amount,
              transactionType,
              transactionColor,
            ),

            const SizedBox(height: 24),

            // Transaction Details Card
            _buildDetailsCard(context, theme),

            const SizedBox(height: 16),

            // Payment Information Card
            _buildPaymentCard(context, theme),

            const SizedBox(height: 16),

            // Notes Card (if notes exist)
            if (data.notes.isNotEmpty) _buildNotesCard(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountCard(
    BuildContext context,
    ThemeData theme,
    double amount,
    String type,
    Color color,
  ) {
    final isCredit = data.credit > 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.08),
            color.withOpacity(0.04),
            color.withOpacity(0.02),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        border: Border.all(color: color.withOpacity(0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon with background
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withOpacity(0.2), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              isCredit
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              size: 32,
              color: color,
            ),
          ),
          const SizedBox(width: 20),
          // Amount and details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type.toUpperCase(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: color.withOpacity(0.9),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  NumberFormat.currency(
                    symbol: '₹',
                    decimalDigits: 2,
                  ).format(amount),
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Balance: ${NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(data.balance)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context, ThemeData theme) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Transaction Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailRow(
              context,
              theme,
              'Category',
              data.category.isNotEmpty ? data.category : 'Not specified',
              Icons.category,
            ),
            const SizedBox(height: 16),
            if (data.subcategory.isNotEmpty)
              _buildDetailRow(
                context,
                theme,
                'Subcategory',
                data.subcategory,
                Icons.subdirectory_arrow_right,
              ),
            if (data.subcategory.isNotEmpty) const SizedBox(height: 16),
            _buildDetailRow(
              context,
              theme,
              'Date & Time',
              DateFormat('MMM dd, yyyy • hh:mm a').format(data.createdAt),
              Icons.access_time,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context, ThemeData theme) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.payment, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Payment Information',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailRow(
              context,
              theme,
              'Payment Method',
              data.paymentMethod.isNotEmpty
                  ? data.paymentMethod
                  : 'Not specified',
              Icons.credit_card,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context, ThemeData theme) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.note, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Notes',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                  0.3,
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Text(data.notes, style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    ThemeData theme,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary.withOpacity(0.7)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTransactionScreen(data: data),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final theme = Theme.of(context);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              const SizedBox(width: 12),
              const Text('Delete Transaction'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Are you sure you want to delete this transaction?',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.3,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction Details:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${data.category}${data.subcategory.isNotEmpty ? ' • ${data.subcategory}' : ''}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      'Amount: ${NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(data.credit > 0 ? data.credit : data.debit)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.credit > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This action cannot be undone.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteTransaction(context, ref);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTransaction(BuildContext context, WidgetRef ref) async {
    try {
      // Show loading indicator
      unawaited(
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        ),
      );

      // Delete the transaction
      final repository = ref.read(ledgerRepositoryProvider);
      await repository.deleteTransaction(data.id);

      // Refresh the ledger data
      ref.invalidate(ledgerProvider);

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Transaction deleted successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }

      // Navigate back
      if (context.mounted) {
        context.pop();
      }
    } catch (e) {
      // Close loading dialog if still open
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete transaction: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }
}
