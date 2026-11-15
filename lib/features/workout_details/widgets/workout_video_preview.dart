import 'package:gym_app/core/utils/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutVideoPreview extends StatelessWidget {
  const WorkoutVideoPreview({
    super.key,
    required this.imagePath,
    this.onPlayPressed,
  });

  final String imagePath;
  final VoidCallback? onPlayPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: AppColors.chipColor,
            width: 1.0,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.45),
              colorBlendMode: BlendMode.darken,
            ),
            Center(
              child: GestureDetector(
                onTap: onPlayPressed,
                child: Container(
                  width: 72.0,
                  height: 72.0,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.35),
                        blurRadius: 24.0,
                        spreadRadius: 8.0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.backgroundColor,
                    size: 42.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
