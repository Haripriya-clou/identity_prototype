import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:hive/hive.dart';
import '../widgets/app_shell.dart';
import '../theme/app_theme.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      formats: [BarcodeFormat.qrCode],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void verify(String code) {
    final box = Hive.box('users');
    final data = box.get(code);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          data != null ? "✓ Verification Valid" : "⚠ Invalid QR Code",
          style: TextStyle( 
            fontWeight: FontWeight.w600,
            color: data != null ? AppTheme.success : AppTheme.error,
          ),
        ),
        content: data == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No matching record found in the database.',
                    style: TextStyle( 
                      fontSize: 14,
                      color: AppTheme.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Please verify the QR code and try again.',
                    style: TextStyle( 
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Name', data['name'] ?? 'N/A'),
                  const SizedBox(height: 12),
                  _buildDetailRow('ID Type', data['idType'] ?? 'N/A'),
                  const SizedBox(height: 12),
                  _buildDetailRow('ID Number', data['idNumber'] ?? 'N/A'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.success.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: AppTheme.success,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'This credential is verified and valid',
                            style: TextStyle( 
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle( 
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle( 
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.text,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: "Scan QR Code",
      showBackButton: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.warning.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: AppTheme.warning,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Point camera at QR code to verify',
                    style: TextStyle( 
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.text,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Scanner View
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.border,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    if (capture.barcodes.isNotEmpty) {
                      verify(capture.barcodes.first.rawValue ?? '');
                    }
                  },
                  errorBuilder: (context, error, child) {
                    return Container(
                      color: AppTheme.background,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_off,
                            size: 48,
                            color: AppTheme.error,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Camera unavailable',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Scanner Instructions
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: AppTheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Ensure good lighting and steady hand for accurate scanning',
                    style: TextStyle( 
                      fontSize: 12,
                      color: AppTheme.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}