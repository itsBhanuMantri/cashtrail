import 'package:drift/drift.dart';

import '../db/database.dart';

class LedgerRepository {
  LedgerRepository();

  Future<void> cashOut({
    required double amount,
    required String category,
    required String paymentMethod,
    String? notes,
    String? givenTo,
  }) async {
    final db = Database();
    await db
        .into(db.ledger)
        .insert(
          LedgerCompanion(
            credit: const Value(0),
            debit: Value(amount),
            category: Value(category),
            notes: Value(notes ?? ''),
            givenTo: Value(givenTo ?? ''),
            paymentMethod: Value(paymentMethod),
          ),
        );
  }

  Future<void> cashIn({
    required double amount,
    required String category,
    required String paymentMethod,
    String? notes,
    String? receivedFrom,
  }) async {
    final db = Database();
    await db
        .into(db.ledger)
        .insert(
          LedgerCompanion(
            credit: Value(amount),
            debit: const Value(0),
            category: Value(category),
            notes: Value(notes ?? ''),
            receivedFrom: Value(receivedFrom ?? ''),
            paymentMethod: Value(paymentMethod),
          ),
        );
  }

  double _getBalance() {
    final balance = 0;
    return 0;
  }
}
