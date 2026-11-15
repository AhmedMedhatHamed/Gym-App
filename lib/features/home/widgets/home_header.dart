import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.textColor, width: 1.5),
          ),
        ),
        const SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'صباح النشاط',
              style: AppStyles.noto400Size15.copyWith(fontSize: 13.0),
            ),
            Text(
              'مرحبا، كابتن!',
              style: AppStyles.noto700Size22,
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 46.0,
          height: 46.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.chipColor, width: 2.0),
          ),
          child: const Icon(
            Icons.autorenew_rounded,
            color: AppColors.white,
            size: 22.0,
          ),
        ),
      ],
    );
  }
}
