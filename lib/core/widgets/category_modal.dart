import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_provider.dart';
import '../components/app_text_field.dart';

class CategoryDialog extends ConsumerStatefulWidget {
  const CategoryDialog({super.key});

  @override
  ConsumerState<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends ConsumerState<CategoryDialog> {
  late TextEditingController categoryController;
  @override
  void initState() {
    super.initState();
    ref.read(categoryProvider.notifier).fetchAll();
    categoryController = TextEditingController();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  Future<void> addCategory(String category) async {
    await ref.read(categoryProvider.notifier).addCategory(category);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(categoryProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (!state.searching) {
          Navigator.of(context).pop();
        } else {
          ref.read(categoryProvider.notifier).setSearching(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // title:
          //     state.searching
          //         ? TextField(
          //           autofocus: true,
          //           decoration: InputDecoration(
          //             hintText: 'Search',
          //             border: InputBorder.none,
          //           ),
          //           onChanged: (value) {
          //             ref.read(categoryProvider.notifier).search(value);
          //           },
          //         )
          //         : Text('Choose Category'),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       ref.read(categoryProvider.notifier).setSearching(true);
          //     },
          //     icon: Icon(Icons.search),
          //   ),
          // ],
        ),
        body: ListView(
          // children:
          //     state.categories.map((option) {
          //       return RadioMenuButton<String>(
          //         value: option,
          //         groupValue: state.selectedCategory,
          //         onChanged: (value) {
          //           Navigator.of(context).pop(value);
          //         },
          //         child: Text(option),
          //       );
          //     }).toList(),
        ),
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              builder: (context) {
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
                                'Add New Category',
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
                              TextField(
                                autofocus: true,
                                controller: categoryController,
                                decoration: InputDecoration(
                                  hintText: 'Category Name',
                                  border: OutlineInputBorder(),
                                ),
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    addCategory(value);
                                  }
                                },
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        addCategory(categoryController.text);
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
              },
            );
          },
          icon: Icon(Icons.add, size: 20, color: Colors.white),
          label: Text('ADD NEW'),
        ),
      ),
    );
  }
}

Future<String?> showCategoryModal(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) {
      return CategoryModal();
    },
  );
}

class CategoryModal extends ConsumerStatefulWidget {
  const CategoryModal({super.key});

  @override
  ConsumerState<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends ConsumerState<CategoryModal> {
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
                  child: Text('Add New Category', style: textTheme.titleMedium),
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
                      print('bhanu submitted $value');
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
