import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        Align(
          alignment: .topRight,
          child: Text(
            'إنشاء حساب جديد',
            style: AppStyles.noto700Size28.copyWith(fontSize: 22.0),
          ),
        ),
        SizedBox(height: 6.0),
        Align(
          alignment: .topRight,
          child: Text(
            'سجل بياناتك وابدأ خطتك التدريبية اليوم',
            style: AppStyles.noto400Size15,
          ),
        ),
      ],
    );
  }
}
