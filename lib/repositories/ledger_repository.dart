import 'package:drift/drift.dart';

import '../db/database.dart';
import '../services.dart';

enum TransactionType { credit, debit }

class LedgerRepository {
  LedgerRepository();

  Future<List<LedgerData>> fetchAll() async {
    final db = sl.get<Database>();
    final list =
        await (db.select(db.ledger)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
    return list;
  }

  Future<LedgerData?> fetchRecentOneByPaidToName(String paidToName) async {
    final db = sl.get<Database>();
    final item =
        await (db.select(db.ledger)
              ..where((tbl) => tbl.paidToName.equals(paidToName))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
            .getSingle();
    return item;
  }

  Future<LedgerData?> fetchRecentOneByUpi(String upiId) async {
    final db = sl.get<Database>();
    final item =
        await (db.select(db.ledger)
              ..where((tbl) => tbl.paidToUpi.equals(upiId))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
            .getSingle();
    return item;
  }

  Future<LedgerData?> fetchRecentOneByPhone(String phone) async {
    final db = sl.get<Database>();
    final item =
        await (db.select(db.ledger)
              ..where((tbl) => tbl.paidToPhone.equals(phone))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
            .getSingle();
    return item;
  }

  Future<void> cashOut({
    required double amount,
    required String category,
    required String subcategory,
    required String paymentMethod,
    String? notes,
    String? bankName,
    String? paidToName,
    String? paidToPhone,
    String? paidToUpi,
  }) async {
    final db = sl.get<Database>();
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
            bankName: Value(bankName ?? ''),
            paidToName: Value(paidToName ?? ''),
            paidToPhone: Value(paidToPhone ?? ''),
            paidToUpi: Value(paidToUpi ?? ''),
          ),
        );
  }

  Future<void> cashIn({
    required double amount,
    required String category,
    required String subcategory,
    required String paymentMethod,
    String? notes,
    String? bankName,
    String? paidToName,
    String? paidToPhone,
    String? paidToUpi,
  }) async {
    final db = sl.get<Database>();
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
            bankName: Value(bankName ?? ''),
            paidToName: Value(paidToName ?? ''),
            paidToPhone: Value(paidToPhone ?? ''),
            paidToUpi: Value(paidToUpi ?? ''),
          ),
        );
  }

  Future<double> getBalance(TransactionType type, double amount) async {
    final db = sl.get<Database>();
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

  Future<void> deleteTransaction(int id) async {
    final db = sl.get<Database>();
    await (db.delete(db.ledger)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> updateTransaction({
    required int id,
    required double credit,
    required double debit,
    required double balance,
    required String category,
    required String subcategory,
    required String notes,
    required String paymentMethod,
  }) async {
    final db = sl.get<Database>();
    await (db.update(db.ledger)..where((tbl) => tbl.id.equals(id))).write(
      LedgerCompanion(
        credit: Value(credit),
        debit: Value(debit),
        balance: Value(balance),
        category: Value(category),
        subcategory: Value(subcategory),
        notes: Value(notes),
        paymentMethod: Value(paymentMethod),
      ),
    );
  }
}
