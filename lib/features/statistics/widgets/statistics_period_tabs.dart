import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';

class StatisticsPeriodTabs extends StatelessWidget {
  const StatisticsPeriodTabs({
    super.key,
    required this.scale,
    required this.periods,
    required this.selectedIndex,
    required this.onSelect,
  });

  final double scale;
  final List<String> periods;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0 * scale),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(18.0 * scale),
      ),
      child: Row(
        children: List.generate(periods.length, (index) {
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.symmetric(vertical: 10.0 * scale),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14.0 * scale),
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      periods[index],
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontSize: 13.5 * scale,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.backgroundColor
                            : AppColors.textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
