import 'package:flutter/material.dart';

/// Flutter Animation — 01
///
/// Demonstrates:
/// - Animation fundamentals
/// - Duration
/// - Curves
/// - Implicit animation
/// - AnimatedContainer
///
/// Copy this file into your Flutter project and use:
///
///   home: const AnimatedContainerDemo(),
///
/// No external packages are required.

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  bool isExpanded = false;

  void _toggleAnimation() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('01 — AnimatedContainer')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,

                // Size
                width: isExpanded ? 300 : 140,
                height: isExpanded ? 220 : 140,

                // Internal spacing
                padding: EdgeInsets.all(isExpanded ? 32 : 16),

                // Position of the child inside the container
                alignment: isExpanded
                    ? Alignment.bottomCenter
                    : Alignment.center,

                // Decoration
                decoration: BoxDecoration(
                  color: isExpanded ? Colors.blue : Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(isExpanded ? 32 : 12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: isExpanded ? 24 : 8,
                      spreadRadius: isExpanded ? 4 : 0,
                    ),
                  ],
                ),

                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isExpanded ? 28 : 20,
                    fontWeight: isExpanded
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  child: Text(
                    isExpanded ? 'Expanded' : 'Tap the button',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                isExpanded ? 'New state: expanded' : 'Current state: normal',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 16),

              FilledButton.icon(
                onPressed: _toggleAnimation,
                icon: Icon(isExpanded ? Icons.close : Icons.open_in_full),
                label: Text(isExpanded ? 'Collapse' : 'Expand'),
              ),

              const SizedBox(height: 32),

              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is happening?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'AnimatedContainer automatically '
                        'interpolates supported properties '
                        'between the old and new values.',
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Try changing the duration and curve '
                        'in the source code.',
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
