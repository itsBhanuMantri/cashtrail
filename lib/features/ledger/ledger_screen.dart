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
      appBar: AppBar(title: const Text('Cash Trail')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: const EdgeInsets.all(16.0), child: CashSummary()),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) {
                return Container(height: 8);
              },
              itemBuilder: (context, index) {
                return ListItem(data: items[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16,
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
                        MaterialPageRoute(builder: (context) => CashInWidget()),
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
        ],
      ),
    );
  }
}
