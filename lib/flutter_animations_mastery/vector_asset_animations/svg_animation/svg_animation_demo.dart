import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAnimationDemoApp extends StatelessWidget {
  const SvgAnimationDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SVG Animation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const SvgAnimationDemoScreen(),
    );
  }
}

class SvgAnimationDemoScreen extends StatefulWidget {
  const SvgAnimationDemoScreen({super.key});

  @override
  State<SvgAnimationDemoScreen> createState() => _SvgAnimationDemoScreenState();
}

class _SvgAnimationDemoScreenState extends State<SvgAnimationDemoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _rotationAnimation = Tween<double>(
      begin: -0.15,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _play() {
    setState(() {
      _isPlaying = true;
    });

    _controller.forward(from: 0);
  }

  void _reverse() {
    setState(() {
      _isPlaying = true;
    });

    _controller.reverse(from: 1);
  }

  void _reset() {
    _controller.reset();

    setState(() {
      _isPlaying = false;
    });
  }

  void _toggleRepeat() {
    if (_controller.isAnimating) {
      _controller.stop();

      setState(() {
        _isPlaying = false;
      });
    } else {
      setState(() {
        _isPlaying = true;
      });

      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SVG Animation'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'SVG Animation Demo',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Animating an SVG using Flutter animation APIs',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Main SVG animation.
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: Transform.rotate(
                        angle: _rotationAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 280,
                  height: 280,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/loading.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Progress.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Animation Progress',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _controller.value,
                        minHeight: 8,
                      );
                    },
                  ),

                  const SizedBox(height: 5),

                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Text(
                        '${(_controller.value * 100).toStringAsFixed(1)}%',
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Controls.
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: _play,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play'),
                  ),

                  OutlinedButton.icon(
                    onPressed: _reverse,
                    icon: const Icon(Icons.flip),
                    label: const Text('Reverse'),
                  ),

                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset'),
                  ),

                  OutlinedButton.icon(
                    onPressed: _toggleRepeat,
                    icon: Icon(
                      _controller.isAnimating ? Icons.stop : Icons.repeat,
                    ),
                    label: Text(_controller.isAnimating ? 'Stop' : 'Repeat'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Direct SVG.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'SVG Asset',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: 120,
                        height: 120,
                        child: SvgPicture.asset('assets/svg/loading.svg'),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'The SVG itself is static. '
                        'Flutter is animating the widget that '
                        'displays the SVG.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Animated icon.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Animated SVG Icon',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _controller.value * 2 * 3.1415926535,
                            child: child,
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/svg/loading.svg',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Explanation.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What this demo demonstrates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      _InfoRow(
                        title: 'SvgPicture.asset',
                        description: 'Loads an SVG file as a Flutter widget.',
                      ),

                      _InfoRow(
                        title: 'AnimationController',
                        description: 'Controls the animation timeline.',
                      ),

                      _InfoRow(
                        title: 'Transform.scale',
                        description: 'Animates the SVG scale.',
                      ),

                      _InfoRow(
                        title: 'Transform.rotate',
                        description: 'Animates the SVG rotation.',
                      ),

                      _InfoRow(
                        title: 'FadeTransition',
                        description: 'Animates the SVG opacity.',
                      ),

                      _InfoRow(
                        title: 'SlideTransition',
                        description: 'Animates the SVG position.',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Senior-Level Note',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        'An SVG file is not automatically an animated '
                        'asset. In Flutter, one common approach is to '
                        'render the SVG with flutter_svg and animate '
                        'the resulting widget using Flutter animation '
                        'APIs such as AnimationController, Tween, '
                        'Transform, FadeTransition, and '
                        'SlideTransition.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String description;

  const _InfoRow({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 20),

          const SizedBox(width: 10),

          Expanded(
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
