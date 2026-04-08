import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('users');

  // Sync Firebase data to Hive on startup
  await _syncFirebaseToHive();

  runApp(const MyApp());
}

/// Sync user credentials from Firebase to Hive for offline access
Future<void> _syncFirebaseToHive() async {
  try {
    final firestore = FirebaseFirestore.instance;
    final box = Hive.box('users');
    
    final snapshot = await firestore.collection('users').get();
    
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final qrCode = data['qrCode'] ?? doc.id;
      box.put(qrCode, data);
    }
  } catch (e) {
    print('Error syncing Firebase to Hive: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Identity System',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}