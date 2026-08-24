import 'package:flutter/material.dart';

/// A senior-level example showing how Flutter explicit animation pieces
/// work together:
///
/// AnimationController
/// Ticker / vsync
/// Animation<T>
/// Tween<T>
/// CurvedAnimation
/// Curves
/// AnimatedBuilder
/// AnimatedWidget (via _AnimatedPulseIcon)
///
/// The screen represents a "download/upload task" card. The user can:
/// - Start/restart the animation
/// - Pause/resume it
/// - Reverse it
/// - Reset it
///
/// The animation simultaneously drives:
/// - Card entrance scale
/// - Card entrance opacity
/// - Progress value
/// - Circular progress ring
/// - Icon rotation
/// - Icon pulse
/// - Background glow
class ExplicitAnimationApp extends StatelessWidget {
  const ExplicitAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explicit Animation Master',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AnimationDemoScreen(),
    );
  }
}

class AnimationDemoScreen extends StatefulWidget {
  const AnimationDemoScreen({super.key});

  @override
  State<AnimationDemoScreen> createState() => _AnimationDemoScreenState();
}

class _AnimationDemoScreenState extends State<AnimationDemoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Tween<double> maps the controller's normalized 0.0 -> 1.0 value
  // into 0.0 -> 1.0 progress. It looks redundant here, but it makes
  // the value transformation explicit and easy to replace later.
  late final Animation<double> _progress;

  // A different Tween drives the card's scale.
  late final Animation<double> _scale;

  // A different Tween drives opacity.
  late final Animation<double> _opacity;

  // A ColorTween drives the background/glow color.
  late final Animation<Color?> _glowColor;

  // Tween<double> drives rotation in turns.
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    // AnimationController is the time engine.
    //
    // vsync: this connects the controller to the State's Ticker.
    // duration: total time for forward() to travel from 0 -> 1.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
      reverseDuration: const Duration(milliseconds: 1400),
    );

    // CurvedAnimation changes how the controller progresses over time.
    //
    // It still produces values in the same general range, but the movement
    // follows the selected curve rather than moving linearly.
    final entranceCurve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    final progressCurve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    // Animation<T> is the read-only animated value.
    //
    // Tween evaluates a value between begin and end using the animation's
    // current value.
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(progressCurve);

    _scale = Tween<double>(begin: 0.82, end: 1.0).animate(entranceCurve);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(entranceCurve);

    _glowColor = ColorTween(
      begin: Colors.transparent,
      end: Colors.indigo.withValues(alpha: 0.18),
    ).animate(entranceCurve);

    // One complete rotation during forward().
    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeInOutCubic,
      ),
    );

    // Start the entrance animation when the screen is first created.
    _controller.forward();
  }

  @override
  void dispose() {
    // Explicit animations require manual controller disposal.
    //
    // The controller owns a Ticker. Disposing releases that ticker and
    // prevents the controller from continuing after this State is gone.
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    _controller.forward(from: 0.0);
  }

  void _pauseOrResume() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  void _reverse() {
    _controller.reverse();
  }

  void _reset() {
    _controller.reset();
  }

  String get _statusText {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
        return 'Dismissed';
      case AnimationStatus.forward:
        return 'Forward';
      case AnimationStatus.reverse:
        return 'Reverse';
      case AnimationStatus.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animation Master'),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = _progress.value;
          final percentage = (progress * 100).round();

          return Stack(
            children: [
              // AnimatedBuilder rebuilds this part whenever the controller
              // ticks. The static content is kept in `child` below.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(color: _glowColor.value),
                ),
              ),

              Center(
                child: Transform.scale(
                  scale: _scale.value,
                  child: Opacity(opacity: _opacity.value, child: child),
                ),
              ),

              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: _ControlPanel(
                  status: _statusText,
                  progress: progress,
                  percentage: percentage,
                  onStart: _start,
                  onPauseResume: _pauseOrResume,
                  onReverse: _reverse,
                  onReset: _reset,
                  isAnimating: _controller.isAnimating,
                ),
              ),
            ],
          );
        },

        // IMPORTANT:
        //
        // This child does NOT rebuild on every animation tick.
        // AnimatedBuilder reuses it while only the builder above rebuilds.
        child: _AnimatedTaskCard(progress: _progress, rotation: _rotation),
      ),
    );
  }
}

/// A reusable animated widget.
///
/// This demonstrates AnimatedWidget as an alternative to AnimatedBuilder.
///
/// AnimatedWidget listens to the supplied Animation and rebuilds itself
/// whenever that animation changes.
class _AnimatedTaskCard extends StatelessWidget {
  final Animation<double> progress;
  final Animation<double> rotation;

  const _AnimatedTaskCard({required this.progress, required this.rotation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 15),
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AnimatedProgressRing(progress: progress),
          const SizedBox(height: 22),

          _AnimatedPulseIcon(animation: rotation),

          const SizedBox(height: 16),

          const Text(
            'Uploading project...',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          AnimatedBuilder(
            animation: progress,
            builder: (context, _) {
              final percentage = (progress.value * 100).round();

              return Text(
                '$percentage% complete',
                style: Theme.of(context).textTheme.bodyLarge,
              );
            },
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(minHeight: 8, value: progress.value),
          ),
        ],
      ),
    );
  }
}

/// Another AnimatedWidget example.
///
/// It receives an Animation<double> and automatically rebuilds when the
/// animation value changes.
class _AnimatedPulseIcon extends AnimatedWidget {
  const _AnimatedPulseIcon({required Animation<double> animation})
    : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    // Convert 0 -> 1 rotation into radians.
    final angle = animation.value * 2 * 3.141592653589793;

    // Create a subtle pulse based on a sine-like range.
    final pulse = 1.0 + (0.08 * animation.value);

    return Transform.rotate(
      angle: angle,
      child: Transform.scale(
        scale: pulse,
        child: CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.cloud_upload_rounded,
            size: 34,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

/// A custom progress ring driven by the same Animation<double>.
class _AnimatedProgressRing extends StatelessWidget {
  final Animation<double> progress;

  const _AnimatedProgressRing({required this.progress});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        return SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: progress.value,
                  strokeWidth: 12,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                ),
              ),
              Text(
                '${(progress.value * 100).round()}%',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ControlPanel extends StatelessWidget {
  final String status;
  final double progress;
  final int percentage;
  final VoidCallback onStart;
  final VoidCallback onPauseResume;
  final VoidCallback onReverse;
  final VoidCallback onReset;
  final bool isAnimating;

  const _ControlPanel({
    required this.status,
    required this.progress,
    required this.percentage,
    required this.onStart,
    required this.onPauseResume,
    required this.onReverse,
    required this.onReset,
    required this.isAnimating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(status),
                const Spacer(),
                Text('$percentage%'),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                FilledButton(onPressed: onStart, child: const Text('Start')),
                OutlinedButton(
                  onPressed: onPauseResume,
                  child: Text(isAnimating ? 'Pause' : 'Resume'),
                ),
                OutlinedButton(
                  onPressed: onReverse,
                  child: const Text('Reverse'),
                ),
                TextButton(onPressed: onReset, child: const Text('Reset')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
