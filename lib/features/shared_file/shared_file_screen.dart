import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'image_from_content_uri.dart';

class SharedFileScreen extends StatefulWidget {
  const SharedFileScreen({super.key});

  @override
  State<SharedFileScreen> createState() => _SharedFileScreenState();
}

class _SharedFileScreenState extends State<SharedFileScreen> {
  static const platform = MethodChannel('shared_file_channel');
  String? sharedFilePath;

  @override
  void initState() {
    super.initState();
    _getSharedFile();
  }

  Future<void> _getSharedFile() async {
    try {
      final result = await platform.invokeMethod<String>('getSharedFile');
      if (result != null) {
        setState(() {
          sharedFilePath = result;
        });
      }
    } on PlatformException catch (e) {
      debugPrint("Error getting shared file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Shared File Receiver')),
        body: Column(
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
    );
  }
}
