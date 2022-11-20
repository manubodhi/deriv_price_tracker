import 'package:deriv_price_tracker/routes/route_names.dart';

import 'package:deriv_price_tracker/ui/home_screen.dart';
import 'package:deriv_price_tracker/ui/splash_screen.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  ///Add new routes here
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.homeScreen),
          builder: (_) => const SplashScreen(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.homeScreen),
          builder: (_) => HomeScreen(title: settings.arguments as String),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => SafeArea(
            top: true,
            left: true,
            bottom: true,
            right: true,
            child: Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ),
          ),
        );
    }
  }
}
