import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/core/datasource/firebase_data_source.dart';
import 'package:gym_app/core/routes/app_routes.dart';
import 'package:gym_app/core/routes/app_routing.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:gym_app/features/profile/model/profile_model.dart';
import 'package:gym_app/features/profile/widgets/profile_badges_section.dart';
import 'package:gym_app/features/profile/widgets/profile_header.dart';
import 'package:gym_app/features/profile/widgets/profile_info_card.dart';
import 'package:gym_app/features/profile/widgets/profile_logout_button.dart';
import 'package:gym_app/features/profile/widgets/profile_workout_log_section.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const int _selectedNavIndex = 0;
  int _selectedBadgeIndex = 0;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (picked == null) return;
      final Uint8List bytes = await picked.readAsBytes();
      if (!mounted) return;
      profileImageNotifier.value = bytes;
    } on MissingPluginException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إعادة تشغيل التطبيق بالكامل لتفعيل اختيار الصور'),
        ),
      );
    } on PlatformException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'تعذر الوصول إلى الصور، تأكد من الصلاحيات',
          ),
        ),
      );
    }
  }

  void _showImagePickerSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.photo_library_rounded,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(
                      'اختيار صورة من المعرض',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.primaryColor,
                    ),
                    title: const Text(
                      'التقاط صورة بالكاميرا',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  if (profileImageNotifier.value != null)
                    ListTile(
                      leading: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xffFF4D4D),
                      ),
                      title: const Text(
                        'حذف الصورة الشخصية',
                        style: TextStyle(
                          fontFamily: 'Noto',
                          color: Color(0xffFF4D4D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        profileImageNotifier.value = null;
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
                        ValueListenableBuilder<Uint8List?>(
                          valueListenable: profileImageNotifier,
                          builder: (context, imageBytes, _) {
                            return ProfileInfoCard(
                              scale: scale,
                              imageBytes: imageBytes,
                              onAvatarTap: _showImagePickerSheet,
                            );
                          },
                        ),
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
                            profileImageNotifier.value = null;
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
  }
}
