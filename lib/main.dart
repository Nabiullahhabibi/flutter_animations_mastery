import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/11-ink-drop-navigation/ink_drop_navigation_screen.dart';
import 'package:flutter_animations/screens/12-wave-hand/wave_hand_screen.dart';
import 'package:flutter_animations/screens/13-emoji-bounce-wheel/emoji_bounce_wheel_screen.dart';
import 'package:flutter_animations/screens/14-flip-card/flip_card_screen.dart';
import 'package:flutter_animations/screens/15-page-flip/page_flip_screen.dart';
import 'package:flutter_animations/screens/16-liquid-glass/liquid_glass_screen.dart';
import 'package:flutter_animations/screens/17-origami-fold-ui/origami_fold_ui_screen.dart';
import 'package:flutter_animations/screens/18-slide-to-confirm-action-bar/slide_to_confirm_action_bar_screen.dart';
import 'package:flutter_animations/screens/19-fluid-progress-bar/fluid_progress_bar_screen.dart';
import 'package:flutter_animations/screens/20-story-style-stepper/story_style_stepper_screen.dart';
import 'package:flutter_animations/screens/22-pin-drop-animation/pin_drop_animation_screen.dart';
import 'package:flutter_animations/screens/23-scroll-animation/scroll_animation_screen.dart';
import 'package:flutter_animations/screens/24-elevator-style-text-reveal/elevator_style_text_reveal.dart';
import 'package:flutter_animations/screens/25-floating-emojis/floating_emojis_screen.dart';
import 'package:flutter_animations/screens/26-emoji-explosion/emoji_explosion_screen.dart';
import 'package:flutter_animations/screens/27-emotional-emoji/emotional_emoji_screen.dart';
import 'package:flutter_animations/screens/28-unlock-card-animation/unlock_card_animation_screen.dart';
import 'package:flutter_animations/screens/29-pulse-absorb-animation/pulse_absorb_animation_screen.dart';
import 'package:flutter_animations/screens/30-ink-magnet-login-animation/ink_magnet_login_animation_screen.dart';
import 'package:flutter_animations/screens/31-letter-growing-animation/letter_growing_animation_screen.dart';

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
      home: LetterGrowingAnimationScreen(),
    );
  }
}
