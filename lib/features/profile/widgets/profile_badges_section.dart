import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class ProfileBadgesSection extends StatelessWidget {
  const ProfileBadgesSection({
    super.key,
    required this.scale,
    required this.badges,
    required this.selectedIndex,
    required this.onSelect,
    this.totalBadgesCount = 5,
  });

  final double scale;
  final List<Map<String, dynamic>> badges;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final int totalBadgesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الأوسمة والشارات ($totalBadgesCount)',
          style: AppStyles.noto700Size28.copyWith(
            fontSize: 17.0 * scale,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14.0 * scale),
        Row(
          children: List.generate(badges.length, (index) {
            final badge = badges[index];
            final isSelected = selectedIndex == index;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == badges.length - 1 ? 0.0 : 5.0 * scale,
                  right: index == 0 ? 0.0 : 5.0 * scale,
                ),
                child: GestureDetector(
                  onTap: () => onSelect(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      vertical: 14.0 * scale,
                      horizontal: 8.0 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(16.0 * scale),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 38.0 * scale,
                          height: 38.0 * scale,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: badge['bgColor'] as Color,
                          ),
                          child: Center(
                            child: Text(
                              badge['emoji'] as String,
                              style: TextStyle(fontSize: 20.0 * scale),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0 * scale),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            badge['title'] as String,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontSize: 12.0 * scale,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
