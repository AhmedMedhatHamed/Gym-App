import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_consts.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/home/model/workout_program_model.dart';
import 'package:gym_app/features/workout_details/model/workout_details_model.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutProgramCard extends StatelessWidget {
  const WorkoutProgramCard({super.key, required this.program});

  final WorkoutProgramModel program;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final workout = program.image == AppConsts.dumbbellPress
            ? chestDumbbellWorkout
            : WorkoutDetailsModel.fromProgram(program);
        Navigator.pushNamed(
          context,
          AppRoutes.workoutDetailsScreen,
          arguments: workout,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20.0),
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
                          program.title,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.noto700Size16,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.backgroundColor,
                          size: 22.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '${program.exercisesCount} تمارين  •  ${program.durationMinutes} دقيقة  •  ${program.level}',
                    style: AppStyles.noto400Size15.copyWith(fontSize: 11.0),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '${program.calories} سعرة',
                    style: AppStyles.noto700Size16.copyWith(
                      fontSize: 12.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Image.asset(
                program.image,
                width: 72.0,
                height: 72.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
