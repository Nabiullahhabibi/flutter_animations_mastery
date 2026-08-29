import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const LottieDemoApp());
}

class LottieDemoApp extends StatelessWidget {
  const LottieDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lottie Animation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LottieDemoScreen(),
    );
  }
}

class LottieDemoScreen extends StatefulWidget {
  const LottieDemoScreen({super.key});

  @override
  State<LottieDemoScreen> createState() => _LottieDemoScreenState();
}

class _LottieDemoScreenState extends State<LottieDemoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool _isPlaying = false;
  bool _isLooping = true;
  double _speed = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

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

    if (_isLooping) {
      _controller.repeat();
    } else {
      _controller.forward(from: 0);
    }
  }

  void _pause() {
    _controller.stop();

    setState(() {
      _isPlaying = false;
    });
  }

  void _resume() {
    setState(() {
      _isPlaying = true;
    });

    if (_isLooping) {
      _controller.repeat(
        min: _controller.value,
        max: 1.0,
        period: _controller.duration,
      );
    } else {
      _controller.forward();
    }
  }

  void _reverse() {
    setState(() {
      _isPlaying = true;
    });

    _controller.reverse(from: _controller.value);
  }

  void _reset() {
    _controller.stop();

    setState(() {
      _isPlaying = false;
    });

    _controller.value = 0;
  }

  void _setLooping(bool value) {
    setState(() {
      _isLooping = value;
    });

    if (_isPlaying) {
      if (value) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.forward(from: _controller.value);
      }
    }
  }

  void _setSpeed(double value) {
    setState(() {
      _speed = value;
    });

    _controller.duration = Duration(
      milliseconds: (3000 / value).round(),
    );

    if (_isPlaying && _isLooping) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Animation'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Lottie Animation Demo',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Vector-based animation with playback controls',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Lottie.asset(
                  'assets/animations/loading.json',
                  controller: _controller,
                  fit: BoxFit.contain,

                  // This callback is called when Lottie
                  // knows the animation duration.
                  onLoaded: (composition) {
                    _controller.duration = composition.duration;
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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

              // Playback controls
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
                    onPressed: _pause,
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _resume,
                    icon: const Icon(Icons.play_circle),
                    label: const Text('Resume'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _reverse,
                    icon: const Icon(Icons.replay),
                    label: const Text('Reverse'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Loop
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Loop Animation'),
                subtitle: const Text(
                  'Repeat the animation continuously',
                ),
                value: _isLooping,
                onChanged: _setLooping,
              ),

              const SizedBox(height: 15),

              // Speed
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Speed: ${_speed.toStringAsFixed(1)}x',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: _speed,
                    min: 0.5,
                    max: 3.0,
                    divisions: 5,
                    label: '${_speed.toStringAsFixed(1)}x',
                    onChanged: _setSpeed,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Manual progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manual Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Drag the slider to control the animation position.',
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Slider(
                        value: _controller.value.clamp(0.0, 1.0),
                        min: 0,
                        max: 1,
                        onChanged: (value) {
                          _controller.value = value;
                        },
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Explanation card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                      const SizedBox(height: 12),
                      _InfoRow(
                        title: 'Lottie.asset',
                        description:
                            'Loads a Lottie JSON animation from assets.',
                      ),
                      _InfoRow(
                        title: 'AnimationController',
                        description:
                            'Controls playback, progress and direction.',
                      ),
                      _InfoRow(
                        title: 'onLoaded',
                        description:
                            'Provides the animation composition and duration.',
                      ),
                      _InfoRow(
                        title: 'repeat()',
                        description:
                            'Continuously repeats the animation.',
                      ),
                      _InfoRow(
                        title: 'reverse()',
                        description:
                            'Plays the animation backwards.',
                      ),
                      _InfoRow(
                        title: 'controller.value',
                        description:
                            'Allows direct control over animation progress.',
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

  const _InfoRow({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: description,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}