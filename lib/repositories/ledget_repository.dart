import 'package:drift/drift.dart';

import '../db/database.dart';

enum TransactionType { credit, debit }

class LedgerRepository {
  LedgerRepository();

  Future<List<LedgerData>> fetchAll() async {
    final db = Database();
    final list =
        await (db.select(db.ledger)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
    return list;
  }

  Future<void> cashOut({
    required double amount,
    required String category,
    required String subcategory,
    required String paymentMethod,
    String? notes,
  }) async {
    final db = Database();
    final balance = await getBalance(TransactionType.debit, amount);
    await db
        .into(db.ledger)
        .insert(
          LedgerCompanion(
            credit: const Value(0),
            debit: Value(amount),
            balance: Value(balance),
            category: Value(category),
            subcategory: Value(subcategory),
            notes: Value(notes ?? ''),
            paymentMethod: Value(paymentMethod),
          ),
        );
  }

  Future<void> cashIn({
    required double amount,
    required String category,
    required String subcategory,
    required String paymentMethod,
    String? notes,
  }) async {
    final db = Database();
    final balance = await getBalance(TransactionType.credit, amount);
    await db
        .into(db.ledger)
        .insert(
          LedgerCompanion(
            credit: Value(amount),
            debit: const Value(0),
            balance: Value(balance),
            category: Value(category),
            subcategory: Value(subcategory),
            notes: Value(notes ?? ''),
            paymentMethod: Value(paymentMethod),
          ),
        );
  }

  Future<double> getBalance(TransactionType type, double amount) async {
    final db = Database();
    final rows = await db.select(db.ledger).get();
    double totalCredits = rows
        .where((row) => row.credit > 0)
        .fold(0, (sum, row) => sum + row.credit);
    double totalDebits = rows
        .where((row) => row.debit > 0)
        .fold(0, (sum, row) => sum + row.debit);

    if (type == TransactionType.credit) {
      totalCredits += amount;
    } else {
      totalDebits += amount;
    }

    final double balance = totalCredits - totalDebits;
    return balance;
  }
}
