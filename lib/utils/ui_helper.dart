import 'package:flutter/material.dart';

const gradientBg = BoxDecoration(
  gradient: LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);

Widget glassCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white24),
    ),
    child: child,
  );
}