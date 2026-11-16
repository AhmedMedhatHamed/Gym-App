import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/home/widgets/activity_progress_card.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:material_ui/material_ui.dart';

class DailyActivitySection extends StatelessWidget {
  const DailyActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: burnedCaloriesNotifier,
      builder: (context, additionalCalories, _) {
        const int baseCalories = 640;
        final int totalCalories = baseCalories + additionalCalories;
        final double progress = (totalCalories / 820.0).clamp(0.0, 1.0);

        final String formattedCalories = totalCalories >= 1000
            ? '${(totalCalories ~/ 1000)},${(totalCalories % 1000).toString().padLeft(3, '0')}'
            : '$totalCalories';

        return Row(
          children: [
            Expanded(
              child: ActivityProgressCard(
                value: formattedCalories,
                progress: progress,
                progressColor: AppColors.primaryColor,
                title: 'السعرات المحروقة',
                subtitle: 'سعرة حرارية',
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: todayStepsNotifier,
                builder: (context, steps, _) {
                  const int goal = 10000;
                  final double stepProgress = (steps / goal).clamp(0.0, 1.0);
                  final String formattedSteps = steps >= 1000
                      ? '${(steps ~/ 1000)},${(steps % 1000).toString().padLeft(3, '0')}'
                      : '$steps';

                  return ActivityProgressCard(
                    value: formattedSteps,
                    progress: stepProgress,
                    progressColor: AppColors.cyanColor,
                    title: 'عدد الخطوات',
                    subtitle: 'الهدف: 10,000',
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
