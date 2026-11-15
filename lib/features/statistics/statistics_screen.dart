import 'package:flutter/material.dart';
import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/statistics/model/statistics_model.dart';
import 'package:gym_app/features/statistics/widgets/statistics_bottom_nav_bar.dart';
import 'package:gym_app/features/statistics/widgets/statistics_header.dart';
import 'package:gym_app/features/statistics/widgets/statistics_heart_rate_card.dart';
import 'package:gym_app/features/statistics/widgets/statistics_period_tabs.dart';
import 'package:gym_app/features/statistics/widgets/statistics_summary_row.dart';
import 'package:gym_app/features/statistics/widgets/statistics_weekly_activity_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPeriodIndex = 0;
  static const int _selectedNavIndex = 1;

  double _calculateScale(BuildContext context, BoxConstraints constraints) {
    final double screenWidth = constraints.hasBoundedWidth
        ? constraints.maxWidth
        : MediaQuery.sizeOf(context).width;
    return (screenWidth / 375.0).clamp(0.82, 1.25);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double scale = _calculateScale(context, constraints);

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0 * scale,
                  vertical: 12.0 * scale,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        StatisticsHeader(scale: scale),
                        SizedBox(height: 20.0 * scale),
                        StatisticsPeriodTabs(
                          scale: scale,
                          periods: statisticsPeriods,
                          selectedIndex: _selectedPeriodIndex,
                          onSelect: (index) {
                            setState(() {
                              _selectedPeriodIndex = index;
                            });
                          },
                        ),
                        SizedBox(height: 18.0 * scale),
                        StatisticsWeeklyActivityCard(
                          scale: scale,
                          days: weeklyActivityDays,
                        ),
                        SizedBox(height: 16.0 * scale),
                        StatisticsSummaryRow(scale: scale),
                        SizedBox(height: 16.0 * scale),
                        StatisticsHeartRateCard(scale: scale),
                        SizedBox(height: 16.0 * scale),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: StatisticsBottomNavBar(
              scale: scale,
              selectedIndex: _selectedNavIndex,
              onSelect: (index) {
                AppRouter.navigateByNavIndex(
                  context,
                  currentIndex: _selectedNavIndex,
                  targetIndex: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
