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
  final encryptedController = TextEditingController();
  bool isLoading = false;
  bool useEncryptedText = false;

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

    dynamic data;
    if (useEncryptedText) {
      data = box.values.firstWhere(
        (e) => e['encryptedText'] == encryptedController.text,
        orElse: () => null,
      );
    } else {
      data = box.values.firstWhere(
        (e) => e['idNumber'] == idController.text && e['idType'] == selectedType,
        orElse: () => null,
      );
    }

    setState(() => isLoading = false);

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("User not found. Please check the details."),
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
                  'Enter the user details or encrypted text to retrieve their verification QR code',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Mode Toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: [
                Text(
                  'Search by:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.text,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Radio<bool>(
                      value: false,
                      groupValue: useEncryptedText,
                      onChanged: (v) => setState(() => useEncryptedText = v!),
                    ),
                    Text('ID Details', style: TextStyle(color: AppTheme.text)),
                    const SizedBox(width: 16),
                    Radio<bool>(
                      value: true,
                      groupValue: useEncryptedText,
                      onChanged: (v) => setState(() => useEncryptedText = v!),
                    ),
                    Text('Encrypted Text', style: TextStyle(color: AppTheme.text)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

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
                if (!useEncryptedText) ...[
                  // ID Type Selection
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: InputDecoration(
                      labelText: "ID Type",
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
                    child: Text(
                      getRule(),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ID Number Input
                  BeautifulTextField(
                    label: "$selectedType Number",
                    controller: idController,
                    hintText: getPlaceholder(),
                    keyboardType: TextInputType.text,
                  ),
                ] else ...[
                  // Encrypted Text Input
                  BeautifulTextField(
                    label: "Encrypted Text",
                    controller: encryptedController,
                    hintText: "Enter the encrypted recovery text",
                    keyboardType: TextInputType.text,
                  ),
                ],

                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: BeautifulButton(
                    label: "Get Verification QR",
                    onPressed: fetchUser,
                    isLoading: isLoading,
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
            title: 'Enter Details',
            description: 'Provide correct ID details to search',
            accentColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),
          InfoCard(
            title: 'Get QR Code',
            description: 'Receive unique verification QR',
            accentColor: AppTheme.success,
          ),
        ],
      ),
    );
  }
}