import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_widgets.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppTheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading dashboard...',
                    style: TextStyle( 
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          var docs = snapshot.data!.docs;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard',
                            style: TextStyle( 
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage all registered credentials',
                            style: TextStyle( 
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      StatusBadge(
                        label: '${docs.length} Users',
                        backgroundColor: AppTheme.primary,
                        textColor: Colors.white,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Stats Grid
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
                          'Total Registered Users',
                          style: TextStyle( 
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${docs.length}',
                          style: TextStyle( 
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Users List Header
                  SectionHeader(
                    title: 'All Users',
                    subtitle: 'Complete list of registered credentials',
                  ),

                  const SizedBox(height: 12),

                  // Users List
                  docs.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 48),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 64,
                                  color: AppTheme.textSecondary.withOpacity(0.3),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No users yet',
                                  style: TextStyle( 
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var doc = docs[index];
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc['name'] ?? 'Unknown',
                                              style: TextStyle( 
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.text,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              doc['idNumber'] ?? 'N/A',
                                              style: TextStyle( 
                                                fontSize: 12,
                                                color: AppTheme.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      StatusBadge(
                                        label: doc['idType'] ?? 'ID',
                                        backgroundColor: AppTheme.secondary,
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
          );
        },
      ),
    );
  }
}