import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';

class WeeklyActivityDayModel {
  final String label;
  final double factor;
  final Color color;
  final bool isHighlighted;

  const WeeklyActivityDayModel({
    required this.label,
    required this.factor,
    required this.color,
    this.isHighlighted = false,
  });
}

const List<String> statisticsPeriods = ['الأسبوع', 'الشهر', 'السنة'];

const List<WeeklyActivityDayModel> weeklyActivityDays = [
  WeeklyActivityDayModel(
    label: 'سبت',
    factor: 0.55,
    color: Color(0xff2C303A),
  ),
  WeeklyActivityDayModel(
    label: 'أحد',
    factor: 0.85,
    color: Color(0xff7A9900),
  ),
  WeeklyActivityDayModel(
    label: 'اثنين',
    factor: 0.48,
    color: Color(0xff2C303A),
  ),
  WeeklyActivityDayModel(
    label: 'ثلاثاء',
    factor: 1.0,
    color: AppColors.primaryColor,
    isHighlighted: true,
  ),
  WeeklyActivityDayModel(
    label: 'أربعاء',
    factor: 0.72,
    color: Color(0xff7A9900),
  ),
  WeeklyActivityDayModel(
    label: 'خميس',
    factor: 0.90,
    color: AppColors.primaryColor,
  ),
  WeeklyActivityDayModel(
    label: 'جمعة',
    factor: 0.36,
    color: Color(0xff2C303A),
  ),
];
