import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

import '../../../db/database.dart';
import '../../../features/transaction/transaction_screen.dart';
import '../../core/utils/format_inr.dart';

class ListItem extends StatelessWidget {
  final LedgerData data;
  const ListItem({super.key, required this.data});

  IconData _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return Icons.money;
      case 'upi':
      case 'phonepe':
        return Icons.qr_code_scanner;
      case 'card':
        return Icons.credit_card;
      case 'bank transfer':
        return Icons.account_balance;
      default:
        return Icons.payment;
    }
  }

  Color _getAmountColor(bool isDebit) {
    return isDebit
        ? TailwindPalette.red.shade600
        : TailwindPalette.green.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final date = DateTime.parse(data.createdAt.toString());
    final formattedDate = DateFormat('MMM dd, hh:mm a').format(date);
    final isDebit = data.debit > 0;
    final amount = isDebit ? data.debit : data.credit;
    final hasNotes = data.notes.isNotEmpty;

    final borderColor = _getAmountColor(isDebit);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TailwindPalette.slate.shade200, width: 1),
      ),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionScreen(data: data),
                  ),
                );
              },
              splashColor: Colors.grey.withValues(alpha: 0.1),
              highlightColor: Colors.grey.withValues(alpha: 0.05),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Wrap(
                              children: [
                                CategoryChip(
                                  label: data.category,
                                  primaryColor: TailwindPalette.purple.shade700,
                                  backgroundColor:
                                      TailwindPalette.purple.shade100,
                                ),
                                if (data.subcategory.isNotEmpty) ...[
                                  CategoryChip(
                                    label: data.subcategory,
                                    primaryColor:
                                        TailwindPalette.slate.shade700,
                                    backgroundColor:
                                        TailwindPalette.slate.shade100,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isDebit
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              size: 16,
                              color: _getAmountColor(isDebit),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formatInr(amount),
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _getAmountColor(isDebit),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (hasNotes)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.notes,
                              style: textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF4A5568),
                                height: 1.3,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Payment method
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: TailwindPalette.slate.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: TailwindPalette.slate.shade200,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getPaymentMethodIcon(data.paymentMethod),
                                size: 18,
                                color: TailwindPalette.slate.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                data.paymentMethod,
                                style: textTheme.bodySmall?.copyWith(
                                  color: TailwindPalette.slate.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 12,
                                  color: TailwindPalette.slate.shade500,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formattedDate,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: TailwindPalette.slate.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Colored bar on the left
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final Color primaryColor;
  final Color backgroundColor;
  const CategoryChip({
    super.key,
    required this.label,
    required this.primaryColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
