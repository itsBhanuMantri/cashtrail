import 'package:drift/drift.dart';

class People extends Table {
  TextColumn get person => text().unique()();
}
