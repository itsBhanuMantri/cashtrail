import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_provider.dart';
import '../../providers/people_provider.dart';

class PeopleDialog extends ConsumerStatefulWidget {
  const PeopleDialog({super.key});

  @override
  ConsumerState<PeopleDialog> createState() => _PeopleDialogState();
}

class _PeopleDialogState extends ConsumerState<PeopleDialog> {
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

  Future<void> addPerson(String person) async {
    await ref.read(peopleProvider.notifier).add(person);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(peopleProvider);

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
          title:
              state.searching
                  ? TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      ref.read(peopleProvider.notifier).search(value);
                    },
                  )
                  : Text('Choose Category'),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(peopleProvider.notifier).setSearching(true);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: ListView(
          children:
              state.people.map((option) {
                return RadioMenuButton<String>(
                  value: option,
                  groupValue: state.selectedPerson,
                  onChanged: (value) {
                    Navigator.of(context).pop(value);
                  },
                  child: Text(option),
                );
              }).toList(),
        ),
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              builder: (context) {
                return SizedBox(
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
                                hintText: 'Person Name',
                                border: OutlineInputBorder(),
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  addPerson(value);
                                }
                              },
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      addPerson(categoryController.text);
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
