
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/validators.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/features/auth/widgets/custom_text_field.dart';
import 'package:gym_app/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:material_ui/material_ui.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset email sent successfully'),
            ),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
        }

        if (state is ForgotPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              CustomTextField(
                controller: emailController,
                obscureText: false,
                text: 'Email Address',
                prefixIcon: Icons.email_outlined,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                validator: Validator.validateEmail,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              if (state is ForgotPasswordLoading)
                 CircularProgressIndicator(
                  color: AppColors.primaryColor,
                )
              else
                CustomButton(
                  text: 'Send',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgotPasswordCubit>().forgotPassword(
                        email: emailController.text.trim(),
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
