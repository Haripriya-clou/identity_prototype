import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/hash_helper.dart';
import '../widgets/app_shell.dart';
import '../widgets/custom_widgets.dart';
import '../theme/app_theme.dart';

class IssuerScreen extends StatefulWidget {
  const IssuerScreen({super.key});

  @override
  State<IssuerScreen> createState() => _IssuerScreenState();
}

class _IssuerScreenState extends State<IssuerScreen> {
  final name = TextEditingController();
  final id = TextEditingController();
  String type = "Aadhar";
  bool isLoading = false;

  final types = ["Aadhar", "PAN", "DL"];

  bool validate(String id) {
    if (type == "Aadhar") return RegExp(r'^[0-9]{12}$').hasMatch(id);
    if (type == "PAN") return RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(id);
    return RegExp(r'^[A-Za-z0-9]{16}$').hasMatch(id);
  }

  Future<void> syncFirebase() async {
    final box = Hive.box('users');
    final snap = await FirebaseFirestore.instance.collection('users').get();

    for (var doc in snap.docs) {
      box.put(doc.id, doc.data());
    }

    setState(() {});
  }

  Future<void> add() async {
    if (!validate(id.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid $type number'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final qr = HashHelper.generateQR(id.text, type);

      final data = {
        "name": name.text,
        "idNumber": id.text,
        "idType": type,
        "qr": qr,
      };

      final box = Hive.box('users');
      box.put(qr, data);
      await FirebaseFirestore.instance.collection('users').doc(qr).set(data);

      name.clear();
      id.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User added successfully!'),
          backgroundColor: AppTheme.success,
        ),
      );

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppTheme.error,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    syncFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('users');
    final userCount = box.length;

    return AppShell(
      title: "Issuer Panel",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppTheme.successGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.success.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registered Users',
                  style: TextStyle( 
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$userCount',
                  style: TextStyle( 
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 📋 Form Section
          SectionHeader(
            title: 'Add New User',
            subtitle: 'Issue credential and generate QR code',
          ),

          const SizedBox(height: 12),

          // Input Card
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
                // Full Name Input
                BeautifulTextField(
                  label: "Full Name",
                  controller: name,
                  hintText: "Enter user's full name",
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 16),

                // ID Type Dropdown
                DropdownButtonFormField<String>(
                  value: type,
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
                  onChanged: (v) => setState(() => type = v!),
                ),

                const SizedBox(height: 16),

                // ID Number Input
                BeautifulTextField(
                  label: "$type Number",
                  controller: id,
                  hintText: type == "Aadhar"
                      ? "12-digit number"
                      : type == "PAN"
                          ? "PAN format"
                          : "16-digit number",
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: BeautifulButton(
                    label: "Add User",
                    onPressed: add,
                    isLoading: isLoading,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // 👥 Users List Section
          SectionHeader(
            title: 'Users List',
            subtitle: 'All registered credentials',
            onActionPressed: syncFirebase,
            actionLabel: 'Refresh',
          ),

          const SizedBox(height: 12),

          // Users List
          userCount == 0
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'No users yet',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first user to get started',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final user = box.getAt(index) as Map;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.border,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['name'] ?? 'Unknown',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${user['idType']} • ${user['idNumber']}",
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              StatusBadge(
                                label: user['idType'] ?? '',
                                backgroundColor: AppTheme.primary,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}