import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/home/widgets/activity_progress_card.dart';
import 'package:material_ui/material_ui.dart';

class DailyActivitySection extends StatelessWidget {
  const DailyActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: ActivityProgressCard(
            value: '640',
            progress: 0.78,
            progressColor: AppColors.primaryColor,
            title: 'السعرات المحروقة',
            subtitle: 'سعرة حرارية',
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: ActivityProgressCard(
            value: '8,420',
            progress: 0.842,
            progressColor: AppColors.cyanColor,
            title: 'عدد الخطوات',
            subtitle: 'الهدف: 10,000',
          ),
        ),
      ],
    );
  }
}
