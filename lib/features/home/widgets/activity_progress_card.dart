import 'dart:math' as math;

import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';
import 'package:material_ui/material_ui.dart';

class ActivityProgressCard extends StatelessWidget {
  const ActivityProgressCard({
    super.key,
    required this.value,
    required this.progress,
    required this.progressColor,
    required this.title,
    required this.subtitle,
  });

  final String value;
  final double progress;
  final Color progressColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 110.0,
            width: 110.0,
            child: CustomPaint(
              painter: _RingPainter(
                progress: progress,
                color: progressColor,
              ),
              child: Center(
                child: Text(
                  value,
                  style: AppStyles.noto700Size16.copyWith(fontSize: 22.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.noto700Size16.copyWith(fontSize: 14.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppStyles.noto400Size15.copyWith(fontSize: 11.0),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 10.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = AppColors.chipColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
