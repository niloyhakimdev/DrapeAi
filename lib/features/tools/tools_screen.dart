import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import '../../core/theme/app_theme.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  int _selectedCategoryIndex = 0;
  
  final List<String> _categories = ['All', 'Fashion', 'E-commerce', 'Video', 'Utilities'];

  // Tool Data (Title, Description, and Thumbnail Image)
  final List<Map<String, String>> _tools = [
    {
      'title': 'Virtual Try-On',
      'desc': 'Upload clothes, see them on models',
      'img': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400&q=80',
    },
    {
      'title': 'Product Staging',
      'desc': 'Place products in lifestyle scenes',
      'img': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&q=80',
    },
    {
      'title': 'Ghost Mannequin',
      'desc': 'Remove mannequin effect',
      'img': 'https://images.unsplash.com/photo-1578932750294-f5075e85f44a?w=400&q=80',
    },
    {
      'title': 'Flat Lay to Model',
      'desc': 'Turn flat lays into real photos',
      'img': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&q=80',
    },
    {
      'title': 'Background Remover',
      'desc': 'Transparent + realistic shadow',
      'img': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400&q=80',
    },
    {
      'title': 'AI Retouch',
      'desc': 'Remove wrinkles, improve quality',
      'img': 'https://images.unsplash.com/photo-1611042553365-9b101441c135?w=400&q=80',
    },
    {
      'title': 'Lifestyle Video',
      'desc': 'Create motion scenes with AI',
      'img': 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=400&q=80',
    },
    {
      'title': 'Marketplace Ready',
      'desc': 'Amazon, Shopify, Daraz presets',
      'img': 'https://images.unsplash.com/photo-1592982537447-6f2334208f34?w=400&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Premium Glassmorphic App Bar
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: true,
            backgroundColor: AppTheme.background.withOpacity(0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: const FlexibleSpaceBar(background: SizedBox()),
              ),
            ),
            title: Text(
              'AI Tools',
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

          // 2. Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: TextField(
                  style: const TextStyle(color: AppTheme.textMain),
                  decoration: InputDecoration(
                    hintText: 'Search tools...',
                    hintStyle: TextStyle(color: AppTheme.textMuted.withOpacity(0.7), fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.textMuted, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1),
            ),
          ),

          // 3. Category Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isActive = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? AppTheme.primary : AppTheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isActive ? AppTheme.primary : Colors.white.withOpacity(0.05)),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            color: isActive ? Colors.white : AppTheme.textMuted,
                            fontSize: 13,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
          ),

          // 4. Tools Grid
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 120), // Bottom padding for nav bar
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8, // Taller cards to fit image + text
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tool = _tools[index];
                  return _buildToolCard(context, tool, index);
                },
                childCount: _tools.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, Map<String, String> tool, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Thumbnail
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(tool['img']!),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            // Play icon for video tools
            child: tool['title']!.contains('Video') 
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                      child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
                    ),
                  ) 
                : null,
          ),
        ),
        const SizedBox(height: 12),
        // Texts
        Text(
          tool['title']!,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textMain,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          tool['desc']!,
          style: TextStyle(
            color: AppTheme.textMuted,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ).animate().fadeIn(delay: (100 * index).ms).scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack);
  }
}