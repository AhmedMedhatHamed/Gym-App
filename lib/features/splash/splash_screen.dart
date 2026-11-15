import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_consts.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, AppRoutes.onboardingScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset(AppConsts.splashImage),
            SizedBox(height: 17.0),
            Text(
              AppConsts.appName,
              style: TextStyle(
                fontSize: 38.0,
                fontWeight: .w700,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              AppConsts.splashText,
              style: AppStyles.noto700Size18.copyWith(
                fontSize: 22.0,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Text(AppConsts.splashSubText, style: AppStyles.noto400Size15),
          ],
        ),
      ),
    );
  }
}
