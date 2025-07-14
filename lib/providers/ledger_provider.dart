import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database.dart';
import '../repositories/ledget_repository.dart';

final ledgerProvider = FutureProvider<List<LedgerData>>((ref) async {
  final repo = LedgerRepository();
  return repo.fetchAll();
});

class LedgerSummary {
  final double income;
  final double expense;
  final double balance;

  LedgerSummary({
    required this.income,
    required this.expense,
    required this.balance,
  });
}

final ledgetSummaryProvider = Provider<LedgerSummary>((ref) {
  final ledger = ref.watch(ledgerProvider);
  final list = ledger.valueOrNull ?? [];
  final double income = list
      .where((e) => e.credit > 0)
      .fold(0, (sum, e) => sum + e.credit);
  final double expense = list
      .where((e) => e.debit > 0)
      .fold(0, (sum, e) => sum + e.debit);
  return LedgerSummary(
    income: income,
    expense: expense,
    balance: income - expense,
  );
});
