import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations_mastery/animation_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureCore Codex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          secondary: const Color(0xFFFF6584),
        ),
        useMaterial3: true,
      ),
      // home: HomeScreen(),
      home: AnimationTest(),
    );
  }
}
