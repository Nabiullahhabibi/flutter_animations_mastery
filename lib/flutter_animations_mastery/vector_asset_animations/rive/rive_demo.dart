// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';

// class RiveDemoApp extends StatelessWidget {
//   const RiveDemoApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Rive Animation Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//         ),
//         useMaterial3: true,
//       ),
//       home: const RiveDemoScreen(),
//     );
//   }
// }

// class RiveDemoScreen extends StatefulWidget {
//   const RiveDemoScreen({super.key});

//   @override
//   State<RiveDemoScreen> createState() => _RiveDemoScreenState();
// }

// class _RiveDemoScreenState extends State<RiveDemoScreen> {
//   bool _isPlaying = true;
//   double _speed = 1.0;

//   void _togglePlayback() {
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//   }

//   void _setSpeed(double value) {
//     setState(() {
//       _speed = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rive Animation'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               const Text(
//                 'Rive Animation Demo',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               const Text(
//                 'Interactive vector animation using Rive',
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 30),

//               // Rive animation
//               Container(
//                 width: double.infinity,
//                 height: 350,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: Colors.grey.shade300,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: RiveAnimation.asset(
//                     'assets/rive/animation.riv',
//                     fit: Fit.contain,
//                     placeHolder: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                     // Change this to the actual state machine
//                     // name inside your .riv file if needed.
//                     stateMachines: const [
//                       'State Machine 1',
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Playback control
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Playback',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       SizedBox(
//                         width: double.infinity,
//                         child: FilledButton.icon(
//                           onPressed: _togglePlayback,
//                           icon: Icon(
//                             _isPlaying
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                           ),
//                           label: Text(
//                             _isPlaying
//                                 ? 'Pause'
//                                 : 'Play',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Speed control
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Animation Speed: '
//                         '${_speed.toStringAsFixed(1)}x',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 5),

//                       Slider(
//                         value: _speed,
//                         min: 0.25,
//                         max: 2.0,
//                         divisions: 7,
//                         label:
//                             '${_speed.toStringAsFixed(2)}x',
//                         onChanged: _setSpeed,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Information
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'What this demo demonstrates',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       _InfoRow(
//                         title: 'RiveAnimation.asset',
//                         description:
//                             'Loads a .riv animation from Flutter assets.',
//                       ),

//                       _InfoRow(
//                         title: 'State Machine',
//                         description:
//                             'Allows an interactive Rive animation '
//                             'to respond to inputs and state changes.',
//                       ),

//                       _InfoRow(
//                         title: 'Vector graphics',
//                         description:
//                             'Rive animations are based on vector '
//                             'graphics and are rendered at runtime.',
//                       ),

//                       _InfoRow(
//                         title: 'Interactive animation',
//                         description:
//                             'Rive is designed for animations that '
//                             'can react to application interaction.',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Senior-level notes
//               Card(
//                 color: Theme.of(context)
//                     .colorScheme
//                     .surfaceContainerHighest,
//                 child: const Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Senior-Level Note',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       SizedBox(height: 10),

//                       Text(
//                         'Rive becomes especially powerful when '
//                         'you connect its state machine inputs to '
//                         'your application state. For example, a '
//                         'button, login state, loading state, or '
//                         'gesture can control the animation.',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final String title;
//   final String description;

//   const _InfoRow({
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(
//             Icons.check_circle_outline,
//             size: 20,
//           ),

//           const SizedBox(width: 10),

//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 style: DefaultTextStyle.of(context).style,
//                 children: [
//                   TextSpan(
//                     text: '$title: ',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextSpan(
//                     text: description,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveDemoApp extends StatelessWidget {
  const RiveDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rive Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RiveDemoScreen(),
    );
  }
}

class RiveDemoScreen extends StatefulWidget {
  const RiveDemoScreen({super.key});

  @override
  State<RiveDemoScreen> createState() => _RiveDemoScreenState();
}

class _RiveDemoScreenState extends State<RiveDemoScreen> {
  RiveWidgetController? _controller;

  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();

    _loadRive();
  }

  Future<void> _loadRive() async {
    try {
      final file = await File.asset(
        'assets/rive/animation.riv',
        riveFactory: Factory.rive,
      );

      if (!mounted) {
        file?.dispose();
        return;
      }

      if (file == null) {
        setState(() {
          _isLoading = false;
          _error = 'Could not load the Rive file.';
        });

        return;
      }

      final controller = RiveWidgetController(file);

      setState(() {
        _controller = controller;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _error = error.toString();
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive Animation'), centerTitle: true),
      body: Center(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }

    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Error loading Rive animation:\n\n$_error',
          textAlign: TextAlign.center,
        ),
      );
    }

    final controller = _controller;

    if (controller == null) {
      return const Text('Rive controller was not created.');
    }

    return SizedBox(
      width: double.infinity,
      height: 400,
      child: RiveWidget(controller: controller, fit: Fit.contain),
    );
  }
}
