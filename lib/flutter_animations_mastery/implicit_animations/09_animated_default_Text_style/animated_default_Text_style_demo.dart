import 'package:flutter/material.dart';

class AnimatedDefaultTextStyleDemoApp extends StatelessWidget {
  const AnimatedDefaultTextStyleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedDefaultTextStyle Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AnimatedDefaultTextStyleDemoPage(),
    );
  }
}

class AnimatedDefaultTextStyleDemoPage extends StatefulWidget {
  const AnimatedDefaultTextStyleDemoPage({super.key});

  @override
  State<AnimatedDefaultTextStyleDemoPage> createState() =>
      _AnimatedDefaultTextStyleDemoPageState();
}

class _AnimatedDefaultTextStyleDemoPageState
    extends State<AnimatedDefaultTextStyleDemoPage> {
  int _selectedTab = 0;

  bool _isExpanded = false;
  bool _isFavorite = false;
  bool _isFocused = false;
  bool _hasError = false;
  bool _isLoading = false;

  DemoStatus _status = DemoStatus.idle;

  final List<String> _tabs = ['Overview', 'Reviews', 'Details'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedDefaultTextStyle')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroduction(),
            const SizedBox(height: 24),
            _buildBasicExample(),
            const SizedBox(height: 24),
            _buildNavigationExample(),
            const SizedBox(height: 24),
            _buildTabExample(),
            const SizedBox(height: 24),
            _buildExpandableExample(),
            const SizedBox(height: 24),
            _buildValidationExample(),
            const SizedBox(height: 24),
            _buildStatusExample(),
            const SizedBox(height: 24),
            _buildFavoriteExample(),
            const SizedBox(height: 24),
            _buildPricingExample(),
            const SizedBox(height: 24),
            _buildFocusExample(),
            const SizedBox(height: 24),
            _buildOnboardingExample(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AnimatedDefaultTextStyle',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'A collection of practical real-world examples '
          'for animating typography based on UI state.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildBasicExample() {
    return _DemoCard(
      title: '1. Basic Text Style Animation',
      description:
          'Tap the button to change font size, weight, color, '
          'and letter spacing.',
      child: Column(
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: _isExpanded ? 26 : 18,
              fontWeight: _isExpanded ? FontWeight.bold : FontWeight.normal,
              color: _isExpanded ? Colors.indigo : Colors.grey.shade700,
              letterSpacing: _isExpanded ? 1.2 : 0,
            ),
            child: const Text('Hello, Flutter Animation!'),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(_isExpanded ? 'Reset Style' : 'Animate Style'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationExample() {
    return _DemoCard(
      title: '2. Navigation Item',
      description:
          'A common production pattern: selected navigation '
          'items become stronger and larger.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavigationItem(
            icon: Icons.home_outlined,
            label: 'Home',
            index: 0,
          ),
          _buildNavigationItem(icon: Icons.search, label: 'Search', index: 1),
          _buildNavigationItem(
            icon: Icons.person_outline,
            label: 'Profile',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = _selectedTab == index;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                size: selected ? 28 : 24,
                color: selected ? Colors.indigo : Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: selected ? 14 : 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? Colors.indigo : Colors.grey,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabExample() {
    return _DemoCard(
      title: '3. Tab Selection',
      description:
          'Selected tabs use stronger typography while '
          'unselected tabs remain subtle.',
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final bool selected = _selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: selected ? 16 : 14,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                    color: selected ? Colors.indigo : Colors.grey.shade600,
                  ),
                  child: Text(_tabs[index]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildExpandableExample() {
    return _DemoCard(
      title: '4. Expandable Section',
      description:
          'The heading becomes more prominent when the '
          'section is expanded.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      fontSize: _isExpanded ? 20 : 16,
                      fontWeight: _isExpanded
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                    child: const Text('Product Information'),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 350),
                  turns: _isExpanded ? 0.5 : 0,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            child: _isExpanded
                ? const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      'This section contains additional '
                      'information about the product, '
                      'including specifications and features.',
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationExample() {
    return _DemoCard(
      title: '5. Form Validation',
      description:
          'The label changes typography when the field '
          'enters an error state.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            style: TextStyle(
              fontSize: _hasError ? 15 : 14,
              fontWeight: _hasError ? FontWeight.w600 : FontWeight.normal,
              color: _hasError ? Colors.red : Colors.grey.shade700,
            ),
            child: Text(_hasError ? 'Invalid email address' : 'Email address'),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: '[example@email.com](mailto:example@email.com)',
              errorText: _hasError ? 'Please enter a valid email' : null,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Show error state'),
            value: _hasError,
            onChanged: (value) {
              setState(() {
                _hasError = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusExample() {
    final Color statusColor;

    switch (_status) {
      case DemoStatus.idle:
        statusColor = Colors.grey;
      case DemoStatus.loading:
        statusColor = Colors.orange;
      case DemoStatus.success:
        statusColor = Colors.green;
      case DemoStatus.error:
        statusColor = Colors.red;
    }

    String statusText;

    switch (_status) {
      case DemoStatus.idle:
        statusText = 'Ready';
      case DemoStatus.loading:
        statusText = 'Loading...';
      case DemoStatus.success:
        statusText = 'Success!';
      case DemoStatus.error:
        statusText = 'Something went wrong';
    }

    return _DemoCard(
      title: '6. Loading / Success / Error',
      description:
          'A real-world status label that changes its '
          'typography and color according to application state.',
      child: Column(
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: _status == DemoStatus.success ? 22 : 18,
              fontWeight: _status == DemoStatus.idle
                  ? FontWeight.normal
                  : FontWeight.bold,
              color: statusColor,
            ),
            onEnd: () {
              debugPrint('Status text animation completed');
            },
            child: Text(statusText),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _status = DemoStatus.idle;
                  });
                },
                child: const Text('Idle'),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _status = DemoStatus.loading;
                  });
                },
                child: const Text('Loading'),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _status = DemoStatus.success;
                  });
                },
                child: const Text('Success'),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _status = DemoStatus.error;
                  });
                },
                child: const Text('Error'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteExample() {
    return _DemoCard(
      title: '7. Favorite / Unfavorite',
      description: 'Typography changes when an item becomes a favorite.',
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(_isFavorite),
                  color: _isFavorite ? Colors.red : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: _isFavorite ? 18 : 16,
                  fontWeight: _isFavorite ? FontWeight.bold : FontWeight.normal,
                  color: _isFavorite ? Colors.red : Colors.grey.shade700,
                ),
                child: Text(_isFavorite ? 'Favorited' : 'Favorite'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingExample() {
    return _DemoCard(
      title: '8. Pricing Plan Selection',
      description: 'Selected pricing plans become visually stronger.',
      child: Row(
        children: [
          Expanded(
            child: _buildPlan(
              title: 'Basic',
              price: '${9}',
              selected: !_isFavorite,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildPlan(
              title: 'Premium',
              price: '${19}',
              selected: _isFavorite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlan({
    required String title,
    required String price,
    required bool selected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavorite = !selected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Colors.indigo : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          style: TextStyle(
            color: selected ? Colors.indigo : Colors.grey.shade700,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: selected ? 22 : 18,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(
                  fontSize: selected ? 30 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(selected ? 'Selected' : 'Choose plan'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFocusExample() {
    return _DemoCard(
      title: '9. Focused Input Label',
      description:
          'A common form pattern where the label becomes '
          'stronger when the field is focused.',
      child: Focus(
        onFocusChange: (focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: _isFocused ? 16 : 14,
                fontWeight: _isFocused ? FontWeight.bold : FontWeight.normal,
                color: _isFocused ? Colors.indigo : Colors.grey.shade700,
              ),
              child: const Text('Username'),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter username',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo, width: 2),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingExample() {
    final List<String> titles = [
      'Welcome to Flutter',
      'Build Beautiful Interfaces',
      'Master Animations',
    ];

    final int currentPage = _selectedTab.clamp(0, titles.length - 1);

    return _DemoCard(
      title: '10. Onboarding / Step Progress',
      description: 'Current onboarding steps can use stronger typography.',
      child: Column(
        children: [
          Row(
            children: List.generate(titles.length, (index) {
              final bool active = index == currentPage;

              return Expanded(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    fontSize: active ? 16 : 13,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                    color: active ? Colors.indigo : Colors.grey,
                  ),
                  child: Text(
                    '${index + 1}. ${titles[index]}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Text(
            titles[currentPage],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });

                    await Future.delayed(const Duration(milliseconds: 500));

                    if (!mounted) return;

                    setState(() {
                      _isLoading = false;
                      _selectedTab = (_selectedTab + 1) % 3;
                    });
                  },
            child: Text(_isLoading ? 'Moving...' : 'Next Step'),
          ),
        ],
      ),
    );
  }
}

enum DemoStatus { idle, loading, success, error }

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}
