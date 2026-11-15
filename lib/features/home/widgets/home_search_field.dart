import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppStyles.noto400Size15.copyWith(color: AppColors.white),
      cursorColor: AppColors.primaryColor,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cardColor,
        hintText: 'ابحث عن تمرين، عضلة، أو مدرب...',
        hintStyle: AppStyles.noto400Size15.copyWith(fontSize: 13.0),
        prefixIcon: const Icon(Icons.search, color: AppColors.textColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: const BorderSide(color: AppColors.cardColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
