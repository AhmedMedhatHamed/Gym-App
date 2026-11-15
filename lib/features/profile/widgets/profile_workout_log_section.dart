import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class ProfileWorkoutLogSection extends StatelessWidget {
  const ProfileWorkoutLogSection({
    super.key,
    required this.scale,
    required this.workouts,
  });

  final double scale;
  final List<Map<String, dynamic>> workouts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'سجل التمارين الأخيرة',
          style: AppStyles.noto700Size28.copyWith(
            fontSize: 17.0 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14.0 * scale),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: workouts.length,
          separatorBuilder: (_, _) => SizedBox(height: 12.0 * scale),
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0 * scale,
                vertical: 14.0 * scale,
              ),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(16.0 * scale),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.0 * scale,
                    height: 48.0 * scale,
                    decoration: BoxDecoration(
                      color: workout['boxColor'] as Color,
                      borderRadius: BorderRadius.circular(14.0 * scale),
                    ),
                    child: Center(
                      child: Text(
                        workout['emoji'] as String,
                        style: TextStyle(fontSize: 22.0 * scale),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.0 * scale),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout['title'] as String,
                          style: AppStyles.noto700Size28.copyWith(
                            fontSize: 15.0 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0 * scale),
                        Text(
                          workout['subtitle'] as String,
                          style: AppStyles.noto400Size15.copyWith(
                            fontSize: 12.5 * scale,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
