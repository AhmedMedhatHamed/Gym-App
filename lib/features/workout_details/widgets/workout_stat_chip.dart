import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class WorkoutStatChip extends StatelessWidget {
  const WorkoutStatChip({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.chipColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label,
        style: AppStyles.noto700Size16.copyWith(
          fontSize: 12.0,
          color: color,
        ),
      ),
    );
  }
}
