import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/category_repository.dart';

class CategoryState {
  final List<String> categories;
  final String? selectedCategory;
  final bool shouldSearch;

  CategoryState({
    required this.categories,
    this.selectedCategory,
    this.shouldSearch = false,
  });

  CategoryState copyWith({
    List<String>? categories,
    String? selectedCategory,
    bool? shouldSearch,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      shouldSearch: shouldSearch ?? this.shouldSearch,
    );
  }
}

class CategoryNotifier extends Notifier<CategoryState> {
  List<String> _categories = [];
  @override
  CategoryState build() {
    return CategoryState(categories: [], selectedCategory: null);
  }

  Future<List<String>> loadCategories() async {
    final categories = await CategoryRepository().getCategories();
    _categories = categories;
    state = state.copyWith(categories: categories);
    return categories;
  }

  void addCategory(String category) {
    state = state.copyWith(categories: [...state.categories, category]);
  }

  void removeCategory(String category) {
    state = state.copyWith(
      categories: state.categories.where((c) => c != category).toList(),
    );
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void shouldSearchCategory(bool shouldSearch) {
    state = state.copyWith(shouldSearch: shouldSearch);
  }

  void searchCategory(String query) {
    if (query.isEmpty) {
      state = state.copyWith(categories: _categories);
    }
    state = state.copyWith(
      categories:
          state.categories
              .where((c) => c.toLowerCase().contains(query.toLowerCase()))
              .toList(),
    );
  }
}

final categoryProvider = NotifierProvider<CategoryNotifier, CategoryState>(
  CategoryNotifier.new,
);
