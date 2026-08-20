import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedOpacityMasteryApp());
}

class AnimatedOpacityMasteryApp extends StatelessWidget {
  const AnimatedOpacityMasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedOpacity Mastery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimatedOpacityMasteryPage(),
    );
  }
}

class AnimatedOpacityMasteryPage extends StatefulWidget {
  const AnimatedOpacityMasteryPage({super.key});

  @override
  State<AnimatedOpacityMasteryPage> createState() =>
      _AnimatedOpacityMasteryPageState();
}

class _AnimatedOpacityMasteryPageState
    extends State<AnimatedOpacityMasteryPage> {
  double _opacity = 1.0;

  Duration _duration = const Duration(milliseconds: 400);

  Curve _curve = Curves.easeInOut;

  bool _ignorePointer = false;
  bool _absorbPointer = false;

  bool _loading = false;
  bool _hasError = false;
  bool _success = false;

  bool _showOverlay = false;
  bool _showNotification = false;

  bool _showMultipleItems = true;

  bool _showConditionalWidget = true;
  bool _removeAfterFade = false;

  int _staggerKey = 0;

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

  void _showLoading() {
    setState(() {
      _loading = true;
      _hasError = false;
      _success = false;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _success = true;
      });
    });
  }

  void _showError() {
    setState(() {
      _loading = false;
      _success = false;
      _hasError = true;
    });
  }

  void _showSuccess() {
    setState(() {
      _loading = false;
      _hasError = false;
      _success = true;
    });
  }

  void _resetStates() {
    setState(() {
      _loading = false;
      _hasError = false;
      _success = false;
    });
  }

  void _showNotificationTemporarily() {
    setState(() {
      _showNotification = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _showNotification = false;
      });
    });
  }

  void _startStaggeredAnimation() {
    setState(() {
      _staggerKey++;
    });
  }

  void _startFadeOutAndRemove() {
    setState(() {
      _removeAfterFade = true;
    });
  }

  void _restoreConditionalWidget() {
    setState(() {
      _showConditionalWidget = true;
      _removeAfterFade = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedOpacity Mastery')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildIntroduction(context),
              const SizedBox(height: 24),

              _buildBasicFadeSection(context),
              const SizedBox(height: 24),

              _buildPartialOpacitySection(context),
              const SizedBox(height: 24),

              _buildDurationSection(context),
              const SizedBox(height: 24),

              _buildCurveSection(context),
              const SizedBox(height: 24),

              _buildInteractionSection(context),
              const SizedBox(height: 24),

              _buildLoadingSection(context),
              const SizedBox(height: 24),

              _buildStateFeedbackSection(context),
              const SizedBox(height: 24),

              _buildOverlaySection(context),
              const SizedBox(height: 24),

              _buildNotificationSection(context),
              const SizedBox(height: 24),

              _buildMultipleOpacitySection(context),
              const SizedBox(height: 24),

              _buildStaggeredSection(context),
              const SizedBox(height: 24),

              _buildFadeAndRemoveSection(context),
              const SizedBox(height: 24),

              _buildAnimatedContainerCombination(context),
              const SizedBox(height: 24),

              _buildAnimatedSwitcherComparison(context),
              const SizedBox(height: 24),

              _buildPerformanceNotes(context),
              const SizedBox(height: 24),

              _buildCurrentConfiguration(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnimatedOpacity',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'A complete playground for learning implicit opacity '
          'animations and their real-world patterns.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildBasicFadeSection(BuildContext context) {
    return _DemoCard(
      title: '1. Basic Fade In / Fade Out',
      description:
          'The fundamental AnimatedOpacity pattern: animate '
          'between 0.0 and 1.0.',
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: _duration,
                curve: _curve,
                onEnd: () {
                  debugPrint('Basic opacity animation completed.');
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.visibility,
                      color: Colors.white,
                      size: 56,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _fadeIn,
                  child: const Text('Fade In'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: _fadeOut,
                  child: const Text('Fade Out'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _toggleOpacity,
            child: const Text('Toggle'),
          ),
        ],
      ),
    );
  }

  Widget _buildPartialOpacitySection(BuildContext context) {
    return _DemoCard(
      title: '2. Partial Opacity',
      description:
          'Opacity is not limited to 0.0 and 1.0. Experiment '
          'with every value between them.',
      child: Column(
        children: [
          Text(
            'Current opacity: ${_opacity.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Slider(
            min: 0,
            max: 1,
            divisions: 20,
            value: _opacity,
            label: _opacity.toStringAsFixed(2),
            onChanged: _setOpacity,
          ),
          const SizedBox(height: 12),
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.star, size: 50, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSection(BuildContext context) {
    final durations = <Duration>[
      const Duration(milliseconds: 100),
      const Duration(milliseconds: 200),
      const Duration(milliseconds: 400),
      const Duration(milliseconds: 700),
      const Duration(seconds: 1),
    ];

    return _DemoCard(
      title: '3. Animation Duration',
      description:
          'Compare different durations and observe how they '
          'change the perceived speed of the transition.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: durations.map((duration) {
              final selected = duration == _duration;

              return selected
                  ? FilledButton(
                      onPressed: () {
                        setState(() {
                          _duration = duration;
                        });
                      },
                      child: Text('${duration.inMilliseconds} ms'),
                    )
                  : OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _duration = duration;
                        });
                      },
                      child: Text('${duration.inMilliseconds} ms'),
                    );
            }).toList(),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: _opacity,
            duration: _duration,
            curve: _curve,
            child: const Icon(Icons.favorite, size: 80, color: Colors.red),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _toggleOpacity,
            child: const Text('Run Duration Test'),
          ),
        ],
      ),
    );
  }

  Widget _buildCurveSection(BuildContext context) {
    final curves = <String, Curve>{
      'Linear': Curves.linear,
      'Ease In': Curves.easeIn,
      'Ease Out': Curves.easeOut,
      'Ease In Out': Curves.easeInOut,
      'Fast Out Slow In': Curves.fastOutSlowIn,
      'Decelerate': Curves.decelerate,
      'Bounce Out': Curves.bounceOut,
      'Elastic Out': Curves.elasticOut,
    };

    return _DemoCard(
      title: '4. Curves',
      description:
          'Curves control the timing behavior of the opacity '
          'transition.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<Curve>(
            initialValue: _curve,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select curve',
            ),
            items: curves.entries.map((entry) {
              return DropdownMenuItem<Curve>(
                value: entry.value,
                child: Text(entry.key),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                _curve = value;
              });
            },
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: _opacity,
            duration: _duration,
            curve: _curve,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  'Curve Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _toggleOpacity,
            child: const Text('Run Curve Test'),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionSection(BuildContext context) {
    return _DemoCard(
      title: '5. Interaction: IgnorePointer + AbsorbPointer',
      description:
          'Opacity controls appearance, not interaction. '
          'Use interaction widgets when necessary.',
      child: Column(
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Ignore Pointer'),
            subtitle: const Text('Ignore pointer events when enabled.'),
            value: _ignorePointer,
            onChanged: (value) {
              setState(() {
                _ignorePointer = value;
              });
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Absorb Pointer'),
            subtitle: const Text('Absorb pointer events when enabled.'),
            value: _absorbPointer,
            onChanged: (value) {
              setState(() {
                _absorbPointer = value;
              });
            },
          ),
          const SizedBox(height: 12),
          IgnorePointer(
            ignoring: _ignorePointer,
            child: AbsorbPointer(
              absorbing: _absorbPointer,
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: _duration,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Animated widget received a tap.'),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Center(
                      child: Text(
                        'Tap Me',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _toggleOpacity,
            child: const Text('Toggle Visibility'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection(BuildContext context) {
    return _DemoCard(
      title: '6. Loading State',
      description:
          'A common real-world pattern for showing and hiding '
          'a loading indicator.',
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Center(
              child: AnimatedOpacity(
                opacity: _loading ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
          FilledButton(
            onPressed: _showLoading,
            child: const Text('Start Loading'),
          ),
        ],
      ),
    );
  }

  Widget _buildStateFeedbackSection(BuildContext context) {
    return _DemoCard(
      title: '7. Error / Success States',
      description: 'Use application state to drive opacity for feedback UI.',
      child: Column(
        children: [
          SizedBox(
            height: 110,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _hasError ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Something went wrong',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: _success ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Operation successful',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _showSuccess,
                  child: const Text('Success'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: _showError,
                  child: const Text('Error'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton(onPressed: _resetStates, child: const Text('Reset')),
        ],
      ),
    );
  }

  Widget _buildOverlaySection(BuildContext context) {
    return _DemoCard(
      title: '8. Overlay Fade',
      description:
          'Fade an overlay in and out without changing the '
          'underlying content.',
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.indigo, Colors.purple],
                ),
              ),
              child: const Center(
                child: Icon(Icons.image, color: Colors.white, size: 80),
              ),
            ),
            AnimatedOpacity(
              opacity: _showOverlay ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Text(
                    'Overlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
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

  Widget _buildNotificationSection(BuildContext context) {
    return _DemoCard(
      title: '9. Temporary Notification',
      description:
          'Show a notification, keep it visible briefly, '
          'then fade it away.',
      child: Column(
        children: [
          SizedBox(
            height: 90,
            child: AnimatedOpacity(
              opacity: _showNotification ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Saved successfully',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FilledButton(
            onPressed: _showNotificationTemporarily,
            child: const Text('Show Notification'),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleOpacitySection(BuildContext context) {
    return _DemoCard(
      title: '10. Multiple Independent Opacities',
      description: 'Different widgets can have their own opacity state.',
      child: Column(
        children: [
          AnimatedOpacity(
            opacity: _showMultipleItems ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: const ListTile(
              leading: Icon(Icons.title),
              title: Text('Title'),
              subtitle: Text('First animated element'),
            ),
          ),
          AnimatedOpacity(
            opacity: _showMultipleItems ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 450),
            child: const ListTile(
              leading: Icon(Icons.description),
              title: Text('Description'),
              subtitle: Text('Second animated element'),
            ),
          ),
          AnimatedOpacity(
            opacity: _showMultipleItems ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 650),
            child: const ListTile(
              leading: Icon(Icons.touch_app),
              title: Text('Action'),
              subtitle: Text('Third animated element'),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _showMultipleItems = !_showMultipleItems;
              });
            },
            child: const Text('Toggle All'),
          ),
        ],
      ),
    );
  }

  Widget _buildStaggeredSection(BuildContext context) {
    return _DemoCard(
      title: '11. Staggered Fade Experiment',
      description:
          'Each item has a different duration. This demonstrates '
          'the concept of staggered visual transitions.',
      child: Column(
        key: ValueKey(_staggerKey),
        children: [
          _StaggeredOpacityItem(label: 'Title', delay: Duration.zero),
          _StaggeredOpacityItem(
            label: 'Description',
            delay: const Duration(milliseconds: 150),
          ),
          _StaggeredOpacityItem(
            label: 'Button',
            delay: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _startStaggeredAnimation,
            child: const Text('Restart Staggered Demo'),
          ),
        ],
      ),
    );
  }

  Widget _buildFadeAndRemoveSection(BuildContext context) {
    return _DemoCard(
      title: '12. Fade Out Before Removal',
      description:
          'Demonstrates the important distinction between '
          'becoming transparent and actually removing a widget.',
      child: Column(
        children: [
          if (_showConditionalWidget)
            AnimatedOpacity(
              opacity: _removeAfterFade ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              onEnd: () {
                if (_removeAfterFade && mounted) {
                  setState(() {
                    _showConditionalWidget = false;
                    _removeAfterFade = false;
                  });
                }
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Text(
                    'This will fade out and then be removed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          else
            const Text('Widget has been removed from the tree.'),
          const SizedBox(height: 12),
          if (_showConditionalWidget)
            FilledButton(
              onPressed: _startFadeOutAndRemove,
              child: const Text('Fade Out + Remove'),
            )
          else
            OutlinedButton(
              onPressed: _restoreConditionalWidget,
              child: const Text('Restore Widget'),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedContainerCombination(BuildContext context) {
    return _DemoCard(
      title: '13. AnimatedOpacity + AnimatedContainer',
      description:
          'Combine opacity with another implicit animation for '
          'a richer state transition.',
      child: _CombinedAnimationDemo(opacity: _opacity),
    );
  }

  Widget _buildAnimatedSwitcherComparison(BuildContext context) {
    return _DemoCard(
      title: '14. AnimatedSwitcher Comparison',
      description:
          'AnimatedOpacity is ideal for changing opacity of '
          'the current child. AnimatedSwitcher is useful when '
          'the child itself changes.',
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _success
                ? const Icon(
                    Icons.check_circle,
                    key: ValueKey('success'),
                    color: Colors.green,
                    size: 80,
                  )
                : const Icon(
                    Icons.hourglass_empty,
                    key: ValueKey('waiting'),
                    color: Colors.orange,
                    size: 80,
                  ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Different child → AnimatedSwitcher',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceNotes(BuildContext context) {
    return _DemoCard(
      title: '15. Performance Notes',
      description:
          'Opacity animations can involve compositing. This '
          'section is intentionally informational rather than '
          'a benchmark.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Things to watch:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('• Very large widget subtrees'),
          Text('• Large images'),
          Text('• Complex CustomPaint content'),
          Text('• Many simultaneous opacity animations'),
          Text('• Large scrolling lists'),
          SizedBox(height: 12),
          Text(
            'When performance matters, profile the actual '
            'application using Flutter DevTools instead of '
            'optimizing based only on assumptions.',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentConfiguration(BuildContext context) {
    return _DemoCard(
      title: '16. Current Configuration',
      description: 'A quick view of the values being used by the main demo.',
      child: Column(
        children: [
          _ConfigurationRow(
            label: 'Opacity',
            value: _opacity.toStringAsFixed(2),
          ),
          _ConfigurationRow(
            label: 'Duration',
            value: '${_duration.inMilliseconds} ms',
          ),
          _ConfigurationRow(
            label: 'Ignore Pointer',
            value: _ignorePointer.toString(),
          ),
          _ConfigurationRow(
            label: 'Absorb Pointer',
            value: _absorbPointer.toString(),
          ),
          _ConfigurationRow(label: 'Loading', value: _loading.toString()),
          _ConfigurationRow(label: 'Error', value: _hasError.toString()),
          _ConfigurationRow(label: 'Success', value: _success.toString()),
          _ConfigurationRow(label: 'Overlay', value: _showOverlay.toString()),
        ],
      ),
    );
  }
}

// ============================================================================
// Demo Card
// ============================================================================

class _DemoCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _DemoCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Configuration Row
// ============================================================================

class _ConfigurationRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConfigurationRow({required this.label, required this.value});

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

// ============================================================================
// Staggered Opacity Item
// ============================================================================

class _StaggeredOpacityItem extends StatefulWidget {
  final String label;
  final Duration delay;

  const _StaggeredOpacityItem({required this.label, required this.delay});

  @override
  State<_StaggeredOpacityItem> createState() => _StaggeredOpacityItemState();
}

class _StaggeredOpacityItemState extends State<_StaggeredOpacityItem> {
  double _opacity = 0.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(widget.delay, () {
      if (!mounted) {
        return;
      }

      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Combined AnimatedOpacity + AnimatedContainer Demo
// ============================================================================

class _CombinedAnimationDemo extends StatefulWidget {
  final double opacity;

  const _CombinedAnimationDemo({required this.opacity});

  @override
  State<_CombinedAnimationDemo> createState() => _CombinedAnimationDemoState();
}

class _CombinedAnimationDemoState extends State<_CombinedAnimationDemo> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _selected ? 1.0 : 0.55,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            width: _selected ? 220 : 160,
            height: _selected ? 140 : 100,
            decoration: BoxDecoration(
              color: _selected ? Colors.deepPurple : Colors.grey,
              borderRadius: BorderRadius.circular(_selected ? 30 : 16),
            ),
            child: Center(
              child: Text(
                _selected ? 'Selected' : 'Normal',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {
            setState(() {
              _selected = !_selected;
            });
          },
          child: const Text('Toggle Combined Animation'),
        ),
      ],
    );
  }
}
