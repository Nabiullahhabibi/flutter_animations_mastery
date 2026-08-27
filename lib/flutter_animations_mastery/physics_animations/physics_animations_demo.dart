import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Physics Animations Demo
///
/// Covers:
/// 1. SpringSimulation
/// 2. GravitySimulation
/// 3. FrictionSimulation
/// 4. Custom Simulation
///
/// Main idea:
///
/// AnimationController
///        ↓
/// animateWith(Simulation)
///        ↓
/// Physics calculates position over time
///        ↓
/// UI updates
class PhysicsAnimationsDemo extends StatelessWidget {
  const PhysicsAnimationsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Animations'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle(
            title: '1. SpringSimulation',
            subtitle: 'Object moves toward a target with spring physics.',
          ),
          SpringSimulationDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '2. GravitySimulation',
            subtitle: 'Object falls according to gravity.',
          ),
          GravitySimulationDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '3. FrictionSimulation',
            subtitle: 'Object moves with velocity and gradually slows down.',
          ),
          FrictionSimulationDemo(),
          SizedBox(height: 32),

          _SectionTitle(
            title: '4. Custom Simulation',
            subtitle: 'A custom Simulation controls the animation.',
          ),
          CustomSimulationDemo(),
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
          Text(subtitle),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. SPRING SIMULATION
// -----------------------------------------------------------------------------

class SpringSimulationDemo extends StatefulWidget {
  const SpringSimulationDemo({super.key});

  @override
  State<SpringSimulationDemo> createState() =>
      _SpringSimulationDemoState();
}

class _SpringSimulationDemoState extends State<SpringSimulationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double position = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController.unbounded(
      vsync: this,
    );

    controller.addListener(() {
      if (!mounted) return;

      setState(() {
        position = controller.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void runSpring() {
    controller.stop();

    final simulation = SpringSimulation(
      const SpringDescription(
        mass: 1,
        stiffness: 180,
        damping: 12,
      ),
      position,
      0,
      0,
    );

    controller.animateWith(simulation);
  }

  void reset() {
    controller.stop();

    setState(() {
      position = 0;
      controller.value = 0;
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
            alignment: Alignment.center,
            children: [
              const Text('Tap the button to trigger the spring'),

              Transform.translate(
                offset: Offset(position, 0),
                child: GestureDetector(
                  onTap: runSpring,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  position = 120;
                  controller.value = 120;
                });

                runSpring();
              },
              child: const Text('Spring'),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 2. GRAVITY SIMULATION
// -----------------------------------------------------------------------------

class GravitySimulationDemo extends StatefulWidget {
  const GravitySimulationDemo({super.key});

  @override
  State<GravitySimulationDemo> createState() =>
      _GravitySimulationDemoState();
}

class _GravitySimulationDemoState extends State<GravitySimulationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double position = 0;

  static const double groundPosition = 120;

  @override
  void initState() {
    super.initState();

    controller = AnimationController.unbounded(
      vsync: this,
    );

    controller.addListener(() {
      if (!mounted) return;

      setState(() {
        position = controller.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void drop() {
    controller.stop();

    controller.value = 0;

    final simulation = GravitySimulation(
      600,
      0,
      groundPosition,
      0,
    );

    controller.animateWith(simulation);
  }

  void reset() {
    controller.stop();

    setState(() {
      position = 0;
      controller.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Transform.translate(
                offset: Offset(0, position),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                ),
              ),

              const Positioned(
                top: 20,
                child: Text('Gravity pulls the object downward'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: drop,
              child: const Text('Drop'),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 3. FRICTION SIMULATION
// -----------------------------------------------------------------------------

class FrictionSimulationDemo extends StatefulWidget {
  const FrictionSimulationDemo({super.key});

  @override
  State<FrictionSimulationDemo> createState() =>
      _FrictionSimulationDemoState();
}

class _FrictionSimulationDemoState extends State<FrictionSimulationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double position = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController.unbounded(
      vsync: this,
    );

    controller.addListener(() {
      if (!mounted) return;

      setState(() {
        position = controller.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void fling() {
    controller.stop();

    controller.value = 0;

    final simulation = FrictionSimulation(
      0.6,
      0,
      1500,
    );

    controller.animateWith(simulation);
  }

  void reset() {
    controller.stop();

    setState(() {
      position = 0;
      controller.value = 0;
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
            alignment: Alignment.center,
            children: [
              const Text(
                'Object starts fast and slows because of friction',
              ),

              Transform.translate(
                offset: Offset(position, 0),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.speed,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fling,
              child: const Text('Fling'),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 4. CUSTOM SIMULATION
// -----------------------------------------------------------------------------

class CustomSimulationDemo extends StatefulWidget {
  const CustomSimulationDemo({super.key});

  @override
  State<CustomSimulationDemo> createState() =>
      _CustomSimulationDemoState();
}

class _CustomSimulationDemoState extends State<CustomSimulationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  double progress = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController.unbounded(
      vsync: this,
    );

    controller.addListener(() {
      if (!mounted) return;

      setState(() {
        progress = controller.value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void runCustomSimulation() {
    controller.stop();
    controller.value = 0;

    final simulation = _CustomWaveSimulation();

    controller.animateWith(simulation);
  }

  void reset() {
    controller.stop();

    setState(() {
      progress = 0;
      controller.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    final x = clampedProgress * 220;

    final scale = 1.0 + (0.25 * (1 - clampedProgress));

    return Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned(
                top: 20,
                child: Text(
                  'Custom Simulation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Transform.translate(
                offset: Offset(x, 0),
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: runCustomSimulation,
              child: const Text('Run'),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// CUSTOM SIMULATION
// -----------------------------------------------------------------------------

class _CustomWaveSimulation extends Simulation {
  final double duration;

  _CustomWaveSimulation({
    this.duration = 2.5,
  });

  @override
  double x(double time) {
    if (time >= duration) {
      return 1.0;
    }

    final progress = time / duration;

    // Ease-out movement with a small wave.
    final eased = 1 - (1 - progress) * (1 - progress);

    final wave =
        0.08 * (1 - progress) * MathHelper.sin(progress * 12);

    return eased + wave;
  }

  @override
  double dx(double time) {
    if (time >= duration) {
      return 0;
    }

    const epsilon = 0.0001;

    return (x(time + epsilon) - x(time)) / epsilon;
  }

  @override
  bool isDone(double time) {
    return time >= duration;
  }
}

// -----------------------------------------------------------------------------
// SIMPLE MATH HELPER
// -----------------------------------------------------------------------------

class MathHelper {
  static double sin(double value) {
    // Dart's dart:math is intentionally avoided here so the demo remains
    // focused on the Simulation concept.
    //
    // This approximation is enough for a visual learning example.
    final normalized = value % (2 * 3.141592653589793);

    double result = 0;
    double term = normalized;

    for (int i = 1; i <= 9; i += 2) {
      result += term;

      term *= -normalized * normalized;
      term /= (i + 1) * (i + 2);
    }

    return result;
  }
}