import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedOpacityDemoApp());
}

class AnimatedOpacityDemoApp extends StatelessWidget {
  const AnimatedOpacityDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedOpacity Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimatedOpacityDemoPage(),
    );
  }
}

class AnimatedOpacityDemoPage extends StatefulWidget {
  const AnimatedOpacityDemoPage({super.key});

  @override
  State<AnimatedOpacityDemoPage> createState() =>
      _AnimatedOpacityDemoPageState();
}

class _AnimatedOpacityDemoPageState extends State<AnimatedOpacityDemoPage> {
  double _opacity = 1.0;

  Duration _duration = const Duration(milliseconds: 500);

  Curve _curve = Curves.easeInOut;

  bool _ignorePointer = false;

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
    });
  }

  void _fadeIn() {
    setState(() {
      _opacity = 1.0;
    });
  }

  void _fadeOut() {
    setState(() {
      _opacity = 0.0;
    });
  }

  void _setOpacity(double value) {
    setState(() {
      _opacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedOpacity Demo')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'AnimatedOpacity',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                'Experiment with opacity, duration, curves, and '
                'hit testing.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------------------
              // Animated Content
              // ------------------------------------------------------------
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Center(
                  child: IgnorePointer(
                    ignoring: _ignorePointer,
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: _duration,
                      curve: _curve,
                      onEnd: () {
                        debugPrint('AnimatedOpacity animation completed.');
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('The animated widget was tapped.'),
                            ),
                          );
                        },
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: Offset(0, 8),
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Animated',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------------------
              // Current Opacity
              // ------------------------------------------------------------
              Center(
                child: Text(
                  'Opacity: ${_opacity.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Slider(
                min: 0.0,
                max: 1.0,
                divisions: 20,
                value: _opacity,
                label: _opacity.toStringAsFixed(2),
                onChanged: _setOpacity,
              ),

              const SizedBox(height: 10),

              // ------------------------------------------------------------
              // Main Controls
              // ------------------------------------------------------------
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _fadeIn,
                      child: const Text('Fade In'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: _fadeOut,
                      child: const Text('Fade Out'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              OutlinedButton(
                onPressed: _toggleOpacity,
                child: const Text('Toggle Opacity'),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------------------
              // Duration
              // ------------------------------------------------------------
              const Text(
                'Animation Duration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _DurationButton(
                    label: '100 ms',
                    duration: const Duration(milliseconds: 100),
                    selected: _duration == const Duration(milliseconds: 100),
                    onPressed: () {
                      setState(() {
                        _duration = const Duration(milliseconds: 100);
                      });
                    },
                  ),
                  _DurationButton(
                    label: '300 ms',
                    duration: const Duration(milliseconds: 300),
                    selected: _duration == const Duration(milliseconds: 300),
                    onPressed: () {
                      setState(() {
                        _duration = const Duration(milliseconds: 300);
                      });
                    },
                  ),
                  _DurationButton(
                    label: '500 ms',
                    duration: const Duration(milliseconds: 500),
                    selected: _duration == const Duration(milliseconds: 500),
                    onPressed: () {
                      setState(() {
                        _duration = const Duration(milliseconds: 500);
                      });
                    },
                  ),
                  _DurationButton(
                    label: '1 second',
                    duration: const Duration(seconds: 1),
                    selected: _duration == const Duration(seconds: 1),
                    onPressed: () {
                      setState(() {
                        _duration = const Duration(seconds: 1);
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------------------
              // Curves
              // ------------------------------------------------------------
              const Text(
                'Animation Curve',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<Curve>(
                value: _curve,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Curve',
                ),
                items: const [
                  DropdownMenuItem(value: Curves.linear, child: Text('Linear')),
                  DropdownMenuItem(
                    value: Curves.easeIn,
                    child: Text('Ease In'),
                  ),
                  DropdownMenuItem(
                    value: Curves.easeOut,
                    child: Text('Ease Out'),
                  ),
                  DropdownMenuItem(
                    value: Curves.easeInOut,
                    child: Text('Ease In Out'),
                  ),
                  DropdownMenuItem(
                    value: Curves.bounceOut,
                    child: Text('Bounce Out'),
                  ),
                  DropdownMenuItem(
                    value: Curves.elasticOut,
                    child: Text('Elastic Out'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _curve = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------------------
              // Hit Testing
              // ------------------------------------------------------------
              const Text(
                'Interaction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Ignore Pointer'),
                subtitle: const Text(
                  'Disable interaction with the animated widget.',
                ),
                value: _ignorePointer,
                onChanged: (value) {
                  setState(() {
                    _ignorePointer = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------------------
              // Information Card
              // ------------------------------------------------------------
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Important',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Setting opacity to 0.0 makes the widget '
                        'transparent. It does not remove the widget '
                        'from the widget tree or layout.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------------------
              // Current Configuration
              // ------------------------------------------------------------
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Configuration',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _InfoRow(
                        label: 'Opacity',
                        value: _opacity.toStringAsFixed(2),
                      ),
                      _InfoRow(
                        label: 'Duration',
                        value: '${_duration.inMilliseconds} ms',
                      ),
                      _InfoRow(
                        label: 'Ignore Pointer',
                        value: _ignorePointer.toString(),
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

// ============================================================================
// Duration Button
// ============================================================================

class _DurationButton extends StatelessWidget {
  final String label;
  final Duration duration;
  final bool selected;
  final VoidCallback onPressed;

  const _DurationButton({
    required this.label,
    required this.duration,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return selected
        ? FilledButton(onPressed: onPressed, child: Text(label))
        : OutlinedButton(onPressed: onPressed, child: Text(label));
  }
}

// ============================================================================
// Information Row
// ============================================================================

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
