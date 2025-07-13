import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/category_repository.dart';

class CategoryState {
  final Map<String, List<String>> categoriesMap;
  final String? selectedCategory;
  final bool searching;

  CategoryState({
    required this.categoriesMap,
    this.selectedCategory,
    this.searching = false,
  });

  CategoryState copyWith({
    Map<String, List<String>>? categoriesMap,
    String? selectedCategory,
    bool? searching,
  }) {
    return CategoryState(
      categoriesMap: categoriesMap ?? this.categoriesMap,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searching: searching ?? this.searching,
    );
  }
}

class CategoryNotifier extends Notifier<CategoryState> {
  @override
  CategoryState build() {
    return CategoryState(categoriesMap: {}, selectedCategory: null);
  }

  Future<void> fetchAll() async {
    final categories = await CategoryRepository().getCategories();
    final categoriesMap = <String, List<String>>{};
    for (var category in categories) {
      if (category.subcategory.isNotEmpty) {
        categoriesMap[category.category] = category.subcategory.split('|');
      } else {
        categoriesMap[category.category] = [];
      }
    }

    state = state.copyWith(categoriesMap: categoriesMap);
  }

  Future<void> addCategory(String category) async {
    await CategoryRepository().addCategory(category);
    await fetchAll();
  }

  Future<void> addSubcategory(String category, String subcategory) async {
    await CategoryRepository().addSubcategory(category, subcategory);
    await fetchAll();
  }

  void remove(String category) {
    state = state.copyWith(
      categoriesMap: Map.from(state.categoriesMap)..remove(category),
    );
  }

  void setSearching(bool searching) {
    state = state.copyWith(searching: searching);
  }

  // void setCategory(String category) {
  //   state = state.copyWith(selectedCategory: category);
  // }

  // void search(String query) {
  //   if (query.isEmpty) {
  //     state = state.copyWith(categories: _categories);
  //   }
  //   state = state.copyWith(
  //     categories:
  //         state.categories
  //             .where((c) => c.toLowerCase().contains(query.toLowerCase()))
  //             .toList(),
  //   );
  // }
}

final categoryProvider = NotifierProvider<CategoryNotifier, CategoryState>(
  CategoryNotifier.new,
);
