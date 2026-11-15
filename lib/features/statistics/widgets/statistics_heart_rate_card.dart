import 'package:flutter/material.dart';
import 'package:gym_app/core/utils/app_colors.dart';
import 'package:gym_app/core/utils/app_styles.dart';

class StatisticsHeartRateCard extends StatelessWidget {
  const StatisticsHeartRateCard({
    super.key,
    required this.scale,
    this.heartRateText = '75 نبضة/د',
  });

  final double scale;
  final String heartRateText;

  @override
  Widget build(BuildContext context) {
    const Color heartRateColor = Color(0xffFF4D4D);

    return Container(
      padding: EdgeInsets.all(18.0 * scale),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.0 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'معدل ضربات القلب',
                  style: AppStyles.noto700Size28.copyWith(
                    fontSize: 17.0 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.0 * scale),
              Text(
                heartRateText,
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontSize: 13.5 * scale,
                  fontWeight: FontWeight.bold,
                  color: heartRateColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.0 * scale),
          SizedBox(
            height: 84.0 * scale,
            width: double.infinity,
            child: CustomPaint(
              painter: HeartRateWaveformPainter(
                scale: scale,
                color: heartRateColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeartRateWaveformPainter extends CustomPainter {
  HeartRateWaveformPainter({required this.scale, required this.color});

  final double scale;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.6 * scale
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double w = size.width;
    final double h = size.height;

    final Path path = Path()
      ..moveTo(0.0, h * 0.55)
      ..lineTo(w * 0.16, h * 0.55)
      ..lineTo(w * 0.21, h * 0.34)
      ..lineTo(w * 0.25, h * 0.65)
      ..lineTo(w * 0.32, h * 0.10)
      ..lineTo(w * 0.39, h * 0.90)
      ..lineTo(w * 0.45, h * 0.32)
      ..lineTo(w * 0.50, h * 0.55)
      ..lineTo(w * 0.63, h * 0.55)
      ..lineTo(w * 0.69, h * 0.22)
      ..lineTo(w * 0.75, h * 0.84)
      ..lineTo(w * 0.80, h * 0.55)
      ..lineTo(w, h * 0.55);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant HeartRateWaveformPainter oldDelegate) {
    return oldDelegate.scale != scale || oldDelegate.color != color;
  }
}
