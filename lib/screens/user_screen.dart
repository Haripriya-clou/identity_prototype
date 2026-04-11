import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/app_shell.dart';
import '../widgets/custom_widgets.dart';
import '../theme/app_theme.dart';

class UserScreen extends StatefulWidget {
  final Map data;

  const UserScreen({super.key, required this.data});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isDownloading = false;
  XFile? capturedImage;
  CameraController? cameraController;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (kIsWeb) return; // Skip on web for now
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(
          cameras.first,
          ResolutionPreset.medium,
        );
        await cameraController!.initialize();
        setState(() => isCameraInitialized = true);
      }
    } catch (e) {
      print('Camera initialization error: $e');
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  Future<void> downloadQR() async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download not available on web')),
      );
      return;
    }

    setState(() => isDownloading = true);

    try {
      final qrPainter = QrPainter(
        data: widget.data['qr'] ?? 'no-data',
        version: QrVersions.auto,
        gapless: false,
      );

      final picData = await qrPainter.toImageData(300);
      if (picData != null) {
        final result = await ImageGallerySaver.saveImage(
          picData.buffer.asUint8List(),
          quality: 100,
          name: 'qr_${widget.data['name'] ?? 'user'}',
        );

        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('QR saved to gallery!')),
          );
        } else {
          throw 'Failed to save';
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR: $e')),
      );
    } finally {
      setState(() => isDownloading = false);
    }
  }

  Future<void> capturePhoto() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() => capturedImage = XFile(pickedFile.path));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo captured successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing photo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    return AppShell(
      title: "Verification QR",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Information',
                  style: TextStyle( 
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data['name'] ?? 'Unknown User',
                  style: TextStyle( 
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        data['idType'] ?? 'Unknown',
                        style: TextStyle( 
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data['idNumber'] ?? 'N/A',
                        style: TextStyle( 
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // QR Code Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.border,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.text.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Scan to Verify',
                  style: TextStyle( 
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                
                // QR Code
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.border,
                      width: 2,
                    ),
                  ),
                  child: QrImageView(
                    data: data['qr'] ?? 'no-data',
                    size: 240,
                    version: QrVersions.auto,
                    embeddedImage: null,
                  ),
                ),

                const SizedBox(height: 16),

                // Download Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isDownloading ? null : downloadQR,
                    icon: isDownloading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(Icons.download),
                    label: Text(isDownloading ? 'Saving...' : 'Download QR'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Photo Capture Section
          SectionHeader(
            title: 'Photo Verification',
            subtitle: 'Capture photo for identity verification',
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.border,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.text.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                if (capturedImage != null) ...[
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: kIsWeb
                            ? NetworkImage(capturedImage!.path) as ImageProvider
                            : FileImage(File(capturedImage!.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Photo captured successfully!',
                    style: TextStyle(
                      color: AppTheme.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ] else ...[
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.border,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 48,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No photo captured yet',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: capturePhoto,
                    icon: const Icon(Icons.camera),
                    label: const Text('Capture Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Details Section
          SectionHeader(
            title: 'Complete Details',
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Full Name',
            description: data['name'] ?? 'N/A',
            accentColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: '${data['idType'] ?? 'ID'} Number',
            description: data['idNumber'] ?? 'N/A',
            accentColor: AppTheme.secondary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Date of Birth',
            description: data['dob'] ?? 'N/A',
            accentColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Father\'s Name',
            description: data['father'] ?? 'N/A',
            accentColor: AppTheme.secondary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Mother\'s Name',
            description: data['mother'] ?? 'N/A',
            accentColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Address',
            description: data['address'] ?? 'N/A',
            accentColor: AppTheme.secondary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Job/Profession',
            description: data['job'] ?? 'N/A',
            accentColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Blood Group',
            description: data['blood'] ?? 'N/A',
            accentColor: AppTheme.secondary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            title: 'Phone Number',
            description: data['phone'] ?? 'N/A',
            accentColor: AppTheme.primary,
          ),

          const SizedBox(height: 12),

          InfoCard(
            title: 'Verification Status',
            description: 'Valid and Verified',
            accentColor: AppTheme.success,
          ),

          const SizedBox(height: 28),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('QR code verified successfully!'),
                        backgroundColor: AppTheme.success,
                      ),
                    );
                  },
                  child: const Text('Verify'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}