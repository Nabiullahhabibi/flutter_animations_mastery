import 'package:flutter/material.dart';


class PageRouteBuilderDemoApp extends StatelessWidget {
  const PageRouteBuilderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PageRouteBuilder Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageRouteBuilder Demo'),
      ),
      body: Center(
        child: FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              _createCustomRoute(),
            );
          },
          icon: const Icon(Icons.animation),
          label: const Text('Open Animated Page'),
        ),
      ),
    );
  }

  // ==========================================================
  // CUSTOM PAGE ROUTE
  // ==========================================================

  PageRouteBuilder<void> _createCustomRoute() {
    return PageRouteBuilder<void>(
      // --------------------------------------------------------
      // How long the forward animation takes.
      // --------------------------------------------------------

      transitionDuration: const Duration(
        milliseconds: 600,
      ),

      // --------------------------------------------------------
      // How long the reverse animation takes.
      // --------------------------------------------------------

      reverseTransitionDuration: const Duration(
        milliseconds: 400,
      ),

      // --------------------------------------------------------
      // Creates the actual page.
      // --------------------------------------------------------

      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        return const DetailsScreen();
      },

      // --------------------------------------------------------
      // Creates the custom transition.
      // --------------------------------------------------------

      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        // ------------------------------------------------------
        // Curve
        // ------------------------------------------------------

        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        // ------------------------------------------------------
        // Slide animation
        //
        // The page starts from the right:
        //
        // Offset(1, 0)
        //
        // and finishes at:
        //
        // Offset.zero
        // ------------------------------------------------------

        final slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(curvedAnimation);

        // ------------------------------------------------------
        // Fade animation
        //
        // 0.0 = invisible
        // 1.0 = completely visible
        // ------------------------------------------------------

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(curvedAnimation);

        // ------------------------------------------------------
        // Scale animation
        //
        // The page starts slightly smaller and grows to normal.
        // ------------------------------------------------------

        final scaleAnimation = Tween<double>(
          begin: 0.92,
          end: 1.0,
        ).animate(curvedAnimation);

        // ------------------------------------------------------
        // Combine:
        //
        // Fade
        //   +
        // Slide
        //   +
        // Scale
        // ------------------------------------------------------

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// DETAILS SCREEN
// ============================================================

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 90,
            ),

            const SizedBox(height: 24),

            const Text(
              'Custom Page Transition',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Fade + Slide + Scale',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 32),

            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}