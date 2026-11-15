import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/features/statistics/model/statistics_model.dart';

class StatisticsWeeklyActivityCard extends StatelessWidget {
  const StatisticsWeeklyActivityCard({
    super.key,
    required this.scale,
    this.days = weeklyActivityDays,
    this.percentageText = '+18% عن السابق',
  });

  final double scale;
  final List<WeeklyActivityDayModel> days;
  final String percentageText;

  @override
  Widget build(BuildContext context) {
    final double maxBarHeight = 128.0 * scale;

    return Container(
      padding: EdgeInsets.all(18.0 * scale),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.0 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'النشاط الأسبوعي',
                  style: AppStyles.noto700Size28.copyWith(
                    fontSize: 17.0 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.0 * scale),
              Text(
                percentageText,
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontSize: 13.0 * scale,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 22.0 * scale),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(days.length, (index) {
              final day = days[index];
              final double factor = day.factor.clamp(0.1, 1.0);
              final Color barColor = day.color;
              final bool isHighlighted = day.isHighlighted;

              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: maxBarHeight,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 18.0 * scale,
                          height: maxBarHeight * factor,
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(9.0 * scale),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0 * scale),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        day.label,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Noto',
                          fontSize: 11.5 * scale,
                          fontWeight: isHighlighted
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isHighlighted
                              ? AppColors.primaryColor
                              : AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
