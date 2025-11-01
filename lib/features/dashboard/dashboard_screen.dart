import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

import '../../db/database.dart';
import '../../providers/ledger_provider.dart';
import '../transaction/edit_transaction_screen.dart';
import '../transactions/transactions_screen.dart';
import 'cash_summary.dart';
import '../../core/widgets/common/transaction_list_item.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgerState = ref.watch(ledgerProvider);
    final items = (ledgerState.valueOrNull ?? []).take(3).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Cash Trail')),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CashSummary(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: TailwindPalette.slate.shade700,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TransactionsScreen(),
                            ),
                          );
                        },
                        icon: Text(
                          'See All',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        label: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: items.length, (
                  context,
                  index,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TransactionListItem(data: items[index]),
                  );
                }),
              ),
              SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withValues(alpha: 0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => EditTransactionScreen(
                                  data: LedgerData(
                                    id: -1,
                                    credit: 0,
                                    debit: 0,
                                    balance: 0,
                                    createdAt: DateTime.now(),
                                    category: '',
                                    subcategory: '',
                                    notes: '',
                                    paymentMethod: '',
                                    paidToName: '',
                                    paidToPhone: '',
                                    paidToUpi: '',
                                    bankName: '',
                                  ),
                                ),
                          ),
                        );
                      },
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.green.shade800,
                        ),
                      ),
                      child: const Text('Create Transaction'),
                    ),
                  ),
                  // SizedBox(width: 16),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute(
                  //           builder: (context) => CashOutWidget(),
                  //         ),
                  //       );
                  //     },
                  //     style: Theme.of(
                  //       context,
                  //     ).elevatedButtonTheme.style?.copyWith(
                  //       backgroundColor: WidgetStateProperty.all(
                  //         Colors.red.shade800,
                  //       ),
                  //     ),
                  //     child: Text('CASH OUT'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
