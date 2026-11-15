import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class StatisticsSummaryRow extends StatelessWidget {
  const StatisticsSummaryRow({
    super.key,
    required this.scale,
    this.calories = '2,450',
    this.caloriesSubtitle = 'سعرة هذا الأسبوع',
    this.workoutMinutes = '180',
    this.minutesSubtitle = 'دقيقة تدريب',
  });

  final double scale;
  final String calories;
  final String caloriesSubtitle;
  final String workoutMinutes;
  final String minutesSubtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryStatCard(
            scale: scale,
            title: 'السعرات المحروقة',
            value: calories,
            subtitle: caloriesSubtitle,
            subtitleColor: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 12.0 * scale),
        Expanded(
          child: _SummaryStatCard(
            scale: scale,
            title: 'وقت التمرين',
            value: workoutMinutes,
            subtitle: minutesSubtitle,
            subtitleColor: const Color(0xff00D2FF),
          ),
        ),
      ],
    );
  }
}

class _SummaryStatCard extends StatelessWidget {
  const _SummaryStatCard({
    required this.scale,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.subtitleColor,
  });

  final double scale;
  final String title;
  final String value;
  final String subtitle;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0 * scale,
        vertical: 16.0 * scale,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.0 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppStyles.noto400Size15.copyWith(
              fontSize: 12.5 * scale,
              color: AppColors.textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.0 * scale),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: AppStyles.noto700Size28.copyWith(
                fontSize: 28.0 * scale,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 6.0 * scale),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Noto',
                fontSize: 12.5 * scale,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
