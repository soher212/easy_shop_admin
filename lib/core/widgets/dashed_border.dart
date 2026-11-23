import 'package:easy_shop_admin/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double radius;

  const DashedBorder({super.key, required this.child, this.radius = 14});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DashedBorderPainter(radius), child: child);
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double radius;

  const _DashedBorderPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 5), paint);
        distance += 9;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.radius != radius;
}
