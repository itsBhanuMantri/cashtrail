import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../providers/ledger_provider.dart';
import '../cash_in/cash_in_widget.dart';
import 'cash_summary.dart';
import 'list_item.dart';
import '../cash_out/cash_out_widget.dart';

class LedgerScreen extends ConsumerWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgerState = ref.watch(ledgerProvider);
    final items = ledgerState.valueOrNull ?? [];
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: items.length, (
                  context,
                  index,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListItem(data: items[index]),
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
                            builder: (context) => CashInWidget(),
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
                      child: const Text('CASH IN'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CashOutWdiget(),
                          ),
                        );
                      },
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.red.shade800,
                        ),
                      ),
                      child: Text('CASH OUT'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
