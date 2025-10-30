import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'image_from_content_uri.dart';

class SharedFileScreen extends StatelessWidget {
  const SharedFileScreen({super.key, this.sharedFilePath});

  final String? sharedFilePath;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Handle back button when opened from external app
      canPop: false, // Prevent default pop behavior
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          // If there's a previous route, pop normally
          // Otherwise, navigate to home screen (opened from external app)
          if (context.canPop()) {
            context.pop();
          } else {
            // Opened from external app - navigate to home
            context.go('/');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scanning Payment Receipt...'),
          // Customize back button behavior
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                // Navigate to home if no previous route
                context.go('/');
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child:
                    sharedFilePath == null
                        ? const Text('No file shared yet')
                        : Text('Received file URI:\n$sharedFilePath'),
              ),
              if (sharedFilePath != null) ImageFromContentUri(sharedFilePath!),
            ],
          ),
        ),
      ),
    );
  }
}
