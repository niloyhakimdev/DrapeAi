import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 2 ta tab: Videos, Images
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: Text(
          'My Content',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textMain,
              ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: AppTheme.textMuted), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list, color: AppTheme.textMuted), onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: AppTheme.textMuted,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'Videos'),
                Tab(text: 'Images'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildContentGrid(isVideo: true),
          _buildContentGrid(isVideo: false),
        ],
      ),
    );
  }

  Widget _buildContentGrid({required bool isVideo}) {
    // Dummy data for generated content
    final items = isVideo
        ? [
            {'title': 'Mini Smart Lock', 'time': '2 hours ago', 'img': 'https://images.unsplash.com/photo-1558002038-1055907df827?w=400&q=80', 'duration': '10s'},
            {'title': 'Fashion Runway', 'time': '1 day ago', 'img': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400&q=80', 'duration': '15s'},
            {'title': 'Matchbox Chopper', 'time': '2 days ago', 'img': 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=400&q=80', 'duration': '10s'},
            {'title': 'UGC Review', 'time': '3 days ago', 'img': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&q=80', 'duration': '05s'},
          ]
        : [
            {'title': 'Shirt Try-On', 'time': '1 day ago', 'img': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&q=80'},
            {'title': 'Shoe Staging', 'time': '2 days ago', 'img': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400&q=80'},
          ];

    return GridView.builder(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100), // Bottom padding for floating nav bar
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7, // 9:16 aspect ratio look
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildContentCard(item, isVideo, index);
      },
    );
  }

  Widget _buildContentCard(Map<String, String> item, bool isVideo, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(item['img']!),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient Overlay for text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          
          // Video Play Icon & Duration
          if (isVideo)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(item['duration']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

          // Title and Time
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item['time']!,
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11),
                ),
              ],
            ),
          ),
          
          // Options Menu (3 dots)
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 18),
              onPressed: () {}, // Future: Show bottom sheet for Delete/Share
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms).scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack);
  }
}