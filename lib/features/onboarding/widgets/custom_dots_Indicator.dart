import 'package:dots_indicator/dots_indicator.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/onboarding/model/onboarding_model.dart';
import 'package:material_ui/material_ui.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: onboardingList.length,
      position: index.toDouble(),
      decorator: DotsDecorator(
        color: AppColors.cardColor,
        activeColor: AppColors.primaryColor,
        size: Size.square(8.0),
        activeSize: Size(32.0, 8.0),
        spacing: EdgeInsets.symmetric(horizontal: 6.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
