import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/auth/signup/widgets/signup_form.dart';
import 'package:gym_app/features/auth/signup/widgets/signup_header.dart';
import 'package:gym_app/features/auth/widgets/already_have_acc.dart';
import 'package:material_ui/material_ui.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                SliverToBoxAdapter(child: SignupHeader()),
                SliverToBoxAdapter(child: SignupForm()),
                SliverToBoxAdapter(
                  child: SizedBox(height: 20.0,),
                ),
                SliverToBoxAdapter(
                  child: AlreadyHaveAccount(
                    text1: 'تسجيل الدخول',
                    text2: 'لديك حساب بالفعل؟',
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
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
