import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:gym_app/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:gym_app/features/auth/login/cubit/login_cubit.dart';
import 'package:gym_app/features/auth/login/login_screen.dart';
import 'package:gym_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:gym_app/features/auth/signup/signup_screen.dart';
import 'package:gym_app/features/home/cubit/home_cubit.dart';
import 'package:gym_app/features/home/home_screen.dart';
import 'package:gym_app/features/home/model/workout_program_model.dart';
import 'package:gym_app/features/onboarding/onboarding_screen.dart';
import 'package:gym_app/features/profile/cubit/profile_cubit.dart';
import 'package:gym_app/features/profile/profile_screen.dart';
import 'package:gym_app/features/splash/splash_screen.dart';
import 'package:gym_app/features/statistics/statistics_screen.dart';
import 'package:gym_app/features/workout_details/model/workout_details_model.dart';
import 'package:gym_app/features/workout_details/workout_details_screen.dart';
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

      case AppRoutes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordCubit(),
            child: ForgotPasswordScreen(),
          ),
        );

      case AppRoutes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignupCubit(),
            child: SignupScreen(),
          ),
        );

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(),
            child: const HomeScreen(),
          ),
        );

      case AppRoutes.workoutDetailsScreen:
        final args = settings.arguments;
        final workout = args is WorkoutDetailsModel
            ? args
            : args is WorkoutProgramModel
                ? WorkoutDetailsModel.fromProgram(args)
                : chestDumbbellWorkout;
        return MaterialPageRoute(
          builder: (_) => WorkoutDetailsScreen(workout: workout),
        );

      case AppRoutes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProfileCubit(),
            child: const ProfileScreen(),
          ),
        );

      case AppRoutes.statisticsScreen:
        return MaterialPageRoute(builder: (_) => const StatisticsScreen());
    }
    return null;
  }

  static void navigateByNavIndex(
    BuildContext context, {
    required int currentIndex,
    required int targetIndex,
  }) {
    if (targetIndex == currentIndex) return;

    if (currentIndex == -1) {
      switch (targetIndex) {
        case 0:
          Navigator.pushNamed(context, AppRoutes.profileScreen);
          return;
        case 1:
          Navigator.pushNamed(context, AppRoutes.statisticsScreen);
          return;
        case 2:
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          }
          return;
      }
    }

    switch (targetIndex) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.profileScreen);
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.statisticsScreen);
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    }
  }
}
