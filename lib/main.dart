import 'package:firebase_core/firebase_core.dart';
import 'package:gym_app/core/datasource/hive_data_source.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:gym_app/firebase_options.dart';
import 'package:material_ui/material_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await HiveDataSource.init();
  profileImageNotifier.value = HiveDataSource.getProfileImage();
  userNameNotifier.value = HiveDataSource.getUserName() ?? '';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym_App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
