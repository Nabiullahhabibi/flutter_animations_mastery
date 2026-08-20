import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedAlignDemoApp());
}

class AnimatedAlignDemoApp extends StatelessWidget {
  const AnimatedAlignDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedAlign Mastery',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AnimatedAlignHomePage(),
    );
  }
}

class AnimatedAlignHomePage extends StatefulWidget {
  const AnimatedAlignHomePage({super.key});

  @override
  State<AnimatedAlignHomePage> createState() => _AnimatedAlignHomePageState();
}

class _AnimatedAlignHomePageState extends State<AnimatedAlignHomePage> {
  int selectedDemo = 0;

  final List<String> demoNames = [
    'Basic Alignment',
    'All Alignments',
    'Custom Alignment',
    'Animated Toggle',
    'Notification Badge',
    'Avatar Transition',
    'Onboarding',
    'Empty State',
    'Chat Bubble',
    'Action Button',
    'Animated Card',
    'Opacity + Align',
    'Scale + Align',
    'Full Combination',
    'Directional Alignment',
    'Width / Height Factor',
    'Curve Playground',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(demoNames[selectedDemo])),

      drawer: DemoDrawer(
        demoNames: demoNames,
        selectedDemo: selectedDemo,
        onDemoSelected: (index) {
          setState(() {
            selectedDemo = index;
          });
        },
      ),

      body: DemoScreen(demoIndex: selectedDemo, title: demoNames[selectedDemo]),
    );
  }
}

class DemoScreen extends StatelessWidget {
  final int demoIndex;
  final String title;

  const DemoScreen({super.key, required this.demoIndex, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Chip(label: Text('Demo ${demoIndex + 1}')),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _buildDemo(),
          ),
        ),
      ],
    );
  }

  Widget _buildDemo() {
    switch (demoIndex) {
      case 0:
        return const BasicAlignmentDemo();

      case 1:
        return const AllAlignmentsDemo();

      case 2:
        return const CustomAlignmentDemo();

      case 3:
        return const AnimatedToggleDemo();

      case 4:
        return const NotificationBadgeDemo();

      case 5:
        return const AvatarTransitionDemo();

      case 6:
        return const OnboardingDemo();

      case 7:
        return const EmptyStateDemo();

      case 8:
        return const ChatBubbleDemo();

      case 9:
        return const ActionButtonDemo();

      case 10:
        return const AnimatedCardDemo();

      case 11:
        return const OpacityAndAlignDemo();

      case 12:
        return const ScaleAndAlignDemo();

      case 13:
        return const FullCombinationDemo();

      case 14:
        return const DirectionalAlignmentDemo();

      case 15:
        return const FactorDemo();

      case 16:
        return const CurvePlaygroundDemo();

      default:
        return const BasicAlignmentDemo();
    }
  }
}

/* -------------------------------------------------------------------------- */
/* 1. BASIC ALIGNMENT                                                         */
/* -------------------------------------------------------------------------- */

class BasicAlignmentDemo extends StatefulWidget {
  const BasicAlignmentDemo({super.key});

  @override
  State<BasicAlignmentDemo> createState() => _BasicAlignmentDemoState();
}

class _BasicAlignmentDemoState extends State<BasicAlignmentDemo> {
  Alignment alignment = Alignment.centerLeft;

  void move() {
    setState(() {
      if (alignment == Alignment.centerLeft) {
        alignment = Alignment.center;
      } else if (alignment == Alignment.center) {
        alignment = Alignment.centerRight;
      } else {
        alignment = Alignment.centerLeft;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      child: Column(
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: alignment,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: const DemoBox(label: 'AnimatedAlign'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: move,
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Move'),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 2. ALL ALIGNMENTS                                                          */
/* -------------------------------------------------------------------------- */

class AllAlignmentsDemo extends StatefulWidget {
  const AllAlignmentsDemo({super.key});

  @override
  State<AllAlignmentsDemo> createState() => _AllAlignmentsDemoState();
}

class _AllAlignmentsDemoState extends State<AllAlignmentsDemo> {
  final List<Alignment> alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  int index = 0;

  void next() {
    setState(() {
      index = (index + 1) % alignments.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      child: Column(
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: alignments[index],
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              child: DemoBox(
                label: 'Position ${index + 1}',
                icon: Icons.location_on,
              ),
            ),
          ),
          Text(
            'Alignment: ${alignments[index]}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: next, child: const Text('Next Alignment')),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 3. CUSTOM ALIGNMENT                                                        */
/* -------------------------------------------------------------------------- */

class CustomAlignmentDemo extends StatefulWidget {
  const CustomAlignmentDemo({super.key});

  @override
  State<CustomAlignmentDemo> createState() => _CustomAlignmentDemoState();
}

class _CustomAlignmentDemoState extends State<CustomAlignmentDemo> {
  double x = -1;
  double y = -1;

  void randomPosition() {
    setState(() {
      x = (x + 0.5);

      if (x > 1) {
        x = -1;
        y += 0.5;

        if (y > 1) {
          y = -1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final alignment = Alignment(x, y);

    return DemoContainer(
      child: Column(
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: alignment,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              child: const DemoBox(label: 'Custom', icon: Icons.tune),
            ),
          ),
          Text('Alignment(${x.toStringAsFixed(1)}, ${y.toStringAsFixed(1)})'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: randomPosition,
            child: const Text('Move Custom Alignment'),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 4. ANIMATED TOGGLE                                                         */
/* -------------------------------------------------------------------------- */

class AnimatedToggleDemo extends StatefulWidget {
  const AnimatedToggleDemo({super.key});

  @override
  State<AnimatedToggleDemo> createState() => _AnimatedToggleDemoState();
}

class _AnimatedToggleDemoState extends State<AnimatedToggleDemo> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 150,
            height: 70,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: enabled
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade400,
            ),
            child: AnimatedAlign(
              alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(enabled ? 'Enabled' : 'Disabled'),
          const SizedBox(height: 12),
          Switch(
            value: enabled,
            onChanged: (value) {
              setState(() {
                enabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 5. NOTIFICATION BADGE                                                      */
/* -------------------------------------------------------------------------- */

class NotificationBadgeDemo extends StatefulWidget {
  const NotificationBadgeDemo({super.key});

  @override
  State<NotificationBadgeDemo> createState() => _NotificationBadgeDemoState();
}

class _NotificationBadgeDemoState extends State<NotificationBadgeDemo> {
  bool right = true;

  @override
  Widget build(BuildContext context) {
    return DemoContainer(
      child: Column(
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: right ? Alignment.topRight : Alignment.topLeft,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications, size: 80),
                  Positioned(
                    right: -5,
                    top: -5,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '9',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                right = !right;
              });
            },
            child: const Text('Move Notification'),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 6. AVATAR TRANSITION                                                       */
/* -------------------------------------------------------------------------- */

class AvatarTransitionDemo extends StatefulWidget {
  const AvatarTransitionDemo({super.key});

  @override
  State<AvatarTransitionDemo> createState() => _AvatarTransitionDemoState();
}

class _AvatarTransitionDemoState extends State<AvatarTransitionDemo> {
  bool compact = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: AnimatedAlign(
        alignment: compact ? Alignment.topLeft : Alignment.center,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          width: compact ? 80 : 150,
          height: compact ? 80 : 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Icon(Icons.person, size: compact ? 40 : 80),
        ),
      ),
    ).withBottomButton(
      context: context,
      label: compact ? 'Expand Avatar' : 'Compact Avatar',
      onPressed: () {
        setState(() {
          compact = !compact;
        });
      },
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 7. ONBOARDING                                                              */
/* -------------------------------------------------------------------------- */

class OnboardingDemo extends StatefulWidget {
  const OnboardingDemo({super.key});

  @override
  State<OnboardingDemo> createState() => _OnboardingDemoState();
}

class _OnboardingDemoState extends State<OnboardingDemo> {
  bool started = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: started ? Alignment.topCenter : Alignment.center,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.rocket_launch,
                    size: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to the App',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              started = !started;
            });
          },
          child: Text(started ? 'Reset' : 'Start Onboarding'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 8. EMPTY STATE                                                             */
/* -------------------------------------------------------------------------- */

class EmptyStateDemo extends StatefulWidget {
  const EmptyStateDemo({super.key});

  @override
  State<EmptyStateDemo> createState() => _EmptyStateDemoState();
}

class _EmptyStateDemoState extends State<EmptyStateDemo> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: AnimatedAlign(
              alignment: showDetails ? Alignment.topCenter : Alignment.center,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox_outlined, size: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'No Items Found',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  if (showDetails) ...[
                    const SizedBox(height: 12),
                    const Text('Try changing your search filters.'),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showDetails = !showDetails;
            });
          },
          child: const Text('Toggle Empty State'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 9. CHAT BUBBLE                                                             */
/* -------------------------------------------------------------------------- */

class ChatBubbleDemo extends StatefulWidget {
  const ChatBubbleDemo({super.key});

  @override
  State<ChatBubbleDemo> createState() => _ChatBubbleDemoState();
}

class _ChatBubbleDemoState extends State<ChatBubbleDemo> {
  bool mine = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: mine
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  mine
                      ? 'This is my message.'
                      : 'This is another user message.',
                  style: TextStyle(color: mine ? Colors.white : null),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              mine = !mine;
            });
          },
          child: const Text('Switch Message Side'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 10. ACTION BUTTON                                                          */
/* -------------------------------------------------------------------------- */

class ActionButtonDemo extends StatefulWidget {
  const ActionButtonDemo({super.key});

  @override
  State<ActionButtonDemo> createState() => _ActionButtonDemoState();
}

class _ActionButtonDemoState extends State<ActionButtonDemo> {
  bool right = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: right ? Alignment.bottomRight : Alignment.bottomCenter,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              child: FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Create'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              right = !right;
            });
          },
          child: const Text('Move Action Button'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 11. ANIMATED CARD                                                          */
/* -------------------------------------------------------------------------- */

class AnimatedCardDemo extends StatefulWidget {
  const AnimatedCardDemo({super.key});

  @override
  State<AnimatedCardDemo> createState() => _AnimatedCardDemoState();
}

class _AnimatedCardDemoState extends State<AnimatedCardDemo> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: expanded ? 350 : 220,
          height: expanded ? 280 : 180,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(expanded ? 30 : 18),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: AnimatedAlign(
            alignment: expanded ? Alignment.topLeft : Alignment.center,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.dashboard, size: 50),
                const SizedBox(height: 12),
                Text(
                  expanded ? 'Expanded Dashboard Card' : 'Dashboard Card',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 12. OPACITY + ALIGN                                                        */
/* -------------------------------------------------------------------------- */

class OpacityAndAlignDemo extends StatefulWidget {
  const OpacityAndAlignDemo({super.key});

  @override
  State<OpacityAndAlignDemo> createState() => _OpacityAndAlignDemoState();
}

class _OpacityAndAlignDemoState extends State<OpacityAndAlignDemo> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: visible ? Alignment.center : Alignment.bottomCenter,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: visible ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: const DemoBox(
                  label: 'Fade + Move',
                  icon: Icons.visibility,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              visible = !visible;
            });
          },
          child: const Text('Animate'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 13. SCALE + ALIGN                                                          */
/* -------------------------------------------------------------------------- */

class ScaleAndAlignDemo extends StatefulWidget {
  const ScaleAndAlignDemo({super.key});

  @override
  State<ScaleAndAlignDemo> createState() => _ScaleAndAlignDemoState();
}

class _ScaleAndAlignDemoState extends State<ScaleAndAlignDemo> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: selected
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: AnimatedScale(
                scale: selected ? 1.25 : 1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                child: const DemoBox(label: 'Scale + Move', icon: Icons.star),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selected = !selected;
            });
          },
          child: const Text('Select'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 14. FULL COMBINATION                                                       */
/* -------------------------------------------------------------------------- */

class FullCombinationDemo extends StatefulWidget {
  const FullCombinationDemo({super.key});

  @override
  State<FullCombinationDemo> createState() => _FullCombinationDemoState();
}

class _FullCombinationDemoState extends State<FullCombinationDemo> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: active ? Alignment.topRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              child: AnimatedScale(
                scale: active ? 1.15 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                child: AnimatedOpacity(
                  opacity: active ? 1 : 0.65,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    width: active ? 180 : 120,
                    height: active ? 180 : 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(active ? 30 : 60),
                      color: active
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: active ? 25 : 8,
                          spreadRadius: active ? 5 : 0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'AnimatedAlign + AnimatedContainer + '
          'AnimatedOpacity + AnimatedScale',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            setState(() {
              active = !active;
            });
          },
          child: const Text('Run Combination'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 15. DIRECTIONAL ALIGNMENT                                                   */
/* -------------------------------------------------------------------------- */

class DirectionalAlignmentDemo extends StatefulWidget {
  const DirectionalAlignmentDemo({super.key});

  @override
  State<DirectionalAlignmentDemo> createState() =>
      _DirectionalAlignmentDemoState();
}

class _DirectionalAlignmentDemoState extends State<DirectionalAlignmentDemo> {
  bool end = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: end
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: const DemoBox(label: 'Directional', icon: Icons.language),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Start / End automatically respects text direction.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            setState(() {
              end = !end;
            });
          },
          child: const Text('Switch Start / End'),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 16. WIDTH / HEIGHT FACTOR                                                  */
/* -------------------------------------------------------------------------- */

class FactorDemo extends StatefulWidget {
  const FactorDemo({super.key});

  @override
  State<FactorDemo> createState() => _FactorDemoState();
}

class _FactorDemoState extends State<FactorDemo> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedAlign(
            alignment: expanded ? Alignment.centerRight : Alignment.centerLeft,
            widthFactor: expanded ? 1 : 0.5,
            heightFactor: expanded ? 1 : 0.7,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: const Text(
                'Width / Height Factor',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: const Text('Animate Factors'),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* 17. CURVE PLAYGROUND                                                       */
/* -------------------------------------------------------------------------- */

class CurvePlaygroundDemo extends StatefulWidget {
  const CurvePlaygroundDemo({super.key});

  @override
  State<CurvePlaygroundDemo> createState() => _CurvePlaygroundDemoState();
}

class _CurvePlaygroundDemoState extends State<CurvePlaygroundDemo> {
  final List<Map<String, dynamic>> curves = [
    {'name': 'Linear', 'curve': Curves.linear},
    {'name': 'Ease In', 'curve': Curves.easeIn},
    {'name': 'Ease Out', 'curve': Curves.easeOut},
    {'name': 'Ease In Out', 'curve': Curves.easeInOut},
    {'name': 'Ease Out Cubic', 'curve': Curves.easeOutCubic},
    {'name': 'Ease Out Back', 'curve': Curves.easeOutBack},
  ];

  int curveIndex = 0;
  bool right = false;

  @override
  Widget build(BuildContext context) {
    final currentCurve = curves[curveIndex];

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: AnimatedAlign(
              alignment: right ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 800),
              curve: currentCurve['curve'] as Curve,
              child: DemoBox(
                label: currentCurve['name'] as String,
                icon: Icons.speed,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Curve: ${currentCurve['name']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  right = !right;
                });
              },
              child: const Text('Animate'),
            ),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  curveIndex = (curveIndex + 1) % curves.length;
                });
              },
              child: const Text('Next Curve'),
            ),
          ],
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/* SHARED COMPONENTS                                                          */
/* -------------------------------------------------------------------------- */

class DemoContainer extends StatelessWidget {
  final Widget child;

  const DemoContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: child,
    );
  }
}

class DemoBox extends StatelessWidget {
  final String label;
  final IconData icon;

  const DemoBox({super.key, required this.label, this.icon = Icons.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.primary,
        boxShadow: const [BoxShadow(blurRadius: 15, spreadRadius: 2)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* SMALL HELPER                                                               */
/* -------------------------------------------------------------------------- */

extension BottomButton on Widget {
  Widget withBottomButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Expanded(child: this),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onPressed, child: Text(label)),
      ],
    );
  }
}

///////////////////////////////////
///
///
class DemoDrawer extends StatelessWidget {
  final List<String> demoNames;
  final int selectedDemo;
  final ValueChanged<int> onDemoSelected;

  const DemoDrawer({
    super.key,
    required this.demoNames,
    required this.selectedDemo,
    required this.onDemoSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.animation, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'AnimatedAlign Demos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: demoNames.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedDemo == index;

                  return ListTile(
                    selected: isSelected,
                    leading: const Icon(Icons.animation),
                    title: Text(demoNames[index]),
                    onTap: () {
                      onDemoSelected(index);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
