class CategoryRepository {
  CategoryRepository();

  Future<List<String>> getCategories() async {
    return ['Food', 'Transport', 'Entertainment', 'Other'];
  }
}