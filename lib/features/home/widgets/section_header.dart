import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppStyles.noto700Size16.copyWith(fontSize: 18.0)),
        const Spacer(),
        if (actionText != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText!,
              style: AppStyles.noto400Size15.copyWith(
                fontSize: 13.0,
                color: AppColors.white,
              ),
            ),
          ),
      ],
    );
  }
}
