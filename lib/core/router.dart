import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hestia/auth/auth_provider.dart';
import 'package:hestia/presentation/pages/cookies_page.dart';
import 'package:hestia/presentation/pages/devices_page.dart';
import 'package:hestia/presentation/pages/home_page.dart';
import 'package:hestia/presentation/pages/landing_page.dart';
import 'package:hestia/presentation/pages/not_found_page.dart';
import 'package:hestia/presentation/pages/privacy_policy_page.dart';
import 'package:hestia/presentation/pages/registre_page.dart';
import 'package:hestia/presentation/pages/settings_page.dart';
import 'package:hestia/presentation/pages/login_page.dart';
import 'routes.dart';

/// This class is responsible for managing the app's routing using the GoRouter package.
/// It defines the routes and their corresponding pages.
/// pages are imported from the pages enum.
class AppRouter {
  static bool devMode = true;

  static final GoRouter router = GoRouter(
    initialLocation: Routes.home.path,
    refreshListenable: GoRouterRefreshNotifier(AuthState.instance),

    redirect:
        devMode
            ? null // Slå redirect fra i devMode
            : (context, state) {
              final loggedIn = AuthState.instance.isLoggedIn;
              final isOnLogin = state.uri.path == Routes.login.path;
              final isOnRegister = state.uri.path == Routes.registre.path;
              final isOnLandingPage = state.uri.path == Routes.landingPage.path;

              if (!loggedIn &&
                  !(isOnLogin || isOnRegister || isOnLandingPage)) {
                return Routes.login.path;
              }

              if (loggedIn && (isOnLogin || isOnRegister)) {
                return Routes.home.path;
              }

              return null;
            },

    errorBuilder: (context, state) => const NotFoundPage(),

    routes: [
      GoRoute(
        path: Routes.home.path,
        builder: (context, _) => const HomePage(),
      ),
      GoRoute(
        path: Routes.settings.path,
        builder: (context, _) => const SettingsPage(),
      ),
      GoRoute(
        path: Routes.cookies.path,
        builder: (context, _) => const CookiesPage(),
      ),
      GoRoute(
        path: Routes.privacy.path,
        builder: (context, _) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: Routes.landingPage.path,
        builder: (context, _) => const LandingPage(),
      ),
      GoRoute(
        path: Routes.login.path,
        builder: (context, _) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.registre.path,
        builder: (context, _) => const RegistrePage(),
      ),
      GoRoute(
        path: Routes.devices.path,
        builder: (context, _) => const DevicesPage(),
      ),
    ],
  );
}

class GoRouterRefreshNotifier extends ChangeNotifier {
  GoRouterRefreshNotifier(Listenable listenable) {
    listenable.addListener(notifyListeners);
  }
}
