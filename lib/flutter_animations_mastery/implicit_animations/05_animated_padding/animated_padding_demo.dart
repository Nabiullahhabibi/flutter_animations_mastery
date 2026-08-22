import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedPaddingDemoApp());
}

class AnimatedPaddingDemoApp extends StatelessWidget {
  const AnimatedPaddingDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedPadding Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const AnimatedPaddingDemoPage(),
    );
  }
}

class AnimatedPaddingDemoPage extends StatefulWidget {
  const AnimatedPaddingDemoPage({super.key});

  @override
  State<AnimatedPaddingDemoPage> createState() =>
      _AnimatedPaddingDemoPageState();
}

class _AnimatedPaddingDemoPageState extends State<AnimatedPaddingDemoPage> {
  bool isExpanded = false;
  bool isSelected = false;
  bool isFocused = false;
  bool isSidebarExpanded = false;
  bool hasError = false;
  bool isLoading = false;
  bool isHovered = false;

  double paddingValue = 16;

  Curve selectedCurve = Curves.easeInOut;

  Duration selectedDuration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedPadding'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            _buildIntroduction(),

            const SizedBox(height: 24),

            _buildBasicDemo(),

            const SizedBox(height: 24),

            _buildExpandableCard(),

            const SizedBox(height: 24),

            _buildNavigationDemo(),

            const SizedBox(height: 24),

            _buildSearchDemo(),

            const SizedBox(height: 24),

            _buildFormDemo(),

            const SizedBox(height: 24),

            _buildDashboardDemo(),

            const SizedBox(height: 24),

            _buildResponsiveDemo(),

            const SizedBox(height: 24),

            _buildLoadingDemo(),

            const SizedBox(height: 24),

            _buildErrorDemo(),

            const SizedBox(height: 24),

            _buildHoverDemo(),

            const SizedBox(height: 24),

            _buildControls(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INTRODUCTION
  // ---------------------------------------------------------------------------

  Widget _buildIntroduction() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AnimatedPadding',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'An implicit animation that smoothly transitions '
            'between different padding values.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BASIC DEMO
  // ---------------------------------------------------------------------------

  Widget _buildBasicDemo() {
    return _DemoSection(
      title: '1. Basic AnimatedPadding',
      description:
          'The simplest example: change padding and Flutter '
          'automatically animates between the old and new values.',
      child: Column(
        children: [
          AnimatedPadding(
            duration: selectedDuration,
            curve: selectedCurve,
            padding: EdgeInsets.all(paddingValue),
            onEnd: () {
              debugPrint('Basic padding animation completed');
            },
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                '${paddingValue.toInt()} px padding',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Slider(
            min: 0,
            max: 50,
            value: paddingValue,
            onChanged: (value) {
              setState(() {
                paddingValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // EXPANDABLE CARD
  // ---------------------------------------------------------------------------

  Widget _buildExpandableCard() {
    return _DemoSection(
      title: '2. Expandable Card',
      description:
          'Real-world example: increase the internal spacing '
          'when a card expands.',
      child: Column(
        children: [
          AnimatedPadding(
            duration: selectedDuration,
            curve: selectedCurve,
            padding: EdgeInsets.all(isExpanded ? 24 : 8),
            child: Card(
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Expandable Card',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      isExpanded
                          ? 'The card is expanded.'
                          : 'The card is collapsed.',
                    ),
                    trailing: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                  if (isExpanded)
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'This content appears when the card expands. '
                        'AnimatedPadding controls the surrounding '
                        'layout spacing smoothly.',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // NAVIGATION ITEM
  // ---------------------------------------------------------------------------

  Widget _buildNavigationDemo() {
    return _DemoSection(
      title: '3. Selected Navigation Item',
      description:
          'Real-world example: increase horizontal padding '
          'when a navigation item becomes selected.',
      child: Column(
        children: [
          AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(horizontal: isSelected ? 24 : 8),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: const Text('Home'),
                trailing: isSelected ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SEARCH BAR
  // ---------------------------------------------------------------------------

  Widget _buildSearchDemo() {
    return _DemoSection(
      title: '4. Search Bar Focus',
      description:
          'Real-world example: change surrounding spacing '
          'when a search field receives focus.',
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: isFocused ? 4 : 20),
        child: TextField(
          onTap: () {
            setState(() {
              isFocused = true;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: isFocused
                ? IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      setState(() {
                        isFocused = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FORM VALIDATION
  // ---------------------------------------------------------------------------

  Widget _buildFormDemo() {
    return _DemoSection(
      title: '5. Form Validation',
      description:
          'Real-world example: smoothly adjust spacing when '
          'a validation message appears.',
      child: Column(
        children: [
          AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: hasError ? 8 : 20),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                errorText: hasError ? 'Please enter a valid email.' : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          FilledButton.icon(
            onPressed: () {
              setState(() {
                hasError = !hasError;
              });
            },
            icon: Icon(hasError ? Icons.check : Icons.error_outline),
            label: Text(hasError ? 'Remove Error' : 'Show Error'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DASHBOARD / SIDEBAR
  // ---------------------------------------------------------------------------

  Widget _buildDashboardDemo() {
    return _DemoSection(
      title: '6. Dashboard Content',
      description:
          'Real-world example: change content padding when '
          'a sidebar expands or collapses.',
      child: Column(
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSidebarExpanded ? 120 : 60,
                height: 160,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSidebarExpanded = !isSidebarExpanded;
                    });
                  },
                  icon: Icon(
                    isSidebarExpanded
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(isSidebarExpanded ? 24 : 8),
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Dashboard Content',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // RESPONSIVE PADDING
  // ---------------------------------------------------------------------------

  Widget _buildResponsiveDemo() {
    return _DemoSection(
      title: '7. Responsive Layout',
      description:
          'The padding changes according to the available '
          'screen width. Resize the window on desktop/web.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final horizontalPadding = width >= 900
              ? 48.0
              : width >= 600
              ? 32.0
              : 16.0;

          return AnimatedPadding(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                'Screen width: ${width.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LOADING → CONTENT
  // ---------------------------------------------------------------------------

  Widget _buildLoadingDemo() {
    return _DemoSection(
      title: '8. Loading → Content',
      description:
          'Real-world example: adjust spacing when loading '
          'state changes to content state.',
      child: Column(
        children: [
          AnimatedPadding(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            padding: EdgeInsets.only(
              top: isLoading ? 40 : 12,
              bottom: isLoading ? 40 : 12,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLoading
                  ? const SizedBox(
                      key: ValueKey('loading'),
                      height: 80,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox(
                      key: ValueKey('content'),
                      height: 80,
                      child: Center(
                        child: Text(
                          'Content Loaded',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                isLoading = !isLoading;
              });
            },
            child: Text(isLoading ? 'Show Content' : 'Start Loading'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ERROR / SUCCESS STATE
  // ---------------------------------------------------------------------------

  Widget _buildErrorDemo() {
    return _DemoSection(
      title: '9. Error / Success State',
      description:
          'Use padding transitions to make state changes '
          'feel less abrupt.',
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(hasError ? 8 : 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hasError
                ? Theme.of(context).colorScheme.errorContainer
                : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(hasError ? Icons.error_outline : Icons.check_circle_outline),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasError ? 'Something went wrong.' : 'Everything looks good.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HOVER
  // ---------------------------------------------------------------------------

  Widget _buildHoverDemo() {
    return _DemoSection(
      title: '10. Desktop / Web Hover',
      description:
          'On desktop/web, increase padding when the mouse '
          'hovers over the card.',
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
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.all(isHovered ? 18 : 14),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              isHovered ? 'Hovering' : 'Move your mouse here',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CONTROLS
  // ---------------------------------------------------------------------------

  Widget _buildControls() {
    return _DemoSection(
      title: 'Animation Controls',
      description:
          'Experiment with duration and curves to understand '
          'how they affect AnimatedPadding.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold)),

          DropdownButton<Duration>(
            value: selectedDuration,
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                value: Duration(milliseconds: 150),
                child: Text('150 ms — Very Fast'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 250),
                child: Text('250 ms — Fast'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 400),
                child: Text('400 ms — Normal'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 600),
                child: Text('600 ms — Slow'),
              ),
              DropdownMenuItem(
                value: Duration(milliseconds: 1000),
                child: Text('1000 ms — Very Slow'),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                selectedDuration = value;
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

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  isExpanded = false;
                  isSelected = false;
                  isFocused = false;
                  isSidebarExpanded = false;
                  hasError = false;
                  isLoading = false;
                  isHovered = false;
                  paddingValue = 16;
                });
              },
              child: const Text('Reset All Demos'),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// REUSABLE DEMO SECTION
// =============================================================================

class _DemoSection extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _DemoSection({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 20),

              child,
            ],
          ),
        ),
      ),
    );
  }
}
