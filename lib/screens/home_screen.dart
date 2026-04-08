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
                        style: TextStyle( 
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Identity Verification System',
                        style: TextStyle( 
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
                ModernCard(
                  title: 'User Verification',
                  subtitle: 'Verify and authenticate users',
                  icon: Icons.verified_user,
                  gradient: AppTheme.primaryGradient,
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

                ModernCard(
                  title: 'Admin Panel',
                  subtitle: 'Manage credentials and issuers',
                  icon: Icons.admin_panel_settings,
                  gradient: AppTheme.successGradient,
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

                ModernCard(
                  title: 'Scan QR Code',
                  subtitle: 'Quick verification using QR',
                  icon: Icons.qr_code_scanner,
                  gradient: AppTheme.sunset,
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
                  icon: Icons.security,
                  title: 'Secure',
                  description: 'End-to-end encrypted verification',
                  iconColor: AppTheme.success,
                ),
                const SizedBox(height: 12),

                InfoCard(
                  icon: Icons.speed,
                  title: 'Fast',
                  description: 'Real-time verification results',
                  iconColor: AppTheme.primary,
                ),
                const SizedBox(height: 12),

                InfoCard(
                  icon: Icons.check_circle,
                  title: 'Reliable',
                  description: 'Multi-layer authentication checks',
                  iconColor: AppTheme.warning,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}