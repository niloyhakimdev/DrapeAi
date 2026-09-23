import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens import
import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/main_layout/main_layout.dart';
import '../../features/tools/tools_screen.dart';
import '../../features/studio/studio_screen.dart';
import '../../features/studio/generation_progress_screen.dart';
import '../../features/studio/result_preview_screen.dart';
import '../../features/library/library_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/usage_history_screen.dart';
import '../../features/profile/settings_screen.dart';
import '../../features/profile/help_support_screen.dart';
import '../../features/profile/manage_subscription_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/progress',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const GenerationProgressScreen(),
    ),
    GoRoute(
      path: '/preview',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ResultPreviewScreen(),
    ),
    GoRoute(
      path: '/usage-history',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const UsageHistoryScreen(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/help-support',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      path: '/manage-subscription',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ManageSubscriptionScreen(),
    ),
    
    // StatefulShellRoute implements bottom navigation with preserved state
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Home
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          ],
        ),
        // Tab 2: AI Tools
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/tools', builder: (context, state) => const ToolsScreen()),
          ],
        ),
        // Tab 3: Video Studio (Central Button)
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/studio', builder: (context, state) => const StudioScreen()),
          ],
        ),
        // Tab 4: Library / Content
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/library', builder: (context, state) => const LibraryScreen()),
          ],
        ),
        // Tab 5: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
          ],
        ),
      ],
    ),
  ],
);