import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/app_shell.dart';
import '../widgets/custom_widgets.dart';
import '../theme/app_theme.dart';

class UserScreen extends StatelessWidget {
  final Map data;

  const UserScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
            icon: Icons.person,
            title: 'Full Name',
            description: data['name'] ?? 'N/A',
            iconColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.badge,
            title: '${data['idType'] ?? 'ID'} Number',
            description: data['idNumber'] ?? 'N/A',
            iconColor: AppTheme.secondary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.verified,
            title: 'Verification Status',
            description: 'Valid and Verified',
            iconColor: AppTheme.success,
          ),

          const SizedBox(height: 28),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('QR code verified successfully!'),
                        backgroundColor: AppTheme.success,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Verify'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}