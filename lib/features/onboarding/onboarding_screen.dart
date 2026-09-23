import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../core/theme/app_theme.dart';

// Onboarding Data Model
class OnboardingContent {
  final String title;
  final String description;
  final IconData icon;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Virtual Try-On",
      description: "Upload your photo and see how any outfit looks on you instantly with AI precision.",
      icon: Icons.accessibility_new_rounded,
    ),
    OnboardingContent(
      title: "Cinematic Product Ads",
      description: "Turn flat lays into studio-quality 3D showcases with dynamic lighting and camera motion.",
      icon: Icons.video_camera_back_rounded,
    ),
    OnboardingContent(
      title: "Zero Editing Needed",
      description: "Generate scroll-stopping UGC and marketing videos in seconds, ready for social media.",
      icon: Icons.bolt_rounded,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Background PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _contents.length,
            itemBuilder: (context, index) {
              return _buildPageContent(_contents[index]);
            },
          ),

          // Bottom Glassmorphic Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    color: AppTheme.surface.withOpacity(0.6),
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.05)),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Smooth Page Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _contents.length,
                          (index) => _buildDot(index),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Animated Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentIndex == _contents.length - 1) {
                              context.go('/auth');
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutCubic,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _currentIndex == _contents.length - 1
                                ? "Get Started"
                                : "Continue",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ).animate(target: _currentIndex == _contents.length - 1 ? 1 : 0)
                       .shimmer(duration: 1500.ms, color: Colors.white24), // Subtle glow on final button
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(OnboardingContent content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for Future 3D/UE5 style asset or video loop
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.1),
                  blurRadius: 50,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Icon(
              content.icon,
              size: 100,
              color: AppTheme.primary,
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack).fadeIn(),
          
          const SizedBox(height: 48),
          
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textMain,
                ),
          ).animate().slideY(begin: 0.3, duration: 500.ms).fadeIn(),
          
          const SizedBox(height: 16),
          
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  height: 1.5,
                  color: AppTheme.textMuted,
                ),
          ).animate().slideY(begin: 0.3, delay: 100.ms, duration: 500.ms).fadeIn(),
          
          const SizedBox(height: 100), // Space for bottom nav
        ],
      ),
    );
  }

  // Smooth expanding dot indicator
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: _currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentIndex == index ? AppTheme.primary : AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}