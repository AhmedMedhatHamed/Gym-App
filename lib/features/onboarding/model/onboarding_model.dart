class OnboardingModel {
  final String image, text, subtext;

  OnboardingModel({
    required this.image,
    required this.text,
    required this.subtext,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    image: 'assets/images/onboarding1.png',
    text: '! ابدأ رحلتك الرياضية',
    subtext:
        'تمرن بذكاء وحقق أهدافك البدنية مع خطط\n تدريبية مخصصة لك ومتابعة يومية دقيقة.',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding2.png',
    text: 'تنافس مع أصدقائك',
    subtext:
        'انضم للتحديات الجماعية، احصل على الأوسمة\n وتصدر قائمة الأبطال في الجيم كل أسبوع.',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding3.png',
    text: 'نظام غذائي متكامل',
    subtext:
        'احسب سعراتك الحرارية والماكروز بدقة\n مع وجبات صحية تناسب هدفك سواء تنشيف أو ضخامة.',
  ),
];
