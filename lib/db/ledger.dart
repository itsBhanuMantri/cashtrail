import 'package:drift/drift.dart';

class Ledger extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get credit => real().withDefault(const Constant(0))();
  RealColumn get debit => real().withDefault(const Constant(0))();
  RealColumn get balance => real().withDefault(const Constant(0))();
  TextColumn get category => text().withDefault(const Constant(''))();
  TextColumn get subcategory => text().withDefault(const Constant(''))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get paymentMethod => text().withDefault(const Constant(''))();
  TextColumn get paidToName => text().withDefault(const Constant(''))();
  TextColumn get paidToPhone => text().withDefault(const Constant(''))();
  TextColumn get paidToUpi => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
