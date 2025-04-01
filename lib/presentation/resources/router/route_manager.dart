import 'package:flutter/material.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/view.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/register/view.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/splash/view.dart';


class Routes {
  static const String loginPage = "/loginPage";

  static const String splashPage = "/splashPage";

  static const String homePage = "/homePage";

  static const String onboardingPage = "/onboardingPage";
  static const String registerPage = "/registerPage";
  static const String bottomNavigationMainPage = "/bottomNavigationMainPage";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashPage:
        return _createRoute(const SplashPage());

      case Routes.loginPage:
        return _createRoute(LoginPage());

      case Routes.registerPage:
        return _createRoute(RegisterPage());

      default:
        return unDefinedRoute();
    }
  }

  /// Custom function for right-to-left page transition
  static PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start position (Right)
        const end = Offset.zero; // End position (Left)
        const curve = Curves.easeInOut; // Smooth transition

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration:
          const Duration(milliseconds: 300), // Speed of transition
    );
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("Page Not Found"),
        ),
      ),
    );
  }
}
