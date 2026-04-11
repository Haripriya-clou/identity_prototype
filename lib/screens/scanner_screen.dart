
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:zxing2/qrcode.dart';

import '../widgets/app_shell.dart';
import '../theme/app_theme.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final TextEditingController codeController = TextEditingController();
  final MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );
  bool isScanning = true;
  bool isProcessingUpload = false;

  void verify(String code) {
    final box = Hive.box('users');
    print('Verifying code: "$code" (length: ${code.length})');

    // Try to find the code with some flexibility
    String? foundKey;
    for (var key in box.keys) {
      if (key.toString() == code) {
        foundKey = key.toString();
        break;
      }
    }

    final data = foundKey != null ? box.get(foundKey) : null;

    print('Found matching key: $foundKey');
    print('Data found: ${data != null ? "YES" : "NO"}');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          data != null ? "✓ Verification Valid" : "⚠ Invalid QR Code",
          style: TextStyle(
            color: data != null ? AppTheme.success : AppTheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data != null) ...[
              Text('Name: ${data['name']}'),
              Text('ID: ${data['idType']} - ${data['idNumber']}'),
              Text('DOB: ${data['dob']}'),
              Text('Job: ${data['job']}'),
              Text('Blood Group: ${data['blood']}'),
            ] else ...[
              Text('QR Code not found in database.'),
              Text('Scanned code: "$code"'),
              Text('Code length: ${code.length}'),
              Text('Database has ${box.length} users'),
              if (box.keys.isNotEmpty) ...[
                Text('Sample database keys:'),
                ...box.keys.take(2).map((key) => Text('  "$key" (${key.toString().length} chars)', style: TextStyle(fontSize: 10))),
              ],
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (!isScanning) {
                scannerController.start();
                setState(() => isScanning = true);
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<ui.Image> _decodeUiImage(Uint8List bytes) {
    final completer = Completer<ui.Image>();
    try {
      ui.decodeImageFromList(bytes, (ui.Image image) {
        completer.complete(image);
      });
    } catch (error, stackTrace) {
      completer.completeError(error, stackTrace);
    }
    return completer.future;
  }

  Future<String?> _decodeQRCode(Uint8List imageBytes) async {
    final ui.Image image = await _decodeUiImage(imageBytes);
    try {
      final ui.Image finalImage = image;
      final byteData = await finalImage.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      if (byteData == null) {
        return null;
      }

      final width = finalImage.width;
      final height = finalImage.height;
      final pixels = byteData.buffer.asUint8List();
      final pixelCount = width * height;
      if (pixels.lengthInBytes < pixelCount * 4) {
        return null;
      }

      final argbPixels = Int32List(pixelCount);
      for (var i = 0, j = 0; j < pixelCount; j++, i += 4) {
        final r = pixels[i];
        final g = pixels[i + 1];
        final b = pixels[i + 2];
        final a = pixels[i + 3];
        argbPixels[j] = (a << 24) | (r << 16) | (g << 8) | b;
      }

      final source = RGBLuminanceSource(width, height, argbPixels);
      final bitmap = BinaryBitmap(HybridBinarizer(source));
      final result = QRCodeReader().decode(bitmap);
      return result.text;
    } catch (_) {
      return null;
    } finally {
      image.dispose();
    }
  }

  Future<void> _pickAndVerifyPhoto() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return;
      }

      if (isScanning) {
        await scannerController.stop();
        setState(() => isScanning = false);
      }

      setState(() => isProcessingUpload = true);
      final bytes = await pickedFile.readAsBytes();
      final decoded = await _decodeQRCode(bytes);
      if (!mounted) {
        return;
      }
      if (decoded == null || decoded.isEmpty) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('⚠ QR Upload Failed'),
            content: const Text(
              'Could not detect a valid QR code in the selected image.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  scannerController.start();
                  setState(() => isScanning = true);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        verify(decoded);
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('⚠ Unable to process image'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (!isScanning) {
                  scannerController.start();
                  setState(() => isScanning = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isProcessingUpload = false);
      }
    }
  }

  @override
  void dispose() {
    scannerController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'QR Scanner',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border),
              ),
              child: Text(
                'Point your camera at a QR code, upload one from your device, or enter the code manually.',
                style: TextStyle(color: AppTheme.text),
              ),
            ),
            const SizedBox(height: 16),
            if (!kIsWeb) ...[
              SizedBox(
                height: 320,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: MobileScanner(
                    controller: scannerController,
                    fit: BoxFit.cover,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      if (barcodes.isEmpty) return;
                      final String? code = barcodes.first.rawValue;
                      if (code == null || code.isEmpty) return;
                      if (!isScanning) return;
                      setState(() => isScanning = false);
                      scannerController.stop();
                      verify(code);
                    },
                  ),
                ),
              ),
            ] else ...[
              Container(
                height: 320,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: const Text(
                  'Camera scanning is not supported on web.\nPlease upload a QR image or enter the code manually.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'QR Code',
                border: OutlineInputBorder(),
                hintText: 'Paste the QR code text here',
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  if (isScanning) {
                    scannerController.stop();
                    setState(() => isScanning = false);
                  }
                  verify(value);
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (codeController.text.isNotEmpty) {
                        if (isScanning) {
                          scannerController.stop();
                          setState(() => isScanning = false);
                        }
                        verify(codeController.text);
                      }
                    },
                    child: const Text('Verify Code'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isProcessingUpload ? null : _pickAndVerifyPhoto,
                    icon: const Icon(Icons.upload_file),
                    label: Text(
                      isProcessingUpload ? 'Processing...' : 'Upload QR Photo',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                final box = Hive.box('users');
                final keys = box.keys.take(5).toList();
                final sampleData = keys.isNotEmpty ? box.get(keys.first) : null;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Database Debug'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total users: ${box.length}'),
                        Text('Sample keys: $keys'),
                        if (sampleData != null) ...[
                          Text('Sample data QR: ${sampleData['qr']}'),
                          Text('Sample data name: ${sampleData['name']}'),
                        ],
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Debug Database'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                final box = Hive.box('users');
                if (box.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No users in database')),
                  );
                  return;
                }

                // Test the first user
                final firstKey = box.keys.first;
                final data = box.get(firstKey);
                if (data != null && data['qr'] == firstKey) {
                  verify(firstKey);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Test Failed'),
                      content: Text('Key: $firstKey\nQR: ${data?['qr']}\nMatch: ${firstKey == data?['qr']}'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Test First User'),
            ),
            if (isProcessingUpload) ...[
              const SizedBox(height: 16),
              const LinearProgressIndicator(),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    scannerController.toggleTorch();
                  },
                  icon: const Icon(Icons.flash_on),
                  label: const Text('Torch'),
                ),
                TextButton.icon(
                  onPressed: () {
                    scannerController.switchCamera();
                  },
                  icon: const Icon(Icons.cameraswitch),
                  label: const Text('Switch'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
