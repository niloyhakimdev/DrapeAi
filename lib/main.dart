import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(
    // ProviderScope is mandatory for Riverpod state management
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI Content App',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Forcefully keeping it Dark Mode
      routerConfig: appRouter, // Using GoRouter
      debugShowCheckedModeBanner: false, // Removing debug banner
    );
  }
}