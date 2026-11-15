import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    this.validator,
    required this.text,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    required this.textInputAction,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final String text;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppStyles.noto400Size15.copyWith(color: AppColors.white),
      controller: controller,
      cursorColor: AppColors.primaryColor,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        fillColor: AppColors.cardColor,
        filled: true,
        hintText: text,
        hintStyle: AppStyles.noto700Size28.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
                onPressed: onSuffixIconPressed,
                icon: Icon(suffixIcon, color: AppColors.primaryColor),
              ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.cardColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
