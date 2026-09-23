import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'subscription/subscription_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textMain,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppTheme.textMuted),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120), // Bottom padding for nav bar
        child: Column(
          children: [
            // 1. User Info Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanvir Ahmed',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textMain,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'tanvir@example.com',
                        style: TextStyle(color: AppTheme.textMuted, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      // Pro Plan Badge
                      GestureDetector(
                        onTap: () => context.push('/manage-subscription'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.primary.withOpacity(0.5)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_rounded, color: AppTheme.primary, size: 14),
                              SizedBox(width: 4),
                              Text(
                                'Pro Plan',
                                style: TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),

            const SizedBox(height: 32),

            // 2. Stats & Credits Board
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  _buildStatItem(
                    context,
                    '120',
                    'Credits left',
                    isHighlight: true,
                    onTap: () => SubscriptionSheet.show(context),
                  ),
                  _buildDivider(),
                  _buildStatItem(context, '42', 'Videos created'),
                  _buildDivider(),
                  _buildStatItem(context, '318', 'Images created'),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 32),

            // 3. Settings Group 1: Subscription & Credits
            _buildSettingsGroup([
              _buildSettingsTile(
                Icons.credit_card_rounded,
                'Manage Subscription',
                onTap: () => context.push('/manage-subscription'),
              ),
              _buildSettingsTile(
                Icons.generating_tokens_rounded,
                'Purchase Credits',
                onTap: () => SubscriptionSheet.show(context),
              ),
            ]).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            // 4. Settings Group 2: App & Support
            _buildSettingsGroup([
              _buildSettingsTile(
                Icons.history_rounded,
                'Usage History',
                onTap: () => context.push('/usage-history'),
              ),
              _buildSettingsTile(
                Icons.tune_rounded,
                'App Settings',
                onTap: () => context.push('/settings'),
              ),
              _buildSettingsTile(
                Icons.help_outline_rounded,
                'Help & Support',
                onTap: () => context.push('/help-support'),
              ),
            ]).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            // 5. Settings Group 3: Logout
            _buildSettingsGroup([
              _buildSettingsTile(
                Icons.logout_rounded, 
                'Log Out', 
                isDestructive: true,
                onTap: () => context.go('/auth'),
              ),
            ]).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildStatItem(BuildContext context, String value, String label, {bool isHighlight = false, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isHighlight ? AppTheme.accent : AppTheme.textMain,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textMuted,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, {bool isDestructive = false, required VoidCallback onTap}) {
    final color = isDestructive ? Colors.redAccent : AppTheme.textMain;
    
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.redAccent.withOpacity(0.1) : AppTheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: AppTheme.textMuted.withOpacity(0.5), size: 20),
    );
  }
}