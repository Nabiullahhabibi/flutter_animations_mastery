import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Gesture-driven Animations Demo
///
/// Covers:
/// 1. Drag
/// 2. Swipe
/// 3. Fling
/// 4. Interactive transitions
/// 5. Gesture + AnimationController
///
/// This file is designed as a learning/demo file.
/// Each section demonstrates a different technique.

class GestureAnimationsDemo extends StatelessWidget {
  const GestureAnimationsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture-driven Animations'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle(
            title: '1. Drag',
            subtitle: 'Directly move an object with your finger.',
          ),
          DragDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '2. Swipe',
            subtitle: 'Swipe a card left or right to dismiss it.',
          ),
          SwipeDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '3. Fling',
            subtitle: 'Release an object with velocity and let physics continue.',
          ),
          FlingDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '4. Interactive Transition',
            subtitle: 'Gesture directly controls animation progress.',
          ),
          InteractiveTransitionDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '5. Gesture + AnimationController',
            subtitle: 'Gesture controls the animation and the controller takes over.',
          ),
          GestureAnimationControllerDemo(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECTION TITLE
// -----------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. DRAG
// -----------------------------------------------------------------------------

class DragDemo extends StatefulWidget {
  const DragDemo({super.key});

  @override
  State<DragDemo> createState() => _DragDemoState();
}

class _DragDemoState extends State<DragDemo> {
  Offset position = Offset.zero;

  void reset() {
    setState(() {
      position = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Stack(
        children: [
          const Center(
            child: Text(
              'Drag the box',
              style: TextStyle(fontSize: 16),
            ),
          ),

          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    position += details.delta;
                  });
                },
                onDoubleTap: reset,
                child: Transform.translate(
                  offset: position,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.open_with,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. SWIPE
// -----------------------------------------------------------------------------

class SwipeDemo extends StatefulWidget {
  const SwipeDemo({super.key});

  @override
  State<SwipeDemo> createState() => _SwipeDemoState();
}

class _SwipeDemoState extends State<SwipeDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double dragX = 0;
  bool removed = false;

  static const double swipeThreshold = 120;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> handleSwipeEnd(double velocity) async {
    if (dragX.abs() > swipeThreshold || velocity.abs() > 1000) {
      final direction = dragX >= 0 ? 1.0 : -1.0;

      await controller.animateTo(
        1,
        curve: Curves.easeOut,
      );

      if (!mounted) return;

      setState(() {
        removed = true;
        dragX = direction * 350;
      });
    } else {
      await controller.reverse();

      if (!mounted) return;

      setState(() {
        dragX = 0;
      });
    }
  }

  void reset() {
    controller.reset();

    setState(() {
      dragX = 0;
      removed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Center(
            child: removed
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 50,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 12),
                      const Text('Card dismissed'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: reset,
                        child: const Text('Reset'),
                      ),
                    ],
                  )
                : GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        dragX += details.delta.dx;
                      });
                    },
                    onPanEnd: (details) {
                      handleSwipeEnd(
                        details.velocity.pixelsPerSecond.dx,
                      );
                    },
                    child: Transform.translate(
                      offset: Offset(dragX, 0),
                      child: Transform.rotate(
                        angle: dragX / 1000,
                        child: Container(
                          width: 180,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepPurple,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'SWIPE ME',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Swipe left or right'),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 3. FLING
// -----------------------------------------------------------------------------

class FlingDemo extends StatefulWidget {
  const FlingDemo({super.key});

  @override
  State<FlingDemo> createState() => _FlingDemoState();
}

class _FlingDemoState extends State<FlingDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double positionX = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController.unbounded(
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      positionX += details.delta.dx;
    });
  }

  void onDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;

    controller.value = positionX;

    final simulation = FrictionSimulation(
      0.5,
      positionX,
      velocity,
    );

    controller.animateWith(simulation).then((_) {
      if (!mounted) return;

      setState(() {
        positionX = controller.value;
      });
    });

    controller.addListener(updatePosition);
  }

  void updatePosition() {
    if (!mounted) return;

    setState(() {
      positionX = controller.value;
    });
  }

  void reset() {
    controller.stop();
    controller.removeListener(updatePosition);

    setState(() {
      positionX = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Stack(
            children: [
              const Center(
                child: Text(
                  'Drag quickly and release',
                ),
              ),
              Center(
                child: GestureDetector(
                  onPanUpdate: onDragUpdate,
                  onPanEnd: onDragEnd,
                  child: Transform.translate(
                    offset: Offset(positionX, 0),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: reset,
          child: const Text('Reset'),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 4. INTERACTIVE TRANSITION
// -----------------------------------------------------------------------------

class InteractiveTransitionDemo extends StatefulWidget {
  const InteractiveTransitionDemo({super.key});

  @override
  State<InteractiveTransitionDemo> createState() =>
      _InteractiveTransitionDemoState();
}

class _InteractiveTransitionDemoState
    extends State<InteractiveTransitionDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double startX = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onDragStart(DragStartDetails details) {
    startX = details.localPosition.dx;
  }

  void onDragUpdate(DragUpdateDetails details) {
    final width = context.size?.width ?? 1;

    final progress = controller.value + details.delta.dx / width;

    controller.value = progress.clamp(0.0, 1.0);
  }

  void onDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;

    if (velocity > 500 || controller.value > 0.5) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final progress = controller.value;

            final scale = 1.0 - progress * 0.2;
            final radius = progress * 100;

            return Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: progress,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                Transform.scale(
                  scale: scale,
                  child: Transform.translate(
                    offset: Offset(
                      progress * 130,
                      0,
                    ),
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          20 + progress * 80,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'DRAG →',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5. GESTURE + ANIMATIONCONTROLLER
// -----------------------------------------------------------------------------

class GestureAnimationControllerDemo extends StatefulWidget {
  const GestureAnimationControllerDemo({super.key});

  @override
  State<GestureAnimationControllerDemo> createState() =>
      _GestureAnimationControllerDemoState();
}

class _GestureAnimationControllerDemoState
    extends State<GestureAnimationControllerDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    controller.value += details.delta.dx / 200;

    controller.value = controller.value.clamp(0.0, 1.0);
  }

  void handleDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;

    if (velocity > 800) {
      controller.fling(
        velocity: 1,
      );
    } else if (velocity < -800) {
      controller.fling(
        velocity: -1,
      );
    } else if (controller.value > 0.5) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: handleDragUpdate,
        onHorizontalDragEnd: handleDragEnd,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final value = controller.value;

            final offsetX = value * 140;
            final rotation = value * 0.25;
            final scale = 1.0 + value * 0.15;

            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 180,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Drag and release',
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(offsetX, 0),
                  child: Transform.rotate(
                    angle: rotation,
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.pink,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.animation,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}