import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/utils/validators.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/features/auth/widgets/custom_text_field.dart';
import 'package:material_ui/material_ui.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(height: 50.0),
          Text(
            'Email Address',
            style: AppStyles.noto700Size18.copyWith(
              fontSize: 13.0,
              color: AppColors.primaryColor,
            ),
          ),
          CustomTextField(
            controller: emailController,
            obscureText: false,
            validator: Validator.validateEmail,
            text: 'ahmed@gympro.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: .emailAddress,
            textInputAction: .next,
          ),
          SizedBox(height: 30.0),
          Text(
            'Password',
            style: AppStyles.noto700Size18.copyWith(
              fontSize: 13.0,
              color: AppColors.primaryColor,
            ),
          ),
          CustomTextField(
            controller: passwordController,
            obscureText: true,
            validator: Validator.validatePassword,
            text: '••••••••••',
            prefixIcon: Icons.lock,
            suffixIcon: Icons.remove_red_eye,
            textInputAction: .done,
            keyboardType: .visiblePassword,
          ),
          SizedBox(height: 10.0),
          TextButton(
            onPressed: () {},
            child: Text(
              'نسيت كلمة المرور؟',
              style: AppStyles.noto700Size18.copyWith(
                fontSize: 13.0,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          CustomButton(
            text: 'تسجيل الدخول',
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
