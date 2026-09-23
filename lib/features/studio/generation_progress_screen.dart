import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../core/theme/app_theme.dart';

class GenerationProgressScreen extends StatefulWidget {
  const GenerationProgressScreen({super.key});

  @override
  State<GenerationProgressScreen> createState() => _GenerationProgressScreenState();
}

class _GenerationProgressScreenState extends State<GenerationProgressScreen> {
  int _currentStep = 0;
  final List<String> _steps = [
    'Analyzing product image...',
    'Understanding your prompt...',
    'Rendering UE5 scenes...',
    'Adding motion & effects...',
    'Finalizing video...'
  ];

  @override
  void initState() {
    super.initState();
    _simulateProgress();
  }

  void _simulateProgress() async {
    // Simulate steps changing every 1.5 seconds
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) setState(() => _currentStep = i);
    }
    // After final step, navigate to Result Preview
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      context.replace('/preview'); // Using replace so user can't go back to loading screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred Background Placeholder
          Image.network(
            'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=400&q=80',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: AppTheme.background.withOpacity(0.7)),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button (Optional during loading, but good for UX)
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                  ),
                  
                  const Spacer(),
                  
                  // Main Loading UI
                  Center(
                    child: Column(
                      children: [
                        // Pulsing AI Icon
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primary.withOpacity(0.2),
                          ),
                          child: const Icon(Icons.auto_awesome, size: 64, color: AppTheme.primary),
                        ).animate(onPlay: (controller) => controller.repeat())
                         .shimmer(duration: 1500.ms, color: Colors.white)
                         .scaleXY(begin: 0.95, end: 1.05, duration: 1000.ms, curve: Curves.easeInOutSine)
                         .then().scaleXY(begin: 1.05, end: 0.95, duration: 1000.ms, curve: Curves.easeInOutSine),
                        
                        const SizedBox(height: 32),
                        
                        Text(
                          'Generating Your Video',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This may take a few moments...',
                          style: TextStyle(color: Colors.white.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Step-by-step checklist
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surface.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Column(
                      children: List.generate(_steps.length, (index) {
                        bool isCompleted = index < _currentStep;
                        bool isActive = index == _currentStep;
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Icon(
                                isCompleted ? Icons.check_circle_rounded : (isActive ? Icons.radio_button_checked : Icons.radio_button_unchecked),
                                color: isCompleted ? Colors.greenAccent : (isActive ? AppTheme.primary : AppTheme.textMuted),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _steps[index],
                                style: TextStyle(
                                  color: isCompleted || isActive ? Colors.white : AppTheme.textMuted,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ],
                          ).animate(target: isActive ? 1 : 0).shimmer(duration: 2000.ms, color: Colors.white24),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
