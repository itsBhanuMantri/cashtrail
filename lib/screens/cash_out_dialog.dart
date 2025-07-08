import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/category_provider.dart';
import 'category_dialog.dart';
import 'choice_chips.dart';


class CashOutDialog extends ConsumerStatefulWidget {
  const CashOutDialog({super.key});

  @override
  ConsumerState<CashOutDialog> createState() => _CashOutDialogState();
}
class _CashOutDialogState extends ConsumerState<CashOutDialog> {
  String selectedChoice = 'PhonePe';
  final categoryController = TextEditingController();

  void onChoiceChanged(String choice) {
    setState(() {
      selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);
    final textTheme = Theme.of(context).textTheme;
    if (categoryState.selectedCategory != null) {
      categoryController.text = categoryState.selectedCategory!;
      print('coming here');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('CASH OUT')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Amount *',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(height: 24),

                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    controller: categoryController,
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryDialog()))
                        .then((value) {
                          if (value != null) {
                            categoryController.text = value;
                          }
                        });
                    },
                  ),
                  SizedBox(height: 24),
                  TextField(
                    autofocus: true,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Given to',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text('Payment Method', style: textTheme.titleSmall),
                  SizedBox(height: 8),
                  ChoiceChips(
                    selectedChoice: selectedChoice,
                    choices: ['PhonePe', 'Cash', 'Online', 'Google Pay'],
                    onChanged: onChoiceChanged,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: () {}, child: Text('SAVE')),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
