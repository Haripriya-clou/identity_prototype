import 'package:flutter/material.dart';
import 'user_request_screen.dart';
import 'issuer_login_screen.dart';
import 'scanner_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🎯 Header Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Identity Verification System',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 🎨 Main Cards Grid
                _buildActionCard(
                  title: 'User Verification',
                  subtitle: 'Verify and authenticate users',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserRequestScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                _buildActionCard(
                  title: 'Admin Panel',
                  subtitle: 'Manage credentials and issuers',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IssuerLoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                _buildActionCard(
                  title: 'Scan QR Code',
                  subtitle: 'Quick verification using QR',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ScannerScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // 💡 Features Section
                SectionHeader(
                  title: 'Features',
                  subtitle: 'Secure and reliable identity verification',
                ),
                const SizedBox(height: 12),

                InfoCard(
                  title: 'Secure',
                  description: 'End-to-end encrypted verification',
                  accentColor: AppTheme.success,
                ),
                const SizedBox(height: 12),

                InfoCard(
                  title: 'Fast',
                  description: 'Real-time verification results',
                  accentColor: AppTheme.primary,
                ),
                const SizedBox(height: 12),

                InfoCard(
                  title: 'Reliable',
                  description: 'Multi-layer authentication checks',
                  accentColor: AppTheme.warning,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppTheme.border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}