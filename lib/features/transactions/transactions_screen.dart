import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/common/transaction_list_item.dart';
import '../../providers/ledger_provider.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgerState = ref.watch(ledgerProvider);
    final items = ledgerState.valueOrNull ?? [];
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.only(bottom: 8)),
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
        ],
      ),
    );
  }
}
