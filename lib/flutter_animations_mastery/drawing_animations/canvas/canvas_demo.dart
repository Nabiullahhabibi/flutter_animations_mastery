import 'dart:math' as math;

import 'package:flutter/material.dart';

class CanvasDemo extends StatefulWidget {
  const CanvasDemo({super.key});

  @override
  State<CanvasDemo> createState() => _CanvasDemoState();
}

class _CanvasDemoState extends State<CanvasDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(320, 420),
              painter: CanvasPainter(
                progress: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  final double progress;

  CanvasPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ----------------------------------------------------------
    // 1. Background
    // ----------------------------------------------------------

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade100
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Offset.zero & size,
      backgroundPaint,
    );

    // ----------------------------------------------------------
    // 2. Circle
    // ----------------------------------------------------------

    final circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, 80),
      45,
      circlePaint,
    );

    // ----------------------------------------------------------
    // 3. Circle border
    // ----------------------------------------------------------

    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      Offset(size.width / 2, 80),
      45,
      borderPaint,
    );

    // ----------------------------------------------------------
    // 4. Rectangle
    // ----------------------------------------------------------

    final rectanglePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      const Rect.fromLTWH(
        40,
        150,
        100,
        70,
      ),
      rectanglePaint,
    );

    // ----------------------------------------------------------
    // 5. Rounded rectangle
    // ----------------------------------------------------------

    final roundedRectanglePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(
          180,
          150,
          100,
          70,
        ),
        const Radius.circular(16),
      ),
      roundedRectanglePaint,
    );

    // ----------------------------------------------------------
    // 6. Line
    // ----------------------------------------------------------

    final linePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      const Offset(40, 260),
      Offset(size.width - 40, 260),
      linePaint,
    );

    // ----------------------------------------------------------
    // 7. Oval
    // ----------------------------------------------------------

    final ovalPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      const Rect.fromLTWH(
        80,
        290,
        160,
        70,
      ),
      ovalPaint,
    );

    // ----------------------------------------------------------
    // 8. Animated rotating line
    // ----------------------------------------------------------

    final center = Offset(
      size.width / 2,
      390,
    );

    const radius = 25.0;

    final angle = progress * 2 * math.pi;

    final endPoint = Offset(
      center.dx + math.cos(angle) * radius,
      center.dy + math.sin(angle) * radius,
    );

    final animatedPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      center,
      radius,
      borderPaint,
    );

    canvas.drawLine(
      center,
      endPoint,
      animatedPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CanvasPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}