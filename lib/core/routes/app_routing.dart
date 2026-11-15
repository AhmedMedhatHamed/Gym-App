import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/features/auth/login/login_screen.dart';
import 'package:gym_app/features/auth/signup/signup_screen.dart';
import 'package:gym_app/features/onboarding/onboarding_screen.dart';
import 'package:gym_app/features/splash/splash_screen.dart';
import 'package:material_ui/material_ui.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case AppRoutes.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
    }
    return null;
  }
}
