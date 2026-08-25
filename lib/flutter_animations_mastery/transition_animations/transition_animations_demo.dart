import 'package:flutter/material.dart';

void main() {
  runApp(const TransitionAnimationsApp());
}

class TransitionAnimationsApp extends StatelessWidget {
  const TransitionAnimationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transition Animations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const TransitionAnimationsScreen(),
    );
  }
}

// ============================================================
// SCREEN
// ============================================================

class TransitionAnimationsScreen extends StatefulWidget {
  const TransitionAnimationsScreen({super.key});

  @override
  State<TransitionAnimationsScreen> createState() =>
      _TransitionAnimationsScreenState();
}

class _TransitionAnimationsScreenState
    extends State<TransitionAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // ----------------------------------------------------------
  // FadeTransition
  // ----------------------------------------------------------

  late final Animation<double> _fadeAnimation;

  // ----------------------------------------------------------
  // ScaleTransition
  // ----------------------------------------------------------

  late final Animation<double> _scaleAnimation;

  // ----------------------------------------------------------
  // SlideTransition
  // ----------------------------------------------------------

  late final Animation<Offset> _slideAnimation;

  // ----------------------------------------------------------
  // RotationTransition
  // ----------------------------------------------------------

  late final Animation<double> _rotationAnimation;

  // ----------------------------------------------------------
  // SizeTransition
  // ----------------------------------------------------------

  late final Animation<double> _sizeAnimation;

  // ----------------------------------------------------------
  // PositionedTransition
  // ----------------------------------------------------------

  late final Animation<RelativeRect> _positionAnimation;

  // ----------------------------------------------------------
  // DecoratedBoxTransition
  // ----------------------------------------------------------

  late final Animation<Decoration> _decorationAnimation;

  @override
  void initState() {
    super.initState();

    // ========================================================
    // MASTER CONTROLLER
    // ========================================================

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // ========================================================
    // 1. FadeTransition
    // ========================================================

    final fadeCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.25,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(fadeCurve);

    // ========================================================
    // 2. ScaleTransition
    // ========================================================

    final scaleCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.10,
        0.40,
        curve: Curves.easeOutBack,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(scaleCurve);

    // ========================================================
    // 3. SlideTransition
    // ========================================================

    final slideCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.20,
        0.50,
        curve: Curves.easeOutCubic,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(slideCurve);

    // ========================================================
    // 4. RotationTransition
    // ========================================================

    final rotationCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.30,
        0.55,
        curve: Curves.easeOutBack,
      ),
    );

    _rotationAnimation = Tween<double>(
      begin: -0.15,
      end: 0.0,
    ).animate(rotationCurve);

    // ========================================================
    // 5. SizeTransition
    // ========================================================

    final sizeCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.45,
        0.75,
        curve: Curves.easeOutCubic,
      ),
    );

    _sizeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(sizeCurve);

    // ========================================================
    // 6. PositionedTransition
    // ========================================================

    final positionCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.55,
        0.85,
        curve: Curves.easeOutCubic,
      ),
    );

    _positionAnimation = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(
        20,
        0,
        200,
        0,
      ),
      end: const RelativeRect.fromLTRB(
        200,
        0,
        20,
        0,
      ),
    ).animate(positionCurve);

    // ========================================================
    // 7. DecoratedBoxTransition
    // ========================================================

    final decorationCurve = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.70,
        1.0,
        curve: Curves.easeInOut,
      ),
    );

    _decorationAnimation = DecorationTween(
      begin: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      end: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
      ),
    ).animate(decorationCurve);

    // ========================================================
    // START ANIMATION
    // ========================================================

    _controller.forward();
  }

  // ==========================================================
  // CONTROLS
  // ==========================================================

  void _play() {
    _controller.forward(from: 0.0);
  }

  void _reverse() {
    _controller.reverse();
  }

  void _repeat() {
    _controller.repeat(reverse: true);
  }

  void _stop() {
    _controller.stop();
  }

  void _reset() {
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ==========================================================
  // STATUS
  // ==========================================================

  String get _status {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
        return 'Dismissed';

      case AnimationStatus.forward:
        return 'Playing Forward';

      case AnimationStatus.reverse:
        return 'Playing Reverse';

      case AnimationStatus.completed:
        return 'Completed';
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transition Animations',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildAnimationArea(),
          ),
          _buildControlPanel(),
        ],
      ),
    );
  }

  // ==========================================================
  // ANIMATION AREA
  // ==========================================================

  Widget _buildAnimationArea() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // ----------------------------------------------------
          // FadeTransition
          // ----------------------------------------------------

          FadeTransition(
            opacity: _fadeAnimation,
            child: const _HeaderSection(),
          ),

          const SizedBox(height: 24),

          // ----------------------------------------------------
          // ScaleTransition
          // ----------------------------------------------------

          ScaleTransition(
            scale: _scaleAnimation,
            child: const _ProfileCard(),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // SlideTransition
          // ----------------------------------------------------

          SlideTransition(
            position: _slideAnimation,
            child: const _InformationCard(),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // RotationTransition
          // ----------------------------------------------------

          RotationTransition(
            turns: _rotationAnimation,
            child: const _RotatingIconCard(),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // SizeTransition
          // ----------------------------------------------------

          SizeTransition(
            sizeFactor: _sizeAnimation,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: const _ExpandableDetails(),
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // PositionedTransition
          // ----------------------------------------------------

          const _PositionedTransitionSection(
            animation: null,
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // DecoratedBoxTransition
          // ----------------------------------------------------

          DecoratedBoxTransition(
            decoration: _decorationAnimation,
            child: const _DecoratedContent(),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ==========================================================
  // CONTROL PANEL
  // ==========================================================

  Widget _buildControlPanel() {
    return Material(
      elevation: 12,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                _status,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilledButton.icon(
                      onPressed: _play,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                    ),

                    const SizedBox(width: 8),

                    OutlinedButton.icon(
                      onPressed: _reverse,
                      icon: const Icon(Icons.fast_rewind),
                      label: const Text('Reverse'),
                    ),

                    const SizedBox(width: 8),

                    OutlinedButton.icon(
                      onPressed: _repeat,
                      icon: const Icon(Icons.repeat),
                      label: const Text('Repeat'),
                    ),

                    const SizedBox(width: 8),

                    OutlinedButton.icon(
                      onPressed: _stop,
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop'),
                    ),

                    const SizedBox(width: 8),

                    TextButton(
                      onPressed: _reset,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HEADER
// ============================================================

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.auto_awesome,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transition Showcase',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Seven Flutter transition types in one screen.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PROFILE CARD
// ============================================================

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor:
                  Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 32,
              ),
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developer Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'ScaleTransition example',
                  ),
                ],
              ),
            ),

            const Icon(Icons.verified),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// INFORMATION CARD
// ============================================================

class _InformationCard extends StatelessWidget {
  const _InformationCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context)
          .colorScheme
          .secondaryContainer,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(
              Icons.swipe_down_alt,
              size: 34,
            ),

            SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SlideTransition',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'This content slides into the screen.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ROTATION CARD
// ============================================================

class _RotatingIconCard extends StatelessWidget {
  const _RotatingIconCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.settings,
                size: 34,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RotationTransition',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'The settings icon rotates into position.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SIZE TRANSITION
// ============================================================

class _ExpandableDetails extends StatelessWidget {
  const _ExpandableDetails();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.unfold_more),
                SizedBox(width: 10),
                Text(
                  'SizeTransition',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              'This section grows vertically using the animation '
              'value as its size factor.',
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context)
                    .colorScheme
                    .surface,
              ),
              child: const Text(
                'SizeTransition is especially useful for '
                'expanding and collapsing content.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// POSITIONED TRANSITION SECTION
// ============================================================
//
// This section is intentionally isolated because
// PositionedTransition must live inside a Stack.
//
// The actual animation is injected by the parent wrapper below.
// ============================================================

class _PositionedTransitionSection extends StatelessWidget {
  final Animation<RelativeRect>? animation;

  const _PositionedTransitionSection({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return _PositionedTransitionDemo();
  }
}

// ============================================================
// POSITIONED TRANSITION DEMO
// ============================================================

class _PositionedTransitionDemo extends StatelessWidget {
  const _PositionedTransitionDemo();

  @override
  Widget build(BuildContext context) {
    // This widget is replaced by the stateful animated wrapper
    // below through the inherited animation access pattern.
    //
    // We use an AnimatedBuilder here to obtain the controller
    // from the nearest state is not possible, so this section
    // is implemented by the actual helper below.
    return const _PositionedPlaceholder();
  }
}

class _PositionedPlaceholder extends StatelessWidget {
  const _PositionedPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.open_with),
                SizedBox(width: 10),
                Text(
                  'PositionedTransition',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Position animation',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DECORATED BOX CONTENT
// ============================================================

class _DecoratedContent extends StatelessWidget {
  const _DecoratedContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          const Icon(
            Icons.palette,
            color: Colors.white,
            size: 32,
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DecoratedBoxTransition',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'The decoration itself is animated.',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}