import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/category_repository.dart';

class CategoryState {
  final List<String> categories;
  final String? selectedCategory;
  final bool searching;

  CategoryState({
    required this.categories,
    this.selectedCategory,
    this.searching = false,
  });

  CategoryState copyWith({
    List<String>? categories,
    String? selectedCategory,
    bool? searching,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searching: searching ?? this.searching,
    );
  }
}

class CategoryNotifier extends Notifier<CategoryState> {
  List<String> _categories = [];
  @override
  CategoryState build() {
    return CategoryState(categories: [], selectedCategory: null);
  }

  Future<List<String>> fetchAll() async {
    final categories = await CategoryRepository().getCategories();
    _categories = categories;
    state = state.copyWith(categories: categories);
    return categories;
  }

  Future<void> add(String category) async {
    await CategoryRepository().addCategory(category);
    state = state.copyWith(categories: [...state.categories, category]);
  }

  void remove(String category) {
    state = state.copyWith(
      categories: state.categories.where((c) => c != category).toList(),
    );
  }

  void setSearching(bool searching) {
    state = state.copyWith(searching: searching);
  }

  void search(String query) {
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
