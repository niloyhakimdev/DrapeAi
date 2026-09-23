import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class StudioScreen extends StatefulWidget {
  const StudioScreen({super.key});

  @override
  State<StudioScreen> createState() => _StudioScreenState();
}

class _StudioScreenState extends State<StudioScreen> {
  bool _isListening = false;
  bool _mannequinDetected = true; 
  
  String selectedSize = 'Medium';
  String selectedAesthetic = 'DreamWorks Realism';
  List<String> selectedEdits = ['Whip-Cut'];
  List<String> selectedAsmr = ['Mechanical Clicks']; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Creator Studio',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textMain,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: AppTheme.textMuted),
            onPressed: () => context.push('/usage-history'),
          ),
        ],
      ),
      // 🔥 FIX: Removed Stack to avoid double floating elements. Everything is now naturally scrollable.
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 120), // Bottom padding keeps content above the nav bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Smart Upload
            Text('1. Source Asset', style: _headingStyle()),
            const SizedBox(height: 12),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1578932750294-f5075e85f44a?w=400&q=80'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  if (_mannequinDetected)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () => setState(() => _mannequinDetected = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [AppTheme.primary, Color(0xFF8C8AFA)]),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.5), blurRadius: 15)],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Detect Mannequin: Swap',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(duration: 2000.ms, color: Colors.white54),
                      ),
                    ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1),

            const SizedBox(height: 24),

            // 2. Voice-to-Video
            Text('2. Action (Voice/Text)', style: _headingStyle()),
            const SizedBox(height: 12),
            _buildVoicePromptBox(),

            const SizedBox(height: 24),

            // 3. Size Attribute
            Text('3. Subject & Fit (Infinite Sizing)', style: _headingStyle()),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPillButton('Size XS', selectedSize, (v) => setState(() => selectedSize = v)),
                  _buildPillButton('Small', selectedSize, (v) => setState(() => selectedSize = v)),
                  _buildPillButton('Medium', selectedSize, (v) => setState(() => selectedSize = v)),
                  _buildPillButton('Large', selectedSize, (v) => setState(() => selectedSize = v)),
                  _buildPillButton('Size XL', selectedSize, (v) => setState(() => selectedSize = v)),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // 4. Lighting & Aesthetic (🔥 FIX: Fixed layout clipping and proportions)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lighting Angle', style: _headingStyle()),
                      const SizedBox(height: 12),
                      Container(
                        height: 130, // Increased height
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centers everything properly
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(Icons.control_camera_rounded, color: AppTheme.textMuted.withOpacity(0.3), size: 48),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: AppTheme.primary, blurRadius: 10)],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text('Drag to adjust', style: TextStyle(color: AppTheme.textMuted, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aesthetic', style: _headingStyle()),
                      const SizedBox(height: 12),
                      Container(
                        height: 130, // Matched height with Lighting Angle
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.theater_comedy_rounded, color: AppTheme.accent, size: 36),
                            const SizedBox(height: 12),
                            Text(
                              selectedAesthetic,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 300.ms),

            const SizedBox(height: 24),

            // 5. ASMR & Cuts
            Text('5. Tactile ASMR & Cuts', style: _headingStyle()),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildToggleChip('🎧 Mechanical Clicks', selectedAsmr),
                _buildToggleChip('🎧 Heavy Denim', selectedAsmr),
                _buildToggleChip('🎬 Whip-Cut', selectedEdits),
                _buildToggleChip('🎬 Slow Pan', selectedEdits),
              ],
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 40),

            // 🔥 FIX: Moved Render Button into the scroll flow, not floating.
            ElevatedButton(
              onPressed: () {
                context.push('/progress');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                minimumSize: const Size(double.infinity, 56), // Full width
                elevation: 5,
                shadowColor: AppTheme.primary.withOpacity(0.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie_creation_rounded, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Render Omni Flash (10s)',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }

  // Helper UI Widgets
  TextStyle _headingStyle() => Theme.of(context).textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
        color: AppTheme.textMain,
      );

  Widget _buildVoicePromptBox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isListening ? AppTheme.primary : Colors.white.withOpacity(0.05),
          width: _isListening ? 1.5 : 1.0,
        ),
        boxShadow: _isListening ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 20)] : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              maxLines: 3,
              style: const TextStyle(color: AppTheme.textMain),
              decoration: InputDecoration(
                hintText: _isListening ? 'Listening... (e.g., Assemble sequence)' : 'E.g., Mini smart lock build...',
                hintStyle: TextStyle(
                  color: _isListening ? AppTheme.primary.withOpacity(0.8) : AppTheme.textMuted.withOpacity(0.5),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _isListening = !_isListening),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isListening ? AppTheme.primary : AppTheme.background,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isListening ? Icons.graphic_eq_rounded : Icons.mic_none_rounded,
                  color: _isListening ? Colors.white : AppTheme.textMain,
                  size: 24,
                ),
              ).animate(target: _isListening ? 1 : 0).scaleXY(end: 1.15, duration: 600.ms).shimmer(duration: 1000.ms).then().scaleXY(end: 1.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton(String label, String current, Function(String) onTap) {
    bool isSelected = label == current;
    return GestureDetector(
      onTap: () => onTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppTheme.primary : Colors.white.withOpacity(0.05)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textMuted,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleChip(String label, List<String> listRef) {
    bool isSelected = listRef.contains(label);
    return GestureDetector(
      onTap: () => setState(() => isSelected ? listRef.remove(label) : listRef.add(label)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withOpacity(0.15) : AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppTheme.primary : Colors.white.withOpacity(0.05)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primary : AppTheme.textMuted,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}