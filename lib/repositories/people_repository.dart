import 'package:drift/drift.dart';

import '../db/database.dart';

class PeopleRepository {
  PeopleRepository();

  Future<List<String>> getPeople() async {
    final db = Database();
    final people = await db.select(db.people).get();
    return people.map((e) => e.person).toList();
  }

  Future<void> addPerson(String person) async {
    final db = Database();
    await db.into(db.people).insert(PeopleCompanion(person: Value(person)));
    print('Person added: $person');
  }
}
