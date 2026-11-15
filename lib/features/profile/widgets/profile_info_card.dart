import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.scale,
    this.name = 'كابتن أحمد محمد',
    this.levelAndWorkouts = 'مستوى متقدم • 142 تمرين مكتمل',
    this.memberSince = 'عضو منذ يناير 2025',
  });

  final double scale;
  final String name;
  final String levelAndWorkouts;
  final String memberSince;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.0 * scale),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.0 * scale),
      ),
      child: Row(
        children: [
          Container(
            width: 72.0 * scale,
            height: 72.0 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff15181E),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2.5 * scale,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person_rounded,
                color: AppColors.primaryColor,
                size: 42.0 * scale,
              ),
            ),
          ),
          SizedBox(width: 14.0 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppStyles.noto700Size28.copyWith(
                    fontSize: 18.0 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0 * scale),
                Text(
                  levelAndWorkouts,
                  style: TextStyle(
                    fontFamily: 'Noto',
                    fontSize: 13.0 * scale,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 4.0 * scale),
                Text(
                  memberSince,
                  style: AppStyles.noto400Size15.copyWith(
                    fontSize: 12.0 * scale,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
