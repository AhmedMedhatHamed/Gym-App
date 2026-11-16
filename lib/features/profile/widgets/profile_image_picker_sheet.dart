import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/features/profile/cubit/profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';

class ProfileImagePickerSheet extends StatelessWidget {
  const ProfileImagePickerSheet({
    super.key,
    required this.hasAvatar,
    required this.onPickImage,
    required this.onRemoveAvatar,
  });

  final bool hasAvatar;
  final ValueChanged<ImageSource> onPickImage;
  final VoidCallback onRemoveAvatar;

  static void show(
    BuildContext context, {
    required bool hasAvatar,
    required ProfileCubit cubit,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (sheetContext) {
        return ProfileImagePickerSheet(
          hasAvatar: hasAvatar,
          onPickImage: (source) {
            Navigator.pop(sheetContext);
            cubit.pickImage(source);
          },
          onRemoveAvatar: () {
            Navigator.pop(sheetContext);
            cubit.removeAvatar();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => onPickImage(ImageSource.gallery),
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
                onTap: () => onPickImage(ImageSource.camera),
              ),
              if (hasAvatar)
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
                  onTap: onRemoveAvatar,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
