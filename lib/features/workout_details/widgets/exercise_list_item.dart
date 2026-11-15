import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/workout_details/model/workout_details_model.dart';
import 'package:gym_app/features/workout_details/widgets/play_pause_control.dart';
import 'package:material_ui/material_ui.dart';

class ExerciseListItem extends StatelessWidget {
  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.isPaused,
    required this.remainingSeconds,
    required this.onPlayPausePressed,
  });

  final ExerciseModel exercise;
  final bool isSelected;
  final bool isPaused;
  final int remainingSeconds;
  final VoidCallback onPlayPausePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(18.0),
        border: isSelected
            ? Border.all(color: AppColors.primaryColor, width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        exercise.title,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.noto700Size16.copyWith(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    PlayPauseControl(
                      isSelected: isSelected,
                      isPaused: isPaused,
                      remainingSeconds: remainingSeconds,
                      onPressed: onPlayPausePressed,
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  '${exercise.sets} جولات × ${exercise.reps} تكرار  •  استراحة ${exercise.restSeconds} ث',
                  style: AppStyles.noto400Size15.copyWith(fontSize: 11.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              exercise.image,
              width: 64.0,
              height: 64.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
