import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:gym_app/core/widgets/custom_button.dart';
import 'package:gym_app/features/onboarding/model/onboarding_model.dart';
import 'package:gym_app/features/onboarding/widgets/custom_dots_Indicator.dart';
import 'package:material_ui/material_ui.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(onboardingList[index].image),
                        SizedBox(height: 40.0),
                        CustomDotsIndicator(index: currentIndex,),
                        SizedBox(height: 30.0),
                        Text(
                          onboardingList[index].text,
                          style: AppStyles.noto700Size28,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          onboardingList[index].subtext,
                          textAlign: TextAlign.center,
                          style: AppStyles.noto400Size15,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: CustomButton(
                  text: currentIndex == onboardingList.length - 1
                      ? 'ابدأ الآن'
                      : 'التالي',
                  onPressed: () {
                    if (currentIndex < onboardingList.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                    else{
                      ///
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
