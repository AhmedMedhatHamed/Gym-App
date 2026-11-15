import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/utils/validators.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:gym_app/features/auth/widgets/custom_text_field.dart';
import 'package:gym_app/features/home/home_screen.dart';
import 'package:material_ui/material_ui.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account created successfully')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }

        if (state is SignupFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 20.0),
              Text(
                'Full Name',
                style: AppStyles.noto700Size18.copyWith(
                  fontSize: 13.0,
                  color: AppColors.primaryColor,
                ),
              ),
              CustomTextField(
                controller: nameController,
                obscureText: false,
                validator: Validator.validateName,
                text: 'Ahmed M',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20.0),
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
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20.0),
              Text(
                'Phone',
                style: AppStyles.noto700Size18.copyWith(
                  fontSize: 13.0,
                  color: AppColors.primaryColor,
                ),
              ),
              CustomTextField(
                controller: phoneController,
                obscureText: false,
                validator: Validator.validatePhone,
                text: '010XXXXXXXX',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 20.0),
              Text(
                'Password',
                style: AppStyles.noto700Size18.copyWith(
                  fontSize: 13.0,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              if (state is SignupLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              else
                CustomButton(
                  text: 'إنشاء الحساب',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignupCubit>().signup(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        phone: phoneController.text.trim(),
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
