import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/features/auth/login/cubit/login_cubit.dart';
import 'package:gym_app/features/auth/login/login_screen.dart';
import 'package:gym_app/features/auth/signup/cubit/signup_cubit.dart';
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
        );

      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case AppRoutes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(),
            child: SignupScreen(),
          ),
        );
    }
    return null;
  }
}
