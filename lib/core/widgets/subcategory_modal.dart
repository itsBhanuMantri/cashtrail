import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/app_text_field.dart';

Future<String?> showCategoryModal(BuildContext context, String category) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) {
      return SubcategoryModal(category: category);
    },
  );
}

class SubcategoryModal extends ConsumerStatefulWidget {
  final String category;

  const SubcategoryModal({super.key, required this.category});

  @override
  ConsumerState<SubcategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends ConsumerState<SubcategoryModal> {
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Add New Subcategory of ${widget.category}',
                    style: textTheme.titleMedium,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AppInputField(
                    labelText: 'Category Name',
                    hintText: 'Category Name',
                    autofocus: true,
                    controller: categoryController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        Navigator.of(context).pop(value);
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(categoryController.text);
                          },
                          child: Text('SAVE'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
