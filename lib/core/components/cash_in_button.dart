import 'package:flutter/material.dart';

class CashInButton extends StatelessWidget {
  const CashInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      child: const Text('Cash In'),
    );
  }
}
