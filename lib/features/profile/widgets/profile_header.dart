import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return Row(
      children: [
        if (canPop) ...[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44.0 * scale,
              height: 44.0 * scale,
              decoration: const BoxDecoration(
                color: AppColors.cardColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.white,
                size: 18.0 * scale,
              ),
            ),
          ),
          SizedBox(width: 12.0 * scale),
        ],
        Expanded(
          child: Text(
            'الملف الشخصي والإنجازات',
            style: AppStyles.noto700Size28.copyWith(
              fontSize: 20.0 * scale,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
