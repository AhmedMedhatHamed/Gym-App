import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/utils/validators.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/features/auth/widgets/custom_text_field.dart';
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
            text: 'AhmedM',
            prefixIcon: Icons.person,
            keyboardType: .name,
            textInputAction: .next,
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
            keyboardType: .emailAddress,
            textInputAction: .next,
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
            keyboardType: .phone,
            textInputAction: .next,
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
            obscureText: true,
            validator: Validator.validatePassword,
            text: '••••••••••',
            prefixIcon: Icons.lock,
            suffixIcon: Icons.remove_red_eye,
            textInputAction: .done,
            keyboardType: .visiblePassword,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          CustomButton(text: 'إنشاء الحساب', onPressed: () {}),
        ],
      ),
    );
  }
}
