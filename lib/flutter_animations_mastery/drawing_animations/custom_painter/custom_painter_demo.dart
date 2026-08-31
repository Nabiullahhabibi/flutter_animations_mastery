import 'package:flutter/material.dart';

/// CustomPainter Demo
///
/// Demonstrates:
/// - Creating a custom painter
/// - Drawing with Canvas
/// - Using Paint
/// - Repainting when animation changes
/// - Separating painting logic from UI
class CustomPainterDemo extends StatefulWidget {
  const CustomPainterDemo({super.key});

  @override
  State<CustomPainterDemo> createState() => _CustomPainterDemoState();
}

class _CustomPainterDemoState extends State<CustomPainterDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
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
        title: const Text('CustomPainter'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(300, 300),
              painter: CirclePainter(
                progress: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// CustomPainter is responsible for drawing directly onto a Canvas.
class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    // ----------------------------------------------------------
    // 1. Background circle
    // ----------------------------------------------------------

    final backgroundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey.shade200;

    canvas.drawCircle(
      center,
      100,
      backgroundPaint,
    );

    // ----------------------------------------------------------
    // 2. Animated circle
    // ----------------------------------------------------------

    final animatedRadius = 40 + (progress * 50);

    final circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    canvas.drawCircle(
      center,
      animatedRadius,
      circlePaint,
    );

    // ----------------------------------------------------------
    // 3. Circle border
    // ----------------------------------------------------------

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.black;

    canvas.drawCircle(
      center,
      100,
      borderPaint,
    );

    // ----------------------------------------------------------
    // 4. Draw a line
    // ----------------------------------------------------------

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..color = Colors.red;

    canvas.drawLine(
      Offset(30, 30),
      Offset(
        size.width - 30,
        30,
      ),
      linePaint,
    );

    // ----------------------------------------------------------
    // 5. Draw a rectangle
    // ----------------------------------------------------------

    final rectanglePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;

    canvas.drawRect(
      Rect.fromLTWH(
        30,
        size.height - 60,
        80,
        30,
      ),
      rectanglePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}