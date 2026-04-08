import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/app_shell.dart';
import '../widgets/custom_widgets.dart';
import '../theme/app_theme.dart';
import 'user_screen.dart';

class UserRequestScreen extends StatefulWidget {
  const UserRequestScreen({super.key});

  @override
  State<UserRequestScreen> createState() => _UserRequestScreenState();
}

class _UserRequestScreenState extends State<UserRequestScreen> {
  String selectedType = "Aadhar";
  final idController = TextEditingController();
  bool isLoading = false;

  final types = ["Aadhar", "PAN", "DL"];

  String getRule() {
    if (selectedType == "Aadhar") return "Enter 12 digit Aadhar number";
    if (selectedType == "PAN") return "Format: ABCDE1234F";
    return "Enter 16 alphanumeric characters";
  }

  String getPlaceholder() {
    if (selectedType == "Aadhar") return "123456789012";
    if (selectedType == "PAN") return "ABCDE1234F";
    return "1234567890123456";
  }

  void fetchUser() async {
    setState(() => isLoading = true);

    final box = Hive.box('users');

    final data = box.values.firstWhere(
      (e) => e['idNumber'] == idController.text && e['idType'] == selectedType,
      orElse: () => null,
    );

    setState(() => isLoading = false);

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("User not found. Please check the ID number and type."),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserScreen(data: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: "User Verification",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Section
          Container(
            padding: const EdgeInsets.all(16),
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
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.info,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verify User Identity',
                        style: TextStyle( 
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enter the user details to retrieve their verification QR code',
                        style: TextStyle( 
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Input Form
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
                // ID Type Selection
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: InputDecoration(
                    labelText: "ID Type",
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: types
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (v) {
                    setState(() => selectedType = v!);
                    idController.clear();
                  },
                ),

                const SizedBox(height: 12),

                // Help Text
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        size: 18,
                        color: AppTheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          getRule(),
                          style: TextStyle( 
                            fontSize: 12,
                            color: AppTheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ID Number Input
                BeautifulTextField(
                  label: "$selectedType Number",
                  controller: idController,
                  hintText: getPlaceholder(),
                  prefixIcon: Icons.badge,
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: BeautifulButton(
                    label: "Get Verification QR",
                    onPressed: fetchUser,
                    isLoading: isLoading,
                    icon: Icons.qr_code,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Feature Highlights
          SectionHeader(
            title: 'How It Works',
          ),
          const SizedBox(height: 12),
          InfoCard(
            icon: Icons.description,
            title: 'Enter Details',
            description: 'Provide correct ID details to search',
            iconColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),
          InfoCard(
            icon: Icons.verified,
            title: 'Get QR Code',
            description: 'Receive unique verification QR',
            iconColor: AppTheme.success,
          ),
        ],
      ),
    );
  }
}