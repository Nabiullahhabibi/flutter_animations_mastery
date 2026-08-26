import 'package:flutter/material.dart';

class PageRouteDemoApp extends StatelessWidget {
  const PageRouteDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PageRoute Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
      appBar: AppBar(title: const Text('PageRoute Animation')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () async {
            // Push a new route onto the Navigator stack.
            final result = await Navigator.push<String>(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const DetailsScreen();
                },
              ),
            );

            // The result returned from DetailsScreen.
            if (result == null || !context.mounted) {
              return;
            }

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(result)));
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Open Details Screen'),
        ),
      ),
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
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.animation, size: 80),

            const SizedBox(height: 24),

            const Text(
              'PageRoute Demo',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const Text(
              'This screen was opened using\nMaterialPageRoute.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            FilledButton(
              onPressed: () {
                // Remove this route from the Navigator stack.
                Navigator.pop(context, 'Returned from Details Screen');
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
