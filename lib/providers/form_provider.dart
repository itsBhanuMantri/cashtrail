import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/ledget_repository.dart';
import 'category_provider.dart';
import 'ledger_provider.dart';

class FormState {
  final String? amount;
  final String? category;
  final String? subcategory;
  final String? notes;
  final String? paymentMethod;

  FormState({
    this.amount,
    this.category,
    this.subcategory,
    this.notes,
    this.paymentMethod,
  });

  FormState copyWith({
    String? category,
    String? amount,
    String? subcategory,
    String? notes,
    String? paymentMethod,
  }) {
    return FormState(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class FormNotifier extends Notifier<FormState> {
  @override
  FormState build() {
    return FormState(
      amount: null,
      category: null,
      subcategory: null,
      notes: null,
      paymentMethod: null,
    );
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void setCategory(String category) {
    state = state.copyWith(category: category);
    final categoryState = ref.read(categoryProvider);
    print('bhanu: category item ${categoryState.categoriesMap[category]}');
    print('bhanu: categoryMap ${categoryState.categoriesMap}');
  }

  void setSubcategory(String subcategory) {
    state = state.copyWith(subcategory: subcategory);
  }

  void setNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void setPaymentMethod(String paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
  }

  Future<void> cashIn() async {
    if (state.amount == null || state.amount!.isEmpty) {
      print('amount is null or empty');
      return;
    }

    if (state.category == null) {
      print('category is null');
      return;
    }

    if (state.paymentMethod == null) {
      print('payment method is null');
      return;
    }

    await LedgerRepository().cashIn(
      amount: double.parse(state.amount!),
      category: state.category!,
      subcategory: state.subcategory ?? '',
      notes: state.notes ?? '',
      paymentMethod: state.paymentMethod!,
    );

    state = state.copyWith(
      amount: '',
      category: '',
      subcategory: '',
      notes: '',
      paymentMethod: '',
    );

    ref.invalidate(ledgerProvider);
    print('bhanu: cash in success');
  }

  Future<void> cashOut() async {
    if (state.amount == null || state.amount!.isEmpty) {
      print('amount is null or empty');
      return;
    }

    if (state.category == null) {
      print('category is null');
      return;
    }

    if (state.paymentMethod == null) {
      print('payment method is null');
      return;
    }

    await LedgerRepository().cashOut(
      amount: double.parse(state.amount!),
      category: state.category!,
      subcategory: state.subcategory ?? '',
      notes: state.notes ?? '',
      paymentMethod: state.paymentMethod!,
    );

    state = state.copyWith(
      amount: '',
      category: '',
      subcategory: '',
      notes: '',
      paymentMethod: '',
    );

    ref.invalidate(ledgerProvider);
    print('bhanu: cash out success');
  }
}

final formProvider = NotifierProvider<FormNotifier, FormState>(
  FormNotifier.new,
);
