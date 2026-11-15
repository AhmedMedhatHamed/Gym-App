import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/workout_details/model/workout_details_model.dart';
import 'package:gym_app/features/workout_details/widgets/workout_stat_chip.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutInfoSection extends StatelessWidget {
  const WorkoutInfoSection({super.key, required this.workout});

  final WorkoutDetailsModel workout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          workout.title,
          style: AppStyles.noto700Size22,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            WorkoutStatChip(
              label: '${workout.sets} جولات × ${workout.reps} عد',
              color: AppColors.primaryColor,
            ),
            WorkoutStatChip(
              label: '${workout.calories} سعرة',
              color: AppColors.white,
            ),
            WorkoutStatChip(
              label: workout.level,
              color: AppColors.cyanColor,
            ),
          ],
        ),
      ],
    );
  }
}
