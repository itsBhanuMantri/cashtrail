import 'package:flutter/material.dart';

class CashOutButton extends StatelessWidget {
  const CashOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      child: const Text('Cash Out'),
    );
  }
}
