import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/category_repository.dart';

class PeopleState {
  final List<String> people;
  final String? selectedPerson;
  final bool searching;

  PeopleState({
    required this.people,
    this.selectedPerson,
    this.searching = false,
  });

  PeopleState copyWith({
    List<String>? people,
    String? selectedPerson,
    bool? searching,
  }) {
    return PeopleState(
      people: people ?? this.people,
      selectedPerson: selectedPerson ?? this.selectedPerson,
      searching: searching ?? this.searching,
    );
  }
}

class PeopleNotifier extends Notifier<PeopleState> {
  List<String> _people = [];
  @override
  PeopleState build() {
    return PeopleState(people: [], selectedPerson: null);
  }

  Future<List<String>> fetchAll() async {
    final categories = await CategoryRepository().getCategories();
    _people = categories;
    state = state.copyWith(people: categories);
    return categories;
  }

  Future<void> add(String person) async {
    await CategoryRepository().addCategory(person);
    state = state.copyWith(people: [...state.people, person]);
  }

  void remove(String person) {
    state = state.copyWith(
      people: state.people.where((c) => c != person).toList(),
    );
  }

  void select(String person) {
    state = state.copyWith(selectedPerson: person);
  }

  void setSearching(bool searching) {
    state = state.copyWith(searching: searching);
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(people: _people);
    }
    state = state.copyWith(
      people:
          state.people
              .where((c) => c.toLowerCase().contains(query.toLowerCase()))
              .toList(),
    );
  }
}

final peopleProvider = NotifierProvider<PeopleNotifier, PeopleState>(
  PeopleNotifier.new,
);
