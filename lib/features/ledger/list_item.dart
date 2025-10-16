import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/format_inr.dart';
import '../../db/database.dart';
import '../transaction/transaction_screen.dart';

class ListItem extends StatelessWidget {
  final LedgerData data;
  const ListItem({super.key, required this.data});

  IconData _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return Icons.money;
      case 'upi':
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
        ? const Color(0xFFE53E3E) // Modern red
        : const Color(0xFF38A169); // Modern green
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final date = DateTime.parse(data.createdAt.toString());
    final formattedDate = DateFormat('MMM dd, hh:mm a').format(date);
    final isDebit = data.debit > 0;
    final amount = isDebit ? data.debit : data.credit;
    final hasNotes = data.notes.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionScreen(data: data),
              ),
            );
          },
          splashColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left section - Categories and details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category chips row
                      Row(
                        children: [
                          _buildCategoryChip(
                            data.category,
                            const Color(0xFF667EEA),
                            const Color(0xFFF7FAFC),
                          ),
                          if (data.subcategory.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            _buildCategoryChip(
                              data.subcategory,
                              const Color(0xFF9F7AEA),
                              const Color(0xFFFAF5FF),
                            ),
                          ],
                        ],
                      ),

                      // Payment method and date row
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Payment method
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0FFF4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFC6F6D5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getPaymentMethodIcon(data.paymentMethod),
                                  size: 12,
                                  color: const Color(0xFF38A169),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  data.paymentMethod,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF38A169),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Date
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              // color: const Color(0xFFFFF5F5),
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                // color: const Color(0xFFFED7D7),
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 12,
                                  // color: Color(0xFFE53E3E),
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formattedDate,
                                  style: textTheme.bodySmall?.copyWith(
                                    // color: const Color(0xFFE53E3E),
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Notes (if any)
                      if (hasNotes) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7FAFC),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                size: 14,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  data.notes,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF4A5568),
                                    height: 1.3,
                                    fontSize: 11,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Right section - Amount
                Align(
                  alignment:
                      hasNotes ? Alignment.topRight : Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getAmountColor(isDebit).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getAmountColor(isDebit).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isDebit ? Icons.trending_down : Icons.trending_up,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    Color primaryColor,
    Color backgroundColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }
}
