import 'package:flutter/material.dart';

class AnimatedSwitcherDemo extends StatefulWidget {
  const AnimatedSwitcherDemo({super.key});

  @override
  State<AnimatedSwitcherDemo> createState() => _AnimatedSwitcherDemoState();
}

class _AnimatedSwitcherDemoState extends State<AnimatedSwitcherDemo> {
  int _selectedDemo = 0;

  final List<String> _demoNames = [
    'Counter',
    'Loading',
    'Login',
    'Play/Pause',
    'Favorite',
    'Cart',
    'Validation',
    'Network',
    'Custom',
    'Theme',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDemoSelector(),
        const Divider(height: 1),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: KeyedSubtree(
              key: ValueKey(_selectedDemo),
              child: _buildSelectedDemo(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDemoSelector() {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _demoNames.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
        itemBuilder: (context, index) {
          final bool isSelected = _selectedDemo == index;

          return ChoiceChip(
            label: Text(_demoNames[index]),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedDemo = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildSelectedDemo() {
    switch (_selectedDemo) {
      case 0:
        return const CounterDemo();

      case 1:
        return const LoadingContentDemo();

      case 2:
        return const LoginLogoutDemo();

      case 3:
        return const PlayPauseDemo();

      case 4:
        return const FavoriteDemo();

      case 5:
        return const CartQuantityDemo();

      case 6:
        return const FormValidationDemo();

      case 7:
        return const NetworkStateDemo();

      case 8:
        return const CustomTransitionDemo();

      case 9:
        return const ThemeIconDemo();

      default:
        return const CounterDemo();
    }
  }
}

// ============================================================
// 1. COUNTER DEMO
// ============================================================

class CounterDemo extends StatefulWidget {
  const CounterDemo({super.key});

  @override
  State<CounterDemo> createState() => _CounterDemoState();
}

class _CounterDemoState extends State<CounterDemo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Counter',
      description:
          'ValueKey tells AnimatedSwitcher that every number is a '
          'different child.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: Text(
              '$_counter',
              key: ValueKey(_counter),
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _counter--;
                  });
                },
                icon: const Icon(Icons.remove),
                label: const Text('Decrease'),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Increase'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 2. LOADING → CONTENT
// ============================================================

class LoadingContentDemo extends StatefulWidget {
  const LoadingContentDemo({super.key});

  @override
  State<LoadingContentDemo> createState() => _LoadingContentDemoState();
}

class _LoadingContentDemoState extends State<LoadingContentDemo> {
  bool _isLoading = true;

  Future<void> _simulateRequest() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Loading → Content',
      description:
          'Common for API requests, dashboards, profiles, '
          'product pages, and database queries.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: _isLoading
                ? const LoadingCard(key: ValueKey('loading'))
                : const LoadedCard(key: ValueKey('loaded')),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: _simulateRequest,
            child: const Text('Simulate API Request'),
          ),
        ],
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 180,
      child: Card(child: Center(child: CircularProgressIndicator())),
    );
  }
}

class LoadedCard extends StatelessWidget {
  const LoadedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 180,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 56),
              SizedBox(height: 12),
              Text(
                'Data Loaded',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 3. LOGIN → LOGOUT
// ============================================================

class LoginLogoutDemo extends StatefulWidget {
  const LoginLogoutDemo({super.key});

  @override
  State<LoginLogoutDemo> createState() => _LoginLogoutDemoState();
}

class _LoginLogoutDemoState extends State<LoginLogoutDemo> {
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Login → Logout',
      description: 'Useful for authentication-driven interfaces.',
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            );
          },
          child: _isLoggedIn
              ? FilledButton.icon(
                  key: const ValueKey('logout'),
                  onPressed: () {
                    setState(() {
                      _isLoggedIn = false;
                    });
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                )
              : FilledButton.icon(
                  key: const ValueKey('login'),
                  onPressed: () {
                    setState(() {
                      _isLoggedIn = true;
                    });
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Login'),
                ),
        ),
      ),
    );
  }
}

// ============================================================
// 4. PLAY → PAUSE
// ============================================================

class PlayPauseDemo extends StatefulWidget {
  const PlayPauseDemo({super.key});

  @override
  State<PlayPauseDemo> createState() => _PlayPauseDemoState();
}

class _PlayPauseDemoState extends State<PlayPauseDemo> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Play → Pause',
      description:
          'Common in music players, video players, '
          'audio controls, and media applications.',
      child: Center(
        child: IconButton.filled(
          iconSize: 48,
          onPressed: () {
            setState(() {
              _isPlaying = !_isPlaying;
            });
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              key: ValueKey(_isPlaying),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 5. FAVORITE
// ============================================================

class FavoriteDemo extends StatefulWidget {
  const FavoriteDemo({super.key});

  @override
  State<FavoriteDemo> createState() => _FavoriteDemoState();
}

class _FavoriteDemoState extends State<FavoriteDemo> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Favorite',
      description:
          'Useful for likes, favorites, bookmarks, '
          'saved items, and binary states.',
      child: Center(
        child: IconButton(
          iconSize: 70,
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(_isFavorite),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 6. CART QUANTITY
// ============================================================

class CartQuantityDemo extends StatefulWidget {
  const CartQuantityDemo({super.key});

  @override
  State<CartQuantityDemo> createState() => _CartQuantityDemoState();
}

class _CartQuantityDemoState extends State<CartQuantityDemo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Cart Quantity',
      description: 'Real-world e-commerce example for product quantities.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _quantity > 1
                ? () {
                    setState(() {
                      _quantity--;
                    });
                  }
                : null,
            icon: const Icon(Icons.remove),
          ),
          const SizedBox(width: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: Text(
              '$_quantity',
              key: ValueKey(_quantity),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 24),
          IconButton(
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 7. FORM VALIDATION
// ============================================================

class FormValidationDemo extends StatefulWidget {
  const FormValidationDemo({super.key});

  @override
  State<FormValidationDemo> createState() => _FormValidationDemoState();
}

class _FormValidationDemoState extends State<FormValidationDemo> {
  String? _error;

  void _toggleError() {
    setState(() {
      _error = _error == null ? 'Please enter a valid email address.' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return DemoContainer(
      title: 'Form Validation',
      description:
          'AnimatedSwitcher can smoothly display and remove '
          'validation messages.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 320,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0, -0.2),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: _error == null
                ? const SizedBox(key: ValueKey('no-error'), height: 24)
                : Text(
                    _error!,
                    key: ValueKey(_error),
                    style: TextStyle(
                      color: errorColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _toggleError,
            child: Text(_error == null ? 'Show Error' : 'Hide Error'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 8. NETWORK STATE
// ============================================================

enum NetworkState { offline, connecting, online }

class NetworkStateDemo extends StatefulWidget {
  const NetworkStateDemo({super.key});

  @override
  State<NetworkStateDemo> createState() => _NetworkStateDemoState();
}

class _NetworkStateDemoState extends State<NetworkStateDemo> {
  NetworkState _state = NetworkState.offline;

  void _nextState() {
    setState(() {
      switch (_state) {
        case NetworkState.offline:
          _state = NetworkState.connecting;
          break;

        case NetworkState.connecting:
          _state = NetworkState.online;
          break;

        case NetworkState.online:
          _state = NetworkState.offline;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Network State',
      description: 'A state-machine example: Offline → Connecting → Online.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: _buildNetworkState(),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: _nextState,
            child: const Text('Change Network State'),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkState() {
    switch (_state) {
      case NetworkState.offline:
        return const NetworkStatusCard(
          key: ValueKey('offline'),
          icon: Icons.cloud_off,
          title: 'Offline',
        );

      case NetworkState.connecting:
        return const NetworkStatusCard(
          key: ValueKey('connecting'),
          icon: Icons.sync,
          title: 'Connecting...',
        );

      case NetworkState.online:
        return const NetworkStatusCard(
          key: ValueKey('online'),
          icon: Icons.cloud_done,
          title: 'Online',
        );
    }
  }
}

class NetworkStatusCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const NetworkStatusCard({required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 280,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 52),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 9. CUSTOM TRANSITION
// ============================================================

class CustomTransitionDemo extends StatefulWidget {
  const CustomTransitionDemo({super.key});

  @override
  State<CustomTransitionDemo> createState() => _CustomTransitionDemoState();
}

class _CustomTransitionDemoState extends State<CustomTransitionDemo> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Custom Transition',
      description:
          'Combines FadeTransition, SlideTransition, '
          'and ScaleTransition.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: slide,
                  child: ScaleTransition(scale: animation, child: child),
                ),
              );
            },
            child: _showFirst
                ? const DemoBox(key: ValueKey('first'), title: 'FIRST')
                : const DemoBox(key: ValueKey('second'), title: 'SECOND'),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {
              setState(() {
                _showFirst = !_showFirst;
              });
            },
            child: const Text('Switch'),
          ),
        ],
      ),
    );
  }
}

class DemoBox extends StatelessWidget {
  final String title;

  const DemoBox({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ============================================================
// 10. THEME ICON
// ============================================================

class ThemeIconDemo extends StatefulWidget {
  const ThemeIconDemo({super.key});

  @override
  State<ThemeIconDemo> createState() => _ThemeIconDemoState();
}

class _ThemeIconDemoState extends State<ThemeIconDemo> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      title: 'Theme Icon',
      description: 'Useful for theme toggles and appearance controls.',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: Icon(
              _darkMode ? Icons.dark_mode : Icons.light_mode,
              key: ValueKey(_darkMode),
              size: 100,
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {
              setState(() {
                _darkMode = !_darkMode;
              });
            },
            child: Text(_darkMode ? 'Switch to Light' : 'Switch to Dark'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REUSABLE DEMO CONTAINER
// ============================================================

class DemoContainer extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const DemoContainer({
    required this.title,
    required this.description,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
