import 'package:drift/drift.dart';

import '../db/database.dart';

class CategoryRepository {
  final separator = '|';
  CategoryRepository();

  Future<List<Category>> getCategories() async {
    final db = Database();
    final categories = await db.select(db.categories).get();
    return categories;
  }

  Future<List<String>> getSubcategories(String category) async {
    final db = Database();
    final category = await db.select(db.categories).getSingle();
    return category.subcategory.split(separator);
  }

  Future<void> addCategory(String category) async {
    final db = Database();
    if (await getCategory(category) != null) {
      return;
    }
    await db
        .into(db.categories)
        .insert(CategoriesCompanion(category: Value(category)));
  }

  Future<Category?> getCategory(String category) async {
    final db = Database();
    final result =
        await (db.select(db.categories)..where(
          (tbl) => tbl.category.lower().equals(category.toLowerCase()),
        )).getSingleOrNull();
    return result;
  }

  Future<void> addSubcategory(String category, String subcategory) async {
    final db = Database();
    final row = await getCategory(category);

    if (row == null) {
      return;
    }

    final subcategories = row.subcategory.split(separator);
    if (subcategories.contains(subcategory)) {
      return;
    }

    final newSubcategories = [
      ...subcategories,
      subcategory,
    ].where((e) => e.isNotEmpty).join(separator);

    await (db.update(db.categories)..where(
      (tbl) => tbl.category.equals(row.category),
    )).write(CategoriesCompanion(subcategory: Value(newSubcategories)));
  }
}
