import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _highQualityRender = true;

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
        title: Text('App Settings', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsGroup('Preferences', [
            _buildSwitchTile(
              Icons.notifications_rounded, 
              'Push Notifications', 
              'Updates and completion alerts', 
              _notifications, 
              (v) => setState(() => _notifications = v)
            ),
            _buildDivider(),
            _buildSwitchTile(
              Icons.high_quality_rounded, 
              'Default 4K Render', 
              'Uses 2x credits for higher quality', 
              _highQualityRender, 
              (v) => setState(() => _highQualityRender = v)
            ),
          ]).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),

          const SizedBox(height: 24),

          _buildSettingsGroup('Account', [
            _buildActionTile(Icons.lock_rounded, 'Privacy & Security'),
            _buildDivider(),
            _buildActionTile(Icons.data_usage_rounded, 'Clear Cache'),
            _buildDivider(),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.delete_forever_rounded, color: Colors.redAccent, size: 20)),
              title: const Text('Delete Account', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 15)),
              onTap: () {}, // Future: Confirmation dialog
            ),
          ]).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(title, style: TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        Container(
          decoration: BoxDecoration(color: AppTheme.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.05))),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      secondary: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppTheme.textMain, size: 20)),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle, style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
      activeColor: AppTheme.primary,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildActionTile(IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppTheme.textMain, size: 20)),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
      trailing: Icon(Icons.chevron_right_rounded, color: AppTheme.textMuted.withOpacity(0.5), size: 20),
      onTap: () {},
    );
  }

  Widget _buildDivider() => Divider(color: Colors.white.withOpacity(0.05), height: 1, indent: 56);
}