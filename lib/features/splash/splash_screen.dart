import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    // 3 seconds por amra Onboarding screen e pathiye dibo
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background, // Deep Dark background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Abstract Logo / Placeholder Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, Color(0xFF8C8AFA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const Icon(
                Icons.checkroom_rounded, // Hanger/Clothes Icon matching "DrapeAI"
                size: 56,
                color: Colors.white,
              ),
            )
            // Logo Animation: Scale and Fade
            .animate()
            .fade(duration: 800.ms, curve: Curves.easeOut)
            .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 800.ms, curve: Curves.easeOutBack),
            
            const SizedBox(height: 24),
            
            // Brand Name Text
            Text(
              'DrapeAI',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    color: AppTheme.textMain,
                  ),
            )
            // Text Animation: Slide up and fade in slightly after the logo
            .animate(delay: 400.ms) // Delay for sequential effect
            .fade(duration: 600.ms)
            .slideY(begin: 0.5, end: 0, duration: 600.ms, curve: Curves.easeOutQuart),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'Studio in your pocket',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textMuted,
                    letterSpacing: 1.2,
                  ),
            )
            // Tagline Animation
            .animate(delay: 800.ms)
            .fade(duration: 600.ms),
          ],
        ),
      ),
    );
  }
}