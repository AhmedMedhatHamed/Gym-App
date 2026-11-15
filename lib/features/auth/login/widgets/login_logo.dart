import 'package:gym_app/core/utils/app_consts.dart';
import 'package:material_ui/material_ui.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 73.0),
      child: Image.asset(
        AppConsts.splashImage,
        height: 84.0,
        width: 84.0,
      ),
    );
  }
}
