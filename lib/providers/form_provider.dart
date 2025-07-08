import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/ledget_repository.dart';

class FormState {
  final String? category;
  final String? person;
  final double? amount;
  final String? notes;
  final String? givenTo;
  final String? receivedFrom;
  final String? paymentMethod;

  FormState({
    this.category,
    this.person,
    this.amount,
    this.notes,
    this.givenTo,
    this.receivedFrom,
    this.paymentMethod,
  });

  FormState copyWith({
    String? category,
    String? person,
    double? amount,
    String? notes,
    String? givenTo,
    String? receivedFrom,
    String? paymentMethod,
  }) {
    return FormState(
      category: category ?? this.category,
      person: person ?? this.person,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      givenTo: givenTo ?? this.givenTo,
      receivedFrom: receivedFrom ?? this.receivedFrom,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

class FormNotifier extends Notifier<FormState> {
  @override
  FormState build() {
    return FormState(
      category: null,
      person: null,
      amount: null,
      notes: null,
      givenTo: null,
      receivedFrom: null,
      paymentMethod: null,
    );
  }

  void selectCategory(String category) {
    state = state.copyWith(category: category);
  }

  void selectPerson(String person) {
    state = state.copyWith(person: person);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void setGivenTo(String givenTo) {
    state = state.copyWith(givenTo: givenTo);
  }

  void setReceivedFrom(String receivedFrom) {
    state = state.copyWith(receivedFrom: receivedFrom);
  }

  void setPaymentMethod(String paymentMethod) {
    state = state.copyWith(paymentMethod: paymentMethod);
  }

  Future<void> cashOut() async {
    if (state.amount == null || state.amount == 0) {
      print('amount is null or 0');
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
      amount: state.amount!,
      category: state.category!,
      notes: state.notes,
      givenTo: state.givenTo,
      paymentMethod: state.paymentMethod!,
    );
  }
}

final formProvider = NotifierProvider<FormNotifier, FormState>(
  FormNotifier.new,
);
