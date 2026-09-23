import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class UsageHistoryScreen extends StatelessWidget {
  const UsageHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for Usage Ledger
    final List<Map<String, dynamic>> history = [
      {'date': 'Today', 'items': [
        {'title': 'Omni Flash Render (10s)', 'time': '2:30 PM', 'cost': -10, 'icon': Icons.movie_creation_rounded},
        {'title': 'Ghost-to-Flesh Swap', 'time': '11:15 AM', 'cost': -2, 'icon': Icons.auto_awesome},
      ]},
      {'date': 'Yesterday', 'items': [
        {'title': 'UE5 Background Staging', 'time': '6:45 PM', 'cost': -2, 'icon': Icons.image_rounded},
        {'title': '100 Credits Purchased', 'time': '9:00 AM', 'cost': 100, 'icon': Icons.account_balance_wallet_rounded, 'isAdd': true},
        {'title': 'Virtual Try-On', 'time': '8:30 AM', 'cost': -2, 'icon': Icons.checkroom_rounded},
      ]},
      {'date': 'Sept 20, 2026', 'items': [ // Contextual date
        {'title': 'Omni Flash Render (5s)', 'time': '4:20 PM', 'cost': -5, 'icon': Icons.movie_creation_rounded},
      ]},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Usage History', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final section = history[index];
          final items = section['items'] as List<Map<String, dynamic>>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  section['date'],
                  style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ).animate().fadeIn(delay: (index * 100).ms),
              
              // Ledger Cards for that date
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: List.generate(items.length, (i) {
                    final item = items[i];
                    final isAdd = item['isAdd'] == true;
                    
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isAdd ? Colors.greenAccent.withOpacity(0.1) : AppTheme.background,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(item['icon'], color: isAdd ? Colors.greenAccent : AppTheme.textMain, size: 20),
                          ),
                          title: Text(item['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          subtitle: Text(item['time'], style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
                          trailing: Text(
                            '${isAdd ? '+' : ''}${item['cost']}',
                            style: TextStyle(
                              color: isAdd ? Colors.greenAccent : Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // Add divider if not the last item
                        if (i < items.length - 1)
                          Divider(color: Colors.white.withOpacity(0.05), height: 1, indent: 64, endIndent: 16),
                      ],
                    );
                  }),
                ),
              ).animate().fadeIn(delay: (index * 100 + 100).ms).slideY(begin: 0.1),
              
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}