import 'package:go_router/go_router.dart';
import 'package:hestia/pages/cookies_page.dart';
import 'package:hestia/pages/home_page.dart';
import 'package:hestia/pages/privacy_policy_page.dart';
import 'package:hestia/pages/settings_page.dart';
import 'routes.dart'; 

/// This class is responsible for managing the app's routing using the GoRouter package.
/// It defines the routes and their corresponding pages.
/// pages are imported from the pages enum.
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.home.path, // Set the initial route to HomePage
    routes: [
      GoRoute(path: Routes.home.path, name: Routes.home.name, builder: (context, state) => const HomePage(), ),
      GoRoute(path: Routes.settings.path, name: Routes.settings.name, builder: (context, state) => const SettingsPage(), ),
      GoRoute(path: Routes.cookies.path, name: Routes.cookies.name, builder: (context, state) => const CookiesPage()),
      GoRoute(path: Routes.privacy.path, name: Routes.privacy.name, builder: (context, state) => const PrivacyPolicyPage()),
    ],
  );
}