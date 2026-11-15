import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/auth/login/widgets/login_form.dart';
import 'package:gym_app/features/auth/login/widgets/login_logo.dart';
import 'package:gym_app/features/auth/login/widgets/login_title_text.dart';
import 'package:gym_app/features/auth/widgets/already_have_acc.dart';
import 'package:material_ui/material_ui.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: LoginLogo()),
                SliverToBoxAdapter(child: LoginTitleText()),
                SliverToBoxAdapter(child: LoginForm()),
                SliverToBoxAdapter(child: SizedBox(height: 20.0)),
                SliverToBoxAdapter(
                  child: AlreadyHaveAccount(
                    text1: 'إنشاء حساب جديد',
                    text2: 'ليس لديك حساب؟',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.signupScreen);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

