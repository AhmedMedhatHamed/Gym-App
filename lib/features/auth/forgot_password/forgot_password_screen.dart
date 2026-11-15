import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_consts.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/auth/forgot_password/widget/forgot_pass_form.dart';
import 'package:material_ui/material_ui.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Image.asset(
                AppConsts.forgotPassword,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Enter your email to recover your password',
                style: AppStyles.noto700Size28.copyWith(fontSize: 22.0),
                textAlign: .center,
              ),
            ),
           SliverToBoxAdapter(
             child: ForgotPassForm(),
           ),
          ],
        ),
      ),
    );
  }
}
