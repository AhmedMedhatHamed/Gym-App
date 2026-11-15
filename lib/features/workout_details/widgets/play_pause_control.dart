
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/app_styles.dart';

class PlayPauseControl extends StatelessWidget {
  const PlayPauseControl({
    required this.isSelected,
    required this.isPaused,
    required this.remainingSeconds,
    required this.onPressed,
    super.key
  });

  final bool isSelected;
  final bool isPaused;
  final int remainingSeconds;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (isPaused) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: Text(
            '${remainingSeconds}sec',
            style: AppStyles.noto700Size16.copyWith(
              fontSize: 12.0,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        isSelected ? Icons.pause_rounded : Icons.play_arrow_rounded,
        color: isSelected ? AppColors.primaryColor : AppColors.textColor,
        size: 28.0,
      ),
    );
  }
}
