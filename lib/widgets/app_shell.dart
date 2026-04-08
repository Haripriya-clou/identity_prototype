import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppShell extends StatelessWidget {
  final String title;
  final Widget child;
  final FloatingActionButton? fab;
  final bool showBackButton;

  const AppShell({
    super.key,
    required this.title,
    required this.child,
    this.fab,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: (showBackButton && Navigator.canPop(context))
            ? TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
      floatingActionButton: fab,
    );
  }
}