import 'package:drift/drift.dart';

import '../db/database.dart';

class CategoryRepository {
  CategoryRepository();

  Future<List<String>> getCategories() async {
    final db = Database();
    final categories = await db.select(db.categories).get();
    return categories.map((e) => e.category).toList();
  }

  Future<void> addCategory(String category) async {
    final db = Database();
    await db
        .into(db.categories)
        .insert(CategoriesCompanion(category: Value(category)));
    print('Category added: $category');
  }
}
