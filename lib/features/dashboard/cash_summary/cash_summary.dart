import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';

import 'card_back.dart';
import 'card_front.dart';

class CashSummary extends StatelessWidget {
  const CashSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureFlipCard(
      animationDuration: const Duration(milliseconds: 300),
      frontWidget: CardFront(),
      backWidget: CardBack(),
    );
  }
}
