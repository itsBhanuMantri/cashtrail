import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

import '../../services.dart';

class ReceiptImageScanner extends ConsumerStatefulWidget {
  final String? filePath;

  const ReceiptImageScanner({super.key, required this.filePath});

  @override
  ConsumerState<ReceiptImageScanner> createState() =>
      _ReceiptImageScannerState();
}

class _ReceiptImageScannerState extends ConsumerState<ReceiptImageScanner>
    with SingleTickerProviderStateMixin {
  String _filePath = '';
  bool _isLoading = false;
  Map<String, dynamic>? _jsonResult;
  String? _error;
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _initializeFilePath();
  }

  Future<void> _initializeFilePath() async {
    _filePath = widget.filePath ?? await _getFilePath();
    if (mounted) {
      _sendImageToApi();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _sendImageToApi() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Start the scanning animation
    _animationController.repeat(reverse: true);

    try {
      final dio = sl.get<Dio>();

      final multipartFile = await MultipartFile.fromFile(
        _filePath,
        filename: 'receipt.jpeg',
      );
      final formData = FormData.fromMap({'file': multipartFile});

      // Make POST request to /receipt_to_json
      final response = await dio.post('/receipt_to_json', data: formData);

      if (mounted) {
        setState(() {
          _jsonResult =
              response.data is Map
                  ? response.data as Map<String, dynamic>
                  : jsonDecode(response.data) as Map<String, dynamic>;
          _isLoading = false;
        });
        // Stop the scanning animation
        _animationController.stop();

        final receiptJson = _jsonResult?['receipt_json'];

        GoRouter.of(context).go('/cash_in', extra: receiptJson);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
        // Stop the scanning animation on error
        _animationController.stop();
      }
    }
  }

  Future<String> _getFilePath() async {
    final dir = await getExternalStorageDirectory();
    final path = '${dir?.path}/receipt.jpeg';
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          // Always show the image
          _buildReceiptImage(),
          // Show loading indicator during API call
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading) ...[
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                if (_isLoading)
                  Text(
                    'Scanning receipt...',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  Text(
                    'Receipt scanned successfully',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Show error if any
          if (_error != null) _buildErrorWidget(),
          if (_jsonResult != null) _buildJsonResult(),
        ],
      ),
    );
  }

  Widget _buildReceiptImage() {
    if (_filePath.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.45,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(_filePath), fit: BoxFit.contain),
            ),
            // Scanning animation overlay
            if (_isLoading)
              AnimatedBuilder(
                animation: _scanAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: ScanLinePainter(_scanAnimation.value),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          Text(
            'Error: $_error',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _sendImageToApi,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildJsonResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receipt Data:',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            const JsonEncoder.withIndent('  ').convert(_jsonResult),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        ),
      ],
    );
  }
}

// Custom painter for the scanning line animation
class ScanLinePainter extends CustomPainter {
  final double scanProgress;

  ScanLinePainter(this.scanProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.green
          ..strokeWidth = 3
          ..blendMode = BlendMode.screen;

    // Calculate the position of the scanning line
    final scanLineY = size.height * scanProgress;

    // Draw the main scanning line
    canvas.drawLine(Offset(0, scanLineY), Offset(size.width, scanLineY), paint);

    // Draw additional lines for effect (wider glow)
    final glowPaint =
        Paint()
          ..color = Colors.green.withOpacity(0.3)
          ..strokeWidth = 10
          ..blendMode = BlendMode.screen;

    canvas.drawLine(
      Offset(0, scanLineY),
      Offset(size.width, scanLineY),
      glowPaint,
    );

    // Draw a gradient effect around the line
    final gradientPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [
              Colors.transparent,
              Colors.green.withOpacity(0.5),
              Colors.green,
              Colors.green.withOpacity(0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
          ).createShader(Rect.fromLTWH(0, scanLineY - 20, size.width, 40));

    canvas.drawRect(
      Rect.fromLTWH(0, scanLineY - 20, size.width, 40),
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(ScanLinePainter oldDelegate) {
    return oldDelegate.scanProgress != scanProgress;
  }
}
