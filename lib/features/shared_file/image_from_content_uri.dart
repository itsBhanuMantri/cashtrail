import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:content_resolver/content_resolver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class ImageFromContentUri extends StatefulWidget {
  final String contentUri;
  const ImageFromContentUri(this.contentUri, {super.key});

  @override
  State<ImageFromContentUri> createState() => _ImageFromContentUriState();
}

class _ImageFromContentUriState extends State<ImageFromContentUri> {
  final _contentSubject = PublishSubject<Content>();
  late final StreamSubscription<String> _appLinksSub;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      _handleUri(widget.contentUri);
    });
  }

  Future<void> _handleUri(String? uri) async {
    if (uri == null) return;
    final metadata = await ContentResolver.resolveContentMetadata(uri);
    final bb = BytesBuilder();
    ContentResolver.resolveContentToStream(uri).listen(
      (event) {
        bb.add(event);
      },
      onDone: () {
        _save(bb.toBytes());
        _contentSubject.add(
          Content(
            data: bb.toBytes(),
            mimeType: metadata.mimeType,
            fileName: metadata.fileName,
          ),
        );
      },
    );
  }

  Future<void> _save(Uint8List data) async {
    // final dir = await getExternalStorageDirectory();
    // await dir!.create(recursive: true);
    // await File('${dir.path}/test.jpg').writeAsBytes(data);
  }

  @override
  void dispose() {
    _appLinksSub.cancel();
    _contentSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ContentResolver example app')),
        body: StreamBuilder<Content>(
          stream: _contentSubject.stream,
          builder: (context, snapshot) {
            return Center(
              child:
                  snapshot.hasData
                      ? Image.memory(snapshot.data!.data)
                      : Text('Nothing received.'),
            );
          },
        ),
      ),
    );
  }
}
