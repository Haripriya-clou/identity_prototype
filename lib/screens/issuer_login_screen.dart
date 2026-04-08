import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_shell.dart';
import '../widgets/custom_widgets.dart';
import '../theme/app_theme.dart';
import 'issuer_screen.dart';

class IssuerLoginScreen extends StatefulWidget {
  const IssuerLoginScreen({super.key});

  @override
  State<IssuerLoginScreen> createState() => _IssuerLoginScreenState();
}

class _IssuerLoginScreenState extends State<IssuerLoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;

  Future<void> login() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const IssuerScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String message = 'Login failed';
        if (e.code == 'user-not-found') {
          message = 'User not found. Please create an account.';
        } else if (e.code == 'wrong-password') {
          message = 'Invalid password. Please try again.';
        } else if (e.code == 'invalid-email') {
          message = 'Invalid email format.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: "Admin Login",
      showBackButton: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Panel',
                  style: TextStyle( 
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in with your admin credentials to access the issuer panel',
                  style: TextStyle( 
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Login Form Card
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
                // Email Field
                BeautifulTextField(
                  label: "Email Address",
                  controller: email,
                  hintText: "admin@identity.com",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: password,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => showPassword = !showPassword),
                      child: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: BeautifulButton(
                    label: "Sign In",
                    onPressed: login,
                    isLoading: isLoading,
                    icon: Icons.login,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Security Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: AppTheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Security Notice',
                      style: TextStyle( 
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Your login credentials are encrypted and securely transmitted. Never share your password with anyone.',
                  style: TextStyle( 
                    fontSize: 12,
                    color: AppTheme.text,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Features List
          SectionHeader(
            title: 'Admin Features',
          ),
          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.people,
            title: 'User Management',
            description: 'Add and manage user credentials',
            iconColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.qr_code,
            title: 'QR Generation',
            description: 'Generate unique verification QR codes',
            iconColor: AppTheme.secondary,
          ),
          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.storage,
            title: 'Data Sync',
            description: 'Automatic Firebase synchronization',
            iconColor: AppTheme.warning,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}