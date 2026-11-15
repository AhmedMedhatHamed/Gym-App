import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    super.key,
    required this.text1,
    required this.text2,
    this.onPressed,
  });

  final String text1;
  final String text2;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            text1,
            style: AppStyles.noto700Size18.copyWith(
              fontSize: 14.0,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        Text(text2, style: AppStyles.noto400Size15),
      ],
    );
  }
}
