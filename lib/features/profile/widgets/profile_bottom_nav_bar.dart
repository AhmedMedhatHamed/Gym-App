import 'package:flutter/material.dart';
import 'package:gym_app/features/profile/widgets/profile_nav_item.dart';

class ProfileBottomNavBar extends StatelessWidget {
  const ProfileBottomNavBar({
    super.key,
    required this.scale,
    required this.selectedIndex,
    required this.onSelect,
  });

  final double scale;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Center(
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600.0),
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(
              left: 20.0 * scale,
              right: 20.0 * scale,
              bottom: 18.0 * scale,
              top: 8.0 * scale,
            ),
            child: Container(
              height: 68.0 * scale,
              decoration: BoxDecoration(
                color: const Color(0xff181B22),
                borderRadius: BorderRadius.circular(34.0 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 18.0,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileNavItem(
                    isSelected: selectedIndex == 0,
                    icon: Icons.person_outline_rounded,
                    scale: scale,
                    onTap: () => onSelect(0),
                  ),
                  ProfileNavItem(
                    isSelected: selectedIndex == 1,
                    icon: Icons.bar_chart_rounded,
                    scale: scale,
                    onTap: () => onSelect(1),
                  ),
                  ProfileNavItem(
                    isSelected: selectedIndex == 2,
                    icon: Icons.home_outlined,
                    scale: scale,
                    onTap: () => onSelect(2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
