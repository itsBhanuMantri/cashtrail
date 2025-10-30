import 'dart:async';

import 'package:content_resolver/content_resolver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'receipt_image_scanner.dart';

class ImageFromContentUri extends StatefulWidget {
  final String contentUri;
  const ImageFromContentUri(this.contentUri, {super.key});

  @override
  State<ImageFromContentUri> createState() => _ImageFromContentUriState();
}

class _ImageFromContentUriState extends State<ImageFromContentUri> {
  String? _filePath;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      _handleUri(widget.contentUri);
    });
  }

  Future<void> _handleUri(String? uri) async {
    if (uri == null) return;
    final dir = await getExternalStorageDirectory();
    await dir!.create(recursive: true);
    final path = '${dir.path}/receipt.jpeg';
    await ContentResolver.resolveContentToFile(uri, path);

    setState(() {
      _filePath = path;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          _filePath != null
              ? ReceiptImageScanner(filePath: _filePath!)
              : Text('Nothing received.'),
    );
  }
}
