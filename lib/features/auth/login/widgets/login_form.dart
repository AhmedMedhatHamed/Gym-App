import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/utils/validators.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/features/auth/login/cubit/login_cubit.dart';
import 'package:gym_app/features/auth/widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
          );

          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
        }

        if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 50.0),
              Text(
                'Email',
                style: AppStyles.noto700Size18.copyWith(
                  fontSize: 13,
                  color: AppColors.primaryColor,
                ),
              ),
              CustomTextField(
                controller: emailController,
                obscureText: false,
                validator: Validator.validateEmail,
                text: 'Email Address',
                prefixIcon: Icons.email_outlined,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30),
              Text(
                'Password',
                style: AppStyles.noto700Size18.copyWith(
                  fontSize: 13,
                  color: AppColors.primaryColor,
                ),
              ),
              CustomTextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                validator: Validator.validatePassword,
                text: '••••••••••',
                prefixIcon: Icons.lock,
                suffixIcon: isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                onSuffixIconPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
                },
                child: Text(
                  'نسيت كلمة المرور؟',
                  style: AppStyles.noto700Size18.copyWith(
                    fontSize: 13.0,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.15),

              if (state is LoginLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              else
                CustomButton(
                  text: 'تسجيل الدخول',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginCubit>().login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
