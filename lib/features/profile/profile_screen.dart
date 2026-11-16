import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:gym_app/features/profile/cubit/profile_cubit.dart';
import 'package:gym_app/features/profile/widgets/profile_badges_section.dart';
import 'package:gym_app/features/profile/widgets/profile_header.dart';
import 'package:gym_app/features/profile/widgets/profile_image_picker_sheet.dart';
import 'package:gym_app/features/profile/widgets/profile_info_card.dart';
import 'package:gym_app/features/profile/widgets/profile_logout_button.dart';
import 'package:gym_app/features/profile/widgets/profile_workout_log_section.dart';
import 'package:material_ui/material_ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const int _selectedNavIndex = 0;

  double _calculateScale(BuildContext context, BoxConstraints constraints) {
    final double screenWidth = constraints.hasBoundedWidth
        ? constraints.maxWidth
        : MediaQuery.sizeOf(context).width;
    return (screenWidth / 375.0).clamp(0.82, 1.25);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginScreen,
            (route) => false,
          );
        } else if (state is ProfileActionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final profile = switch (state) {
          ProfileLoaded() => state,
          ProfileActionError(:final previousState) => previousState,
          _ => null,
        };

        if (profile == null) {
          return const Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        }

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
                            ProfileInfoCard(
                              scale: scale,
                              imageBytes: profile.avatarBytes,
                              onAvatarTap: () {
                                ProfileImagePickerSheet.show(
                                  context,
                                  hasAvatar: profile.avatarBytes != null,
                                  cubit: context.read<ProfileCubit>(),
                                );
                              },
                            ),
                            SizedBox(height: 26.0 * scale),
                            ProfileBadgesSection(
                              scale: scale,
                              badges: profile.badges,
                              selectedIndex: profile.selectedBadgeIndex,
                              onSelect: (index) {
                                context.read<ProfileCubit>().selectBadge(index);
                              },
                            ),
                            SizedBox(height: 26.0 * scale),
                            ProfileWorkoutLogSection(
                              scale: scale,
                              workouts: profile.workoutLogs,
                            ),
                            SizedBox(height: 20.0 * scale),
                            ProfileLogoutButton(
                              scale: scale,
                              onPressed: profile.isLoggingOut
                                  ? null
                                  : () => context.read<ProfileCubit>().logout(),
                            ),
                            SizedBox(height: 16.0 * scale),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
                  child: CustomBottomNavBar(
                    currentIndex: _selectedNavIndex,
                    onTap: (index) {
                      AppRouter.navigateByNavIndex(
                        context,
                        currentIndex: _selectedNavIndex,
                        targetIndex: index,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
