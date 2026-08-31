import 'dart:math' as math;

import 'package:flutter/material.dart';

class PathAnimationDemo extends StatefulWidget {
  const PathAnimationDemo({super.key});

  @override
  State<PathAnimationDemo> createState() => _PathAnimationDemoState();
}

class _PathAnimationDemoState extends State<PathAnimationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
        title: const Text('Path Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(340, 500),
              painter: PathAnimationPainter(
                progress: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

class PathAnimationPainter extends CustomPainter {
  final double progress;

  PathAnimationPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // Create a curved path.
    path.moveTo(40, size.height / 2);

    path.cubicTo(
      size.width * 0.25,
      50,
      size.width * 0.75,
      size.height - 50,
      size.width - 40,
      size.height / 2,
    );

    // ----------------------------------------------------------
    // Draw the path
    // ----------------------------------------------------------

    final pathPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawPath(
      path,
      pathPaint,
    );

    // ----------------------------------------------------------
    // Calculate position along the path
    // ----------------------------------------------------------

    final pathMetrics = path.computeMetrics().toList();

    if (pathMetrics.isEmpty) {
      return;
    }

    final metric = pathMetrics.first;

    final distance = metric.length * progress;

    final tangent = metric.getTangentForOffset(distance);

    if (tangent == null) {
      return;
    }

    final position = tangent.position;

    // ----------------------------------------------------------
    // Draw animated object
    // ----------------------------------------------------------

    final objectPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      position,
      15,
      objectPaint,
    );

    // ----------------------------------------------------------
    // Draw direction indicator
    // ----------------------------------------------------------

    final directionPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const directionLength = 25.0;

    final angle = tangent.angle;

    final endPoint = Offset(
      position.dx + math.cos(angle) * directionLength,
      position.dy + math.sin(angle) * directionLength,
    );

    canvas.drawLine(
      position,
      endPoint,
      directionPaint,
    );
  }

  @override
  bool shouldRepaint(covariant PathAnimationPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}