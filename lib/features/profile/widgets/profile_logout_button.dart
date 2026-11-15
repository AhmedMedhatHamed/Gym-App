import 'package:flutter/material.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({
    super.key,
    required this.scale,
    required this.onPressed,
  });

  final double scale;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const Color logoutColor = Color(0xffFF4D4D);

    return SizedBox(
      width: double.infinity,
      height: 54.0 * scale,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: logoutColor.withValues(alpha: 0.12),
          foregroundColor: logoutColor,
          side: BorderSide(
            color: logoutColor.withValues(alpha: 0.4),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0 * scale),
          ),
        ),
        icon: Icon(
          Icons.logout_rounded,
          size: 20.0 * scale,
          color: logoutColor,
        ),
        label: Text(
          'تسجيل الخروج',
          style: TextStyle(
            fontFamily: 'Noto',
            fontSize: 15.0 * scale,
            fontWeight: FontWeight.bold,
            color: logoutColor,
          ),
        ),
      ),
    );
  }
}
