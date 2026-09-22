import 'package:flutter/material.dart';
import 'package:flutter_animations/flutter_animations_mastery/animation_test.dart';
import 'package:flutter_animations/screens/2-lamp_on_off_animaiton/lamp_on_off_screen.dart';
import 'package:flutter_animations/screens/4-3d_album_screen/3d_album_screen.dart';
import 'package:flutter_animations/screens/5-neon_square_screen/neon_square_screen.dart';
import 'package:flutter_animations/screens/6-cyberpunk_neon_ui_screen/cyberpunk_neon_ui_screen.dart';
import 'package:flutter_animations/screens/7-ai_face_scanner/ai_face_scanner.dart';
import 'package:flutter_animations/screens/8-butterfly_animation_screen/butterfly_animation_screen.dart';

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
      home: ButterflyGardenScreen(),
    );
  }
}
