import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class StatisticsHeader extends StatelessWidget {
  const StatisticsHeader({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'الإحصائيات',
        style: AppStyles.noto700Size28.copyWith(
          fontSize: 22.0 * scale,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
