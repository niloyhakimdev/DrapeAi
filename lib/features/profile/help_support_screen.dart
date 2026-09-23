import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Help & Support', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          // 1. Search Bar for Help Articles
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: TextField(
              style: const TextStyle(color: AppTheme.textMain),
              decoration: InputDecoration(
                hintText: 'Search for help...',
                hintStyle: TextStyle(color: AppTheme.textMuted.withOpacity(0.7), fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppTheme.textMuted, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),

          const SizedBox(height: 24),

          // 2. System Status (Crucial for AI apps)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 12, height: 12,
                  decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(duration: 1000.ms),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('All Systems Operational', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 2),
                      Text('Omni Flash & UE5 Engines are running smoothly.', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          // 3. Quick Actions Grid
          Text('Quick Actions', style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildQuickAction(context, Icons.generating_tokens_rounded, 'Refund Credit', AppTheme.accent)),
              const SizedBox(width: 16),
              Expanded(child: _buildQuickAction(context, Icons.bug_report_rounded, 'Report Bug', Colors.redAccent)),
            ],
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

          const SizedBox(height: 32),

          // 4. FAQs
          Text('Frequently Asked Questions', style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          _buildFAQItem(
            'Why did my video fail to generate?',
            'Sometimes the AI model gets overloaded. If a generation fails, your credits are automatically refunded within 5 minutes.',
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
          _buildFAQItem(
            'How do I get better Virtual Try-On results?',
            'Ensure the product image is well-lit and placed on a plain background. Use the "Ghost-to-Flesh" tool for best mannequin swaps.',
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
          _buildFAQItem(
            'Can I use the videos for commercial ads?',
            'Yes! All videos generated on the Pro Plan or Agency Plan come with full commercial rights and no watermarks.',
          ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),

          const SizedBox(height: 32),

          // 5. Contact Support Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppTheme.primary.withOpacity(0.5)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                backgroundColor: AppTheme.primary.withOpacity(0.1),
              ),
              icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primary, size: 20),
              label: const Text('Chat with Support', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String title, Color color) {
    return GestureDetector(
      onTap: () {}, // Future: Open specific modal
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent), // Removes the ugly default divider line in ExpansionTile
        child: ExpansionTile(
          iconColor: AppTheme.primary,
          collapsedIconColor: AppTheme.textMuted,
          title: Text(question, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(answer, style: TextStyle(color: AppTheme.textMuted, fontSize: 13, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}