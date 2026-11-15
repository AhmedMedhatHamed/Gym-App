import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class LoginTitleText extends StatelessWidget {
  const LoginTitleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        Text(
          '!مرحباً بعودتك يا بطل',
          style: AppStyles.noto700Size28.copyWith(fontSize: 26.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'سجل دخولك لمتابعة تمارينك ونظامك الغذائي',
          style: AppStyles.noto400Size15,
        ),
      ],
    );
  }
}
