import 'package:flutter/material.dart';

import 'list_item.dart';
import '../cash_out/cash_out_dialog.dart';

class LedgerScreen extends StatelessWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cash Trail')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 15,
              separatorBuilder: (context, index) {
                return Container(height: 8);
              },
              itemBuilder: (context, index) {
                return ListItem();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 32,
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
                    onPressed: () {},
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
                          builder: (context) => CashOutDialog(),
                          fullscreenDialog: true,
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
