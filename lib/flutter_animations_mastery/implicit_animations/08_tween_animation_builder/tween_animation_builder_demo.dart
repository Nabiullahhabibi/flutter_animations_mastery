import 'dart:math' as math;

import 'package:flutter/material.dart';

class TweenAnimationBuilderDemoApp extends StatelessWidget {
  const TweenAnimationBuilderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TweenAnimationBuilder Mastery',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const TweenAnimationBuilderDemoPage(),
    );
  }
}

class TweenAnimationBuilderDemoPage extends StatefulWidget {
  const TweenAnimationBuilderDemoPage({super.key});

  @override
  State<TweenAnimationBuilderDemoPage> createState() =>
      _TweenAnimationBuilderDemoPageState();
}

class _TweenAnimationBuilderDemoPageState
    extends State<TweenAnimationBuilderDemoPage> {
  bool isFavorite = false;
  bool isSelected = false;
  bool isExpanded = false;
  bool isSwitchOn = false;
  bool isSearchExpanded = false;
  bool isRightAligned = false;
  bool isChipSelected = false;
  bool isFabExpanded = false;
  bool isHovered = false;

  double progress = 0.72;
  double dashboardValue = 850;

  int cartCount = 3;

  Color buttonColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TweenAnimationBuilder',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchExpanded = !isSearchExpanded;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: _buildFab(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),

          const SizedBox(height: 20),

          _buildSectionTitle('1. Scale Animation'),
          _buildScaleDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('2. Favorite Button'),
          _buildFavoriteDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('3. Animated Number'),
          _buildNumberDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('4. Progress Animation'),
          _buildProgressDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('5. ColorTween'),
          _buildColorDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('6. Rotation'),
          _buildRotationDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('7. BorderRadiusTween'),
          _buildBorderRadiusDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('8. EdgeInsetsTween'),
          _buildPaddingDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('9. AlignmentTween'),
          _buildAlignmentDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('10. Animated Position'),
          _buildPositionDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('11. Animated Text Size'),
          _buildTextSizeDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('12. Animated Icon Size'),
          _buildIconSizeDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('13. Animated Spacing'),
          _buildSpacingDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('14. Product Card'),
          _buildProductCardDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('15. Expandable Card'),
          _buildExpandableCardDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('16. Custom Switch'),
          _buildSwitchDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('17. Search Bar'),
          _buildSearchBarDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('18. Animated Chip'),
          _buildChipDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('19. Notification Badge'),
          _buildNotificationDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('20. Dashboard Statistic'),
          _buildDashboardDemo(),

          const SizedBox(height: 24),

          _buildSectionTitle('21. CustomPainter Progress'),
          _buildCustomPainterDemo(),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TweenAnimationBuilder Playground',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'This demo contains multiple real-world '
              'TweenAnimationBuilder use cases.',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            const Text(
              'Core pattern:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'State → Target → Tween → Animated Value → UI',
                style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildScaleDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: isSelected ? 1.15 : 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: const Icon(Icons.star, size: 70, color: Colors.amber),
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              child: Text(isSelected ? 'Selected' : 'Select'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteDemo() {
    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: isFavorite ? 1.3 : 1.0),
            duration: const Duration(milliseconds: 350),
            curve: Curves.elasticOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  iconSize: 50,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNumberDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: dashboardValue),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Text(
                  '\$${value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dashboardValue = dashboardValue >= 1000
                      ? 250
                      : dashboardValue + 150;
                });
              },
              child: const Text('Increase Value'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: progress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Column(
                  children: [
                    LinearProgressIndicator(
                      value: value,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${(value * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  progress = progress >= 1 ? 0.1 : progress + 0.1;

                  if (progress > 1) {
                    progress = 1;
                  }
                });
              },
              child: const Text('Increase Progress'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDemo() {
    final targetColor = buttonColor == Colors.deepPurple
        ? Colors.blue
        : Colors.deepPurple;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: buttonColor),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          builder: (context, color, child) {
            return Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'ColorTween',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonColor = targetColor;
                    });
                  },
                  child: const Text('Change Color'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRotationDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: isExpanded ? math.pi / 2 : 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              builder: (context, angle, child) {
                return Transform.rotate(angle: angle, child: child);
              },
              child: const Icon(Icons.arrow_forward_ios, size: 40),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: const Text('Rotate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderRadiusDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<BorderRadius?>(
              tween: BorderRadiusTween(
                end: BorderRadius.circular(isExpanded ? 60 : 12),
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (context, radius, child) {
                return Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: radius,
                  ),
                  child: const Center(
                    child: Text(
                      'Morphing Radius',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddingDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TweenAnimationBuilder<EdgeInsets>(
              tween: EdgeInsetsTween(
                end: isExpanded
                    ? const EdgeInsets.all(35)
                    : const EdgeInsets.all(8),
              ),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              builder: (context, padding, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: padding,
                    child: const Text(
                      'Animated Padding',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlignmentDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TweenAnimationBuilder<Alignment>(
                tween: AlignmentTween(
                  end: isRightAligned
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                ),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                builder: (context, alignment, child) {
                  return Align(alignment: alignment, child: child);
                },
                child: const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isRightAligned = !isRightAligned;
                });
              },
              child: const Text('Move'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionDemo() {
    return Card(
      child: SizedBox(
        height: 150,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: isSelected ? 250 : 0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return Transform.translate(offset: Offset(value, 0), child: child);
          },
          child: const Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(radius: 30, child: Icon(Icons.directions_run)),
          ),
        ),
      ),
    );
  }

  Widget _buildTextSizeDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: isSelected ? 32 : 18),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (context, size, child) {
            return Text(
              'Animated Typography',
              style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIconSizeDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: isFavorite ? 60 : 32),
          duration: const Duration(milliseconds: 350),
          curve: Curves.elasticOut,
          builder: (context, size, child) {
            return Icon(
              Icons.notifications,
              size: size,
              color: Colors.deepPurple,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSpacingDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: isExpanded ? 40 : 8),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          builder: (context, spacing, child) {
            return Column(
              children: [
                const Text(
                  'First Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: spacing),
                const Text(
                  'Second Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCardDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: isHovered ? 1.03 : 1.0),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Icon(Icons.phone_android, size: 100),
                  const SizedBox(height: 12),
                  const Text(
                    'Flutter Phone',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('\$799', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableCardDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Expandable Product',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: isExpanded ? 120 : 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              builder: (context, height, child) {
                return SizedBox(
                  height: height,
                  child: ClipRect(
                    child: Opacity(opacity: isExpanded ? 1 : 0, child: child),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'This content demonstrates a common '
                  'expandable card pattern. In a real application '
                  'this could contain product information, '
                  'settings, descriptions, or additional actions.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Custom Switch',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSwitchOn = !isSwitchOn;
                });
              },
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(end: isSwitchOn ? 1 : 0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  final backgroundColor = Color.lerp(
                    Colors.grey,
                    Colors.green,
                    value,
                  );

                  return Container(
                    width: 70,
                    height: 36,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Align(
                      alignment: Alignment.lerp(
                        Alignment.centerLeft,
                        Alignment.centerRight,
                        value,
                      )!,
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: isSearchExpanded ? 1 : 0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            final width = 50 + (250 * value);

            return Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Icon(Icons.search),
                    ),
                    if (value > 0.5)
                      const Expanded(child: Text('Search products...')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChipDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: isChipSelected ? 1 : 0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            final color = Color.lerp(
              Colors.grey.shade200,
              Colors.deepPurple,
              value,
            );

            final textColor = Color.lerp(Colors.black87, Colors.white, value);

            return GestureDetector(
              onTap: () {
                setState(() {
                  isChipSelected = !isChipSelected;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Flutter',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: cartCount.toDouble()),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart, size: 50),
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          value.toStringAsFixed(0),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(width: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cartCount++;
                });
              },
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Monthly Revenue', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: dashboardValue),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Text(
                  '\$${value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(end: dashboardValue / 1000),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value.clamp(0, 1),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomPainterDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(end: progress),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return SizedBox(
              width: 180,
              height: 180,
              child: CustomPaint(
                painter: CircularProgressPainter(
                  progress: value,
                  strokeWidth: 14,
                ),
                child: Center(
                  child: Text(
                    '${(value * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFab() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: isFabExpanded ? 1 : 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final width = 56 + (100 * value);

        return FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              isFabExpanded = !isFabExpanded;
            });
          },
          icon: Transform.rotate(
            angle: math.pi / 4 * value,
            child: const Icon(Icons.add),
          ),
          label: isFabExpanded ? const Text('Create') : const SizedBox.shrink(),
          extendedPadding: EdgeInsets.symmetric(horizontal: 16 + (8 * value)),
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  CircularProgressPainter({required this.progress, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.shortestSide - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.grey.shade300;

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = Colors.deepPurple;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * math.pi * progress.clamp(0, 1);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
/*

## What this demo teaches

This single Dart file intentionally goes beyond a basic example. It gives you practical implementations of:

```text
1.  Scale
2.  Favorite animation
3.  Animated numbers
4.  Progress
5.  ColorTween
6.  Rotation
7.  BorderRadiusTween
8.  EdgeInsetsTween
9.  AlignmentTween
10. Position
11. Text size
12. Icon size
13. Spacing
14. Product card
15. Expandable card
16. Custom switch
17. Search bar
18. Animated chip
19. Notification/cart badge
20. Dashboard statistics
21. CustomPainter integration
22. Floating action button
```

The most important thing while practicing this file is **not to memorize the code**.

For every example, identify this chain:


text
STATE
  ↓
TARGET
  ↓
TWEEN
  ↓
DURATION
  ↓
CURVE
  ↓
ANIMATED VALUE
  ↓
WIDGET / PAINTER
```

For example, the favorite button:

```text
isFavorite
    ↓
1.0 or 1.3
    ↓
Tween<double>
    ↓
350ms
    ↓
elasticOut
    ↓
scale
    ↓
Transform.scale
```

That mental model is the real skill you want to carry into production Flutter development.

*/