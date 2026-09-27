import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/11-ink-drop-navigation/ink_drop_navigation_screen.dart';
import 'package:flutter_animations/screens/12-wave-hand/wave_hand_screen.dart';
import 'package:flutter_animations/screens/13-emoji-bounce-wheel/emoji_bounce_wheel_screen.dart';

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
      home: InkDropNavigationScreen(),
    );
  }
}
