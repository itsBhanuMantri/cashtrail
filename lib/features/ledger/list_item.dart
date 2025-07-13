import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../db/database.dart';

class ListItem extends StatelessWidget {
  final LedgerData data;
  const ListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final date = DateTime.parse(data.createdAt.toString());
    final formattedDate = DateFormat('jm').format(date);
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                data.category,
                                style: textTheme.labelSmall?.copyWith(
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                data.subcategory,
                                style: textTheme.labelSmall?.copyWith(
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (data.notes.isNotEmpty) ...[
                          SizedBox(height: 8),
                          Text(data.notes, style: textTheme.bodySmall),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${data.debit > 0 ? data.debit : data.credit}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              data.debit > 0
                                  ? Colors.red.shade700
                                  : Colors.green.shade700,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹${data.balance}',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: Colors.black12),
              Row(
                children: [
                  Text(data.paymentMethod, style: textTheme.bodySmall),
                  Spacer(),
                  Text(formattedDate, style: textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
