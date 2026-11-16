import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';

class ProfileWorkoutLogSection extends StatelessWidget {
  const ProfileWorkoutLogSection({
    super.key,
    required this.scale,
    this.workouts = profileWorkoutLogs,
    this.onDismissed,
  });

  final double scale;
  final List<ProfileWorkoutLogModel> workouts;
  final ValueChanged<int>? onDismissed;

  Widget _buildDismissBackground({required bool isStart}) {
    return Container(
      alignment: isStart
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      padding: EdgeInsets.symmetric(horizontal: 20.0 * scale),
      decoration: BoxDecoration(
        color: const Color(0xffFF4D4D),
        borderRadius: BorderRadius.circular(16.0 * scale),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.delete_outline_rounded,
            color: Colors.white,
            size: 24.0 * scale,
          ),
          SizedBox(width: 6.0 * scale),
          Text(
            'حذف',
            style: TextStyle(
              fontFamily: 'Noto',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0 * scale,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'سجل التمارين الأخيرة',
              style: AppStyles.noto700Size28.copyWith(
                fontSize: 17.0 * scale,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '(${workouts.length})',
              style: AppStyles.noto400Size15.copyWith(
                fontSize: 13.0 * scale,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0 * scale),
        if (workouts.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 24.0 * scale,
              horizontal: 16.0 * scale,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(16.0 * scale),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.fitness_center_rounded,
                  color: AppColors.textColor.withValues(alpha: 0.5),
                  size: 36.0 * scale,
                ),
                SizedBox(height: 10.0 * scale),
                Text(
                  'لا توجد تمارين مكتملة بعد',
                  style: AppStyles.noto700Size16.copyWith(
                    fontSize: 14.0 * scale,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 4.0 * scale),
                Text(
                  'ابدأ تمرينك الأول من الصفحة الرئيسية وسيتم تسجيله هنا',
                  textAlign: TextAlign.center,
                  style: AppStyles.noto400Size15.copyWith(
                    fontSize: 12.0 * scale,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workouts.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.0 * scale),
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Dismissible(
                key: ValueKey('${workout.title}_${workout.subtitle}_$index'),
                direction: DismissDirection.horizontal,
                background: _buildDismissBackground(isStart: true),
                secondaryBackground: _buildDismissBackground(isStart: false),
                onDismissed: (_) {
                  onDismissed?.call(index);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم حذف "${workout.title}" من السجل'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  );
                },
                child: Container(
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
                          color: workout.boxColor,
                          borderRadius: BorderRadius.circular(14.0 * scale),
                        ),
                        child: Center(
                          child: Text(
                            workout.emoji,
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
                              workout.title,
                              style: AppStyles.noto700Size28.copyWith(
                                fontSize: 15.0 * scale,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.0 * scale),
                            Text(
                              workout.subtitle,
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
                ),
              );
            },
          ),
      ],
    );
  }
}
