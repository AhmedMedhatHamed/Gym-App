import 'package:flutter/material.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:gym_app/features/profile/widgets/profile_badges_section.dart';
import 'package:gym_app/features/profile/widgets/profile_bottom_nav_bar.dart';
import 'package:gym_app/features/profile/widgets/profile_header.dart';
import 'package:gym_app/features/profile/widgets/profile_info_card.dart';
import 'package:gym_app/features/profile/widgets/profile_logout_button.dart';
import 'package:gym_app/features/profile/widgets/profile_workout_log_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int _selectedNavIndex = 0;
  int _selectedBadgeIndex = 0;

  double _calculateScale(BuildContext context, BoxConstraints constraints) {
    final double screenWidth = constraints.hasBoundedWidth
        ? constraints.maxWidth
        : MediaQuery.sizeOf(context).width;
    return (screenWidth / 375.0).clamp(0.82, 1.25);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double scale = _calculateScale(context, constraints);

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0 * scale,
                  vertical: 12.0 * scale,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileHeader(scale: scale),
                        SizedBox(height: 22.0 * scale),
                        ProfileInfoCard(scale: scale),
                        SizedBox(height: 26.0 * scale),
                        ProfileBadgesSection(
                          scale: scale,
                          badges: profileBadges,
                          selectedIndex: _selectedBadgeIndex,
                          onSelect: (index) {
                            setState(() {
                              _selectedBadgeIndex = index;
                            });
                          },
                        ),
                        SizedBox(height: 26.0 * scale),
                        ProfileWorkoutLogSection(
                          scale: scale,
                          workouts: profileWorkoutLogs,
                        ),
                        SizedBox(height: 20.0 * scale),
                        ProfileLogoutButton(
                          scale: scale,
                          onPressed: () async {
                            await FirebaseDataSource().logout();
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.loginScreen,
                                (route) => false,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 16.0 * scale),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: ProfileBottomNavBar(
              scale: scale,
              selectedIndex: _selectedNavIndex,
              onSelect: (index) {
                AppRouter.navigateByNavIndex(
                  context,
                  currentIndex: _selectedNavIndex,
                  targetIndex: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
