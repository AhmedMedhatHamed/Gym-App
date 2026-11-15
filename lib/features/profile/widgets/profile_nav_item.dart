import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';

class ProfileNavItem extends StatelessWidget {
  const ProfileNavItem({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.scale,
    required this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final double scale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50.0 * scale,
        height: 50.0 * scale,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 27.0 * scale,
            color: isSelected ? Colors.black : const Color(0xff757B88),
          ),
        ),
      ),
    );
  }
}
