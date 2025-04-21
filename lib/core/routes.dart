enum Routes {
  home,
  login,
  settings,
  dashboard,
  notFound,
  cookies,
  privacy,
}

extension AppRoutesExtension on Routes {
  String get path {
    switch (this) {
      case Routes.home:
        return '/home';
      case Routes.login:
        return '/login';
      case Routes.settings:
        return '/settings';
      case Routes.dashboard:
        return '/dashboard';
      case Routes.notFound:
        return '/not-found';
      case Routes.cookies:
        return '/cookies';
      case Routes.privacy:
        return '/privacy';
    }
  }
}