import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../providers/ledger_provider.dart';

class CashSummary extends ConsumerWidget {
  const CashSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(ledgetSummaryProvider);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Income'),
              Text(
                '₹${summary.income}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.green.shade700),
              ),
            ],
          ),
          Column(
            children: [
              Text('Balance'),
              Text(
                '₹${summary.balance}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text('Expense'),
              Text(
                '₹${summary.expense}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.red.shade700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
