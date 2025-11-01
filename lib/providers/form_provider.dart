import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/ledger_repository.dart';
import 'category_provider.dart';
import 'ledger_provider.dart';

class FormState {
  final String? amount;
  final String? category;
  final String? subcategory;
  final String? notes;
  final String? paymentMethod;
  final String? bankName;
  final String? paidToName;
  final String? paidToPhone;
  final String? paidToUpi;

  FormState({
    this.amount,
    this.category,
    this.subcategory,
    this.notes,
    this.paymentMethod,
    this.bankName,
    this.paidToName,
    this.paidToPhone,
    this.paidToUpi,
  });

  FormState copyWith({
    String? category,
    String? amount,
    String? subcategory,
    String? notes,
    String? paymentMethod,
    String? bankName,
    String? paidToName,
    String? paidToPhone,
    String? paidToUpi,
  }) {
    return FormState(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bankName: bankName ?? this.bankName,
      paidToName: paidToName ?? this.paidToName,
      paidToPhone: paidToPhone ?? this.paidToPhone,
      paidToUpi: paidToUpi ?? this.paidToUpi,
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

  void setBankName(String bankName) {
    state = state.copyWith(bankName: bankName);
  }

  void setPaidToName(String paidToName) {
    state = state.copyWith(paidToName: paidToName);
  }

  void setPaidToPhone(String paidToPhone) {
    state = state.copyWith(paidToPhone: paidToPhone);
  }

  void setPaidToUpi(String paidToUpi) {
    state = state.copyWith(paidToUpi: paidToUpi);
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
      bankName: state.bankName ?? '',
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
