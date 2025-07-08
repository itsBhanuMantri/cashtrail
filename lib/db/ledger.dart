import 'package:drift/drift.dart';

class Ledger extends Table {
  IntColumn get id => integer().autoIncrement()(); 
  RealColumn get credit => real().withDefault(const Constant(0))();
  RealColumn get debit => real().withDefault(const Constant(0))();
  RealColumn get balance => real().withDefault(const Constant(0))();
  TextColumn get category => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get receivedFrom => text().withDefault(const Constant(''))();
  TextColumn get givenTo => text().withDefault(const Constant(''))();
  TextColumn get paymentMethod => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))(); 
}