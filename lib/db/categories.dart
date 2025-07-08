import 'package:drift/drift.dart';

class Categories extends Table { 
  TextColumn get category => text().unique()();
}
