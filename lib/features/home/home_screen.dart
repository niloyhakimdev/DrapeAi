import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../core/theme/app_theme.dart';
import '../profile/subscription/subscription_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Premium Glassmorphic App Bar
          SliverAppBar(
            expandedHeight: 70,
            floating: true,
            pinned: true,
            backgroundColor: AppTheme.background.withOpacity(0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: const FlexibleSpaceBar(background: SizedBox()),
              ),
            ),
            title: Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Good morning,', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textMuted)),
                    Text('Tanvir 👋', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => SubscriptionSheet.show(context),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                      boxShadow: [BoxShadow(color: AppTheme.accent.withOpacity(0.1), blurRadius: 8)],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.generating_tokens_rounded, color: AppTheme.accent, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '120',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.accent,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ).animate().shimmer(duration: 2000.ms, delay: 1000.ms),
                ),
              ],
            ),
          ),

          // 2. Redesigned Smart AI Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(100), // Fully rounded pill shape
                  border: Border.all(color: AppTheme.primary.withOpacity(0.3), width: 1.5),
                  boxShadow: [BoxShadow(color: AppTheme.primary.withOpacity(0.1), blurRadius: 15)],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(Icons.auto_awesome, color: AppTheme.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.go('/studio'),
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          'Describe what you want to create...',
                          style: TextStyle(color: AppTheme.textMuted.withOpacity(0.8), fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Actionable Mic Button for Voice-to-Video
                    GestureDetector(
                      onTap: () => context.go('/studio'),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.mic_rounded, color: AppTheme.primary, size: 18),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
            ),
          ),

          // 3. Actionable Hero Carousel (With Images & Buttons)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 190, // Slightly taller for better proportions
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildHeroCard(
                    context,
                    'Omni Flash Ads',
                    '10s vertical sequences with whip cuts.',
                    const [AppTheme.primary, Color(0xFF8C8AFA)],
                    'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&q=80',
                    'Try Auto-Edit',
                  ),
                  const SizedBox(width: 16),
                  _buildHeroCard(
                    context,
                    'UE5 DreamWorks',
                    'Cinematic realism for product staging.',
                    const [Color(0xFF2A2A2A), Color(0xFF4A4A4A)],
                    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80',
                    'Stage Product',
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.1),
          ),

          // 4. Compact Tools Grid (Polished)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 28, bottom: 16),
              child: Text(
                'Start with a tool',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textMain),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tools = [
                    {'title': 'Try-On', 'img': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=200&q=80'},
                    {'title': 'Stage', 'img': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=200&q=80'},
                    {'title': 'No BG', 'img': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=200&q=80'},
                    {'title': 'Upscale', 'img': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=200&q=80'},
                  ];
                  return _buildCompactToolCard(context, tools[index]['title']!, tools[index]['img']!, index);
                },
                childCount: 4,
              ),
            ),
          ),

          // 5. Ready-to-Use Templates
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 32, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ready-to-Use Templates',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textMain),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/tools'),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text('See All', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                children: const [
                  _CategoryChip(title: 'All', isActive: true),
                  _CategoryChip(title: '9:16 Ads'),
                  _CategoryChip(title: 'DIY & Builds'),
                  _CategoryChip(title: 'E-commerce'),
                  _CategoryChip(title: 'Fashion'),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 16),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildTemplateCard(context, 'Mini Smart Door Lock', 'Step-by-step assemble sequence.', 'https://images.unsplash.com/photo-1558002038-1055907df827?w=300&q=80', 0),
                  _buildTemplateCard(context, 'Matchbox Chopper', 'DIY mini-build motion edit.', 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=300&q=80', 1),
                  _buildTemplateCard(context, 'Seed Planting Machine', 'Fast hard cuts + ASMR audio.', 'https://images.unsplash.com/photo-1592982537447-6f2334208f34?w=300&q=80', 2),
                ],
              ),
            ),
          ),

          // 6. Community Inspiration / 1-Click Remix Feed (🔥 Kept intact as requested)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 28, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Community Feed',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textMain),
                  ),
                  GestureDetector(
                    onTap: () => context.go('/studio'),
                    child: Text('See All', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),

          // 9:16 Vertical Content Inspiration List with 1-Click Remix Button
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final feedItems = [
                    {
                      'title': 'Mini DIY Build',
                      'meta': '10s • ASMR Sync',
                      'img': 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=600&q=80',
                    },
                    {
                      'title': 'Cyberpunk Watch Ad',
                      'meta': '15s • DreamWorks Omni',
                      'img': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80',
                    },
                    {
                      'title': 'Sneaker Drop Motion',
                      'meta': '10s • Whip Cuts',
                      'img': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
                    },
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildInspirationItem(
                      context,
                      feedItems[index]['title']!,
                      feedItems[index]['meta']!,
                      feedItems[index]['img']!,
                      index,
                    ),
                  );
                },
                childCount: 3,
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  // --- Helper Widgets Below ---

  Widget _buildHeroCard(BuildContext context, String title, String subtitle, List<Color> gradient, String bgImage, String btnText) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        image: DecorationImage(
          image: NetworkImage(bgImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(color: gradient.first.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Stack(
        children: [
          // Featured Badge
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
              child: const Text('✨ Featured', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          // Content & Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5)),
                const SizedBox(height: 6),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.8)), maxLines: 2),
                const SizedBox(height: 16),
                // Premium CTA Button
                GestureDetector(
                  onTap: () => context.go('/studio'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(btnText, style: TextStyle(color: gradient.first, fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: gradient.first, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactToolCard(BuildContext context, String title, String imageUrl, int index) {
    return GestureDetector(
      onTap: () => context.go('/tools'),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
        ],
      ).animate().fadeIn(delay: (100 * index).ms).scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack),
    );
  }

  Widget _buildTemplateCard(BuildContext context, String title, String subtitle, String imageUrl, int index) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                // Integrated Remix Button in Templates
                GestureDetector(
                  onTap: () => context.go('/studio'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(12)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text('Remix', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (200 + (index * 100)).ms).slideX(begin: 0.1);
  }

  // 1-Click Remix Inspiration Feed Item
  Widget _buildInspirationItem(BuildContext context, String title, String meta, String imageUrl, int index) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Dark Gradient Overlay for text visibility
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            
            // Play Button (Center)
            Center(
              child: Icon(Icons.play_circle_fill_rounded, size: 48, color: Colors.white.withOpacity(0.5)),
            ),
            
            // Video Tags (Bottom Left)
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(meta, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                  ),
                ],
              ),
            ),

            // 🔥 1-Click Remix Button (Bottom Right)
            Positioned(
              bottom: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  context.go('/studio');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, Color(0xFF8C8AFA)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: AppTheme.primary.withOpacity(0.5), blurRadius: 12, offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text('Remix', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                )
                // Shimmer animation to grab attention
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .shimmer(duration: 2500.ms, color: Colors.white54, delay: 1000.ms),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (200 + (index * 100)).ms).slideY(begin: 0.2);
  }
}

class _CategoryChip extends StatelessWidget {
  final String title;
  final bool isActive;

  const _CategoryChip({required this.title, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary : AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppTheme.primary : Colors.white.withOpacity(0.05)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: isActive ? Colors.white : AppTheme.textMuted, fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.w500),
        ),
      ),
    );
  }
}