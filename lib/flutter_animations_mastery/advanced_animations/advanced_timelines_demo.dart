import 'package:flutter/material.dart';

class AdvancedTimelinesApp extends StatelessWidget {
  const AdvancedTimelinesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Timelines',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AdvancedTimelinesScreen(),
    );
  }
}

class AdvancedTimelinesScreen extends StatefulWidget {
  const AdvancedTimelinesScreen({super.key});

  @override
  State<AdvancedTimelinesScreen> createState() =>
      _AdvancedTimelinesScreenState();
}

class _AdvancedTimelinesScreenState extends State<AdvancedTimelinesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _pulseController;

  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _cardOpacity;
  late final Animation<double> _cardScale;
  late final Animation<double> _statsOpacity;
  late final Animation<Offset> _statsSlide;
  late final Animation<double> _buttonOpacity;
  late final Animation<double> _buttonScale;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    // Master timeline: one controller synchronizes the staggered sequence.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    final header = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.25, curve: Curves.easeOutCubic),
      reverseCurve: const Interval(0.0, 0.25, curve: Curves.easeInCubic),
    );
    _headerOpacity = Tween(begin: 0.0, end: 1.0).animate(header);
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.25),
      end: Offset.zero,
    ).animate(header);

    final card = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.50, curve: Curves.easeOutBack),
      reverseCurve: const Interval(0.15, 0.50, curve: Curves.easeInCubic),
    );
    _cardOpacity = Tween(begin: 0.0, end: 1.0).animate(card);
    _cardScale = Tween(begin: 0.85, end: 1.0).animate(card);

    final stats = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 0.75, curve: Curves.easeOutCubic),
      reverseCurve: const Interval(0.40, 0.75, curve: Curves.easeInCubic),
    );
    _statsOpacity = Tween(begin: 0.0, end: 1.0).animate(stats);
    _statsSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(stats);

    final button = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.70, 1.0, curve: Curves.easeOutBack),
      reverseCurve: const Interval(0.70, 1.0, curve: Curves.easeInCubic),
    );
    _buttonOpacity = Tween(begin: 0.0, end: 1.0).animate(button);
    _buttonScale = Tween(begin: 0.75, end: 1.0).animate(button);

    // Independent repeating timeline: intentionally separate from the
    // one-time/staggered entrance timeline.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulse = Tween(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _pulseController.repeat(reverse: true);
    _controller.forward();
  }

  void _play() => _controller.forward(from: 0.0);
  void _reverse() => _controller.reverse();
  void _repeat() => _controller.repeat(reverse: true);
  void _stop() => _controller.stop();
  void _reset() => _controller.reset();

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

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Animation Timelines'),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([_controller, _pulseController]),
        builder: (context, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 130),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _headerOpacity,
                      child: SlideTransition(
                        position: _headerSlide,
                        child: const _DashboardHeader(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Opacity(
                      opacity: _cardOpacity.value,
                      child: Transform.scale(
                        scale: _cardScale.value,
                        child: const _MainProjectCard(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _statsOpacity,
                      child: SlideTransition(
                        position: _statsSlide,
                        child: const Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.check_circle_outline,
                                title: 'Completed',
                                value: '128',
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.schedule,
                                title: 'Pending',
                                value: '12',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _LiveStatus(pulse: _pulse),
                    const SizedBox(height: 28),
                    Opacity(
                      opacity: _buttonOpacity.value,
                      child: Transform.scale(
                        scale: _buttonScale.value,
                        child: FilledButton.icon(
                          onPressed: _play,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Replay Timeline'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _ControlPanel(
                  status: _status,
                  onPlay: _play,
                  onReverse: _reverse,
                  onRepeat: _repeat,
                  onStop: _stop,
                  onReset: _reset,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(radius: 28, child: Icon(Icons.dashboard_rounded)),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('Everything is synchronized.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _MainProjectCard extends StatelessWidget {
  const _MainProjectCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(26),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.cloud_done_rounded, size: 34),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Deployment',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.more_horiz),
            ],
          ),
          SizedBox(height: 20),
          Text('Production deployment is ready.'),
          SizedBox(height: 18),
          LinearProgressIndicator(value: 0.86, minHeight: 8),
          SizedBox(height: 10),
          Text('86% processed'),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _LiveStatus extends AnimatedWidget {
  const _LiveStatus({required Animation<double> pulse})
    : super(listenable: pulse);

  Animation<double> get pulse => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: pulse.value,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'Live synchronization active',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ControlPanel extends StatelessWidget {
  final String status;
  final VoidCallback onPlay;
  final VoidCallback onReverse;
  final VoidCallback onRepeat;
  final VoidCallback onStop;
  final VoidCallback onReset;

  const _ControlPanel({
    required this.status,
    required this.onPlay,
    required this.onReverse,
    required this.onRepeat,
    required this.onStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(status, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilledButton(onPressed: onPlay, child: const Text('Play')),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onReverse,
                      child: const Text('Reverse'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onRepeat,
                      child: const Text('Repeat'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onStop,
                      child: const Text('Stop'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(onPressed: onReset, child: const Text('Reset')),
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
