import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutDetailsAppBar extends StatelessWidget {
  const WorkoutDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44.0,
            height: 44.0,
            decoration: const BoxDecoration(
              color: AppColors.cardColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.white,
              size: 18.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'تفاصيل التمرين',
            textAlign: TextAlign.center,
            style: AppStyles.noto700Size18.copyWith(color: AppColors.white),
          ),
        ),
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
          ),
          child: const Icon(
            Icons.grid_view_rounded,
            color: AppColors.primaryColor,
            size: 22.0,
          ),
        ),
      ],
    );
  }
}
