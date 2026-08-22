import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedPositionedDemoApp());
}

class AnimatedPositionedDemoApp extends StatelessWidget {
  const AnimatedPositionedDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedPositioned Mastery',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AnimatedPositionedDemo(),
    );
  }
}

class AnimatedPositionedDemo extends StatefulWidget {
  const AnimatedPositionedDemo({super.key});

  @override
  State<AnimatedPositionedDemo> createState() => _AnimatedPositionedDemoState();
}

class _AnimatedPositionedDemoState extends State<AnimatedPositionedDemo> {
  bool isMoved = false;
  bool isExpanded = false;
  bool isPanelOpen = false;
  bool isFabOpen = false;
  bool isNotificationVisible = false;

  int selectedSegment = 0;

  Duration animationDuration = const Duration(milliseconds: 500);

  Curve selectedCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedPositioned Mastery')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildIntroductionCard(),
            const SizedBox(height: 20),
            _buildBasicMovementDemo(),
            const SizedBox(height: 20),
            _buildPositionAndSizeDemo(),
            const SizedBox(height: 20),
            _buildSlidingPanelDemo(),
            const SizedBox(height: 20),
            _buildFloatingActionButtonDemo(),
            const SizedBox(height: 20),
            _buildSegmentedIndicatorDemo(),
            const SizedBox(height: 20),
            _buildNotificationBadgeDemo(),
            const SizedBox(height: 20),
            _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroductionCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AnimatedPositioned',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'This demo demonstrates how AnimatedPositioned can '
              'animate Stack-based position and size changes.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Core concept:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text('State → Position/Size Change → Implicit Animation'),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicMovementDemo() {
    return _DemoCard(
      title: '1. Basic Movement',
      description:
          'The blue box moves horizontally by changing the left property.',
      child: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: animationDuration,
                  curve: selectedCurve,
                  left: isMoved ? 220 : 20,
                  top: 40,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.animation, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              setState(() {
                isMoved = !isMoved;
              });
            },
            icon: const Icon(Icons.swap_horiz),
            label: Text(isMoved ? 'Move Back' : 'Move Right'),
          ),
        ],
      ),
    );
  }

  Widget _buildPositionAndSizeDemo() {
    return _DemoCard(
      title: '2. Position + Size',
      description:
          'AnimatedPositioned can animate position and dimensions simultaneously.',
      child: Column(
        children: [
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: animationDuration,
                  curve: selectedCurve,
                  left: isExpanded ? 20 : 100,
                  top: isExpanded ? 20 : 110,
                  width: isExpanded ? 280 : 100,
                  height: isExpanded ? 280 : 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(isExpanded ? 28 : 18),
                    ),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: animationDuration,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isExpanded ? 24 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Text(isExpanded ? 'Expanded Card' : 'Card'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            icon: Icon(isExpanded ? Icons.close : Icons.open_in_full),
            label: Text(isExpanded ? 'Collapse' : 'Expand'),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidingPanelDemo() {
    return _DemoCard(
      title: '3. Sliding Side Panel',
      description: 'A custom panel slides into the Stack from the left side.',
      child: Column(
        children: [
          Container(
            height: 260,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Main Content',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('This represents your application content.'),
                        const Spacer(),
                        FilledButton.icon(
                          onPressed: () {
                            setState(() {
                              isPanelOpen = !isPanelOpen;
                            });
                          },
                          icon: Icon(isPanelOpen ? Icons.close : Icons.menu),
                          label: Text(
                            isPanelOpen ? 'Close Panel' : 'Open Panel',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Sliding panel.
                AnimatedPositioned(
                  duration: animationDuration,
                  curve: selectedCurve,
                  left: isPanelOpen ? 0 : -220,
                  top: 0,
                  bottom: 0,
                  width: 220,
                  child: Material(
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.indigo,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Menu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          _panelItem(Icons.home, 'Home'),
                          _panelItem(Icons.person, 'Profile'),
                          _panelItem(Icons.settings, 'Settings'),
                          _panelItem(Icons.info, 'About'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButtonDemo() {
    return _DemoCard(
      title: '4. Expandable Floating Actions',
      description:
          'Multiple AnimatedPositioned widgets create an expanding '
          'floating action menu.',
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: animationDuration,
              curve: selectedCurve,
              right: 20,
              bottom: isFabOpen ? 150 : 20,
              child: _smallActionButton(icon: Icons.image, onTap: () {}),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              curve: selectedCurve,
              right: 20,
              bottom: isFabOpen ? 90 : 20,
              child: _smallActionButton(icon: Icons.camera_alt, onTap: () {}),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              curve: selectedCurve,
              right: 20,
              bottom: isFabOpen ? 150 : 20,
              child: const SizedBox.shrink(),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              curve: selectedCurve,
              right: 20,
              bottom: isFabOpen ? 90 : 20,
              child: const SizedBox.shrink(),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isFabOpen = !isFabOpen;
                  });
                },
                child: AnimatedRotation(
                  duration: animationDuration,
                  turns: isFabOpen ? 0.125 : 0,
                  child: Icon(isFabOpen ? Icons.close : Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return FloatingActionButton.small(
      heroTag: null,
      onPressed: onTap,
      child: Icon(icon),
    );
  }

  Widget _buildSegmentedIndicatorDemo() {
    return _DemoCard(
      title: '5. Custom Segmented Indicator',
      description: 'AnimatedPositioned moves an indicator between segments.',
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final segmentWidth = constraints.maxWidth / 3;

                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: animationDuration,
                      curve: selectedCurve,
                      left: segmentWidth * selectedSegment,
                      top: 4,
                      bottom: 4,
                      width: segmentWidth,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _segmentButton('One', 0),
                        _segmentButton('Two', 1),
                        _segmentButton('Three', 2),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _segmentButton(String title, int index) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            selectedSegment = index;
          });
        },
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selectedSegment == index ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationBadgeDemo() {
    return _DemoCard(
      title: '6. Notification Badge',
      description:
          'The badge changes its position when notifications become visible.',
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            const Center(
              child: Icon(Icons.notifications, size: 100, color: Colors.indigo),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              curve: selectedCurve,
              top: isNotificationVisible ? 40 : 70,
              right: isNotificationVisible ? 80 : 130,
              child: AnimatedScale(
                duration: animationDuration,
                scale: isNotificationVisible ? 1 : 0.7,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '99+',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: FilledButton(
                  onPressed: () {
                    setState(() {
                      isNotificationVisible = !isNotificationVisible;
                    });
                  },
                  child: Text(
                    isNotificationVisible ? 'Hide Badge' : 'Show Badge',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return _DemoCard(
      title: 'Animation Controls',
      description:
          'Experiment with duration and curves to understand how they affect motion.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<Duration>(
            value: animationDuration,
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: Duration(milliseconds: 200),
                child: Text('200 ms — Fast'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 400),
                child: Text('400 ms — Medium'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 500),
                child: Text('500 ms — Default'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 800),
                child: Text('800 ms — Slow'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 1200),
                child: Text('1200 ms — Very Slow'),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                animationDuration = value;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text('Curve', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<Curve>(
            value: selectedCurve,
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: Curves.linear, child: Text('Linear')),
              DropdownMenuItem(value: Curves.ease, child: Text('Ease')),
              DropdownMenuItem(value: Curves.easeIn, child: Text('Ease In')),
              DropdownMenuItem(value: Curves.easeOut, child: Text('Ease Out')),
              DropdownMenuItem(
                value: Curves.easeInOut,
                child: Text('Ease In Out'),
              ),
              DropdownMenuItem(
                value: Curves.fastOutSlowIn,
                child: Text('Fast Out Slow In'),
              ),
              DropdownMenuItem(
                value: Curves.decelerate,
                child: Text('Decelerate'),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                selectedCurve = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
