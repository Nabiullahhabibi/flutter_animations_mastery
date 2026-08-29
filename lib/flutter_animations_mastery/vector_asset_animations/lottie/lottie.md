# Lottie Animation in Flutter

## 1. Introduction

Lottie is a popular animation format that allows designers to export animations as JSON files and developers to play those animations inside applications.

Instead of manually creating every animation with Flutter widgets, you can use a pre-designed Lottie animation.

Lottie is especially useful for:

* Loading animations
* Success animations
* Error animations
* Onboarding animations
* Empty states
* Animated icons
* Illustrations
* Micro-interactions
* Celebration animations
* Animated UI feedback

---

# 2. How Lottie Works

The typical workflow is:

```text
Designer
   ↓
After Effects / Lottie-compatible tool
   ↓
Lottie animation
   ↓
JSON file
   ↓
Flutter
   ↓
Lottie widget
```

The JSON file contains information describing the animation.

Flutter reads that information and renders the animation.

So instead of storing thousands of image frames, Lottie generally stores animation/vector information.

---

# 3. Why Use Lottie?

Without Lottie, you might need to manually create an animation using:

* AnimationController
* Tween
* Curves
* AnimatedBuilder
* CustomPainter
* Multiple Flutter widgets

With Lottie, a designer can create a complex animation and provide the exported animation file to the developer.

The developer can then integrate it into Flutter.

---

# 4. Installing Lottie

Add the Lottie package to `pubspec.yaml`.

```yaml
dependencies:
  flutter:
    sdk: flutter

  lottie: ^3.3.1
```

Then run:

```bash
flutter pub get
```

---

# 5. Adding a Lottie Asset

Create an animation directory:

```text
assets/
└── animations/
    └── loading.json
```

Then register it in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/animations/loading.json
```

You can also register the whole directory:

```yaml
flutter:
  assets:
    - assets/animations/
```

---

# 6. Basic Lottie Usage

The simplest approach is:

```dart
Lottie.asset(
  'assets/animations/loading.json',
)
```

Flutter loads the JSON animation and plays it.

---

# 7. Loading Lottie From a Network

Lottie can also be loaded from a URL:

```dart
Lottie.network(
  'https://example.com/animation.json',
)
```

This is useful when animations are provided dynamically by a server.

However, remote animations introduce additional considerations:

* Network availability
* Loading time
* Caching
* Error handling
* Security
* Version compatibility

For important UI animations, bundled assets are often more predictable.

---

# 8. Lottie From Memory

Lottie can also work with animation data already loaded into memory.

The exact API depends on how the data is obtained and which Lottie package version is being used.

This approach can be useful when:

* Animation data comes from an API
* Animation files are downloaded dynamically
* You already have the JSON content in memory

---

# 9. Controlling Lottie With AnimationController

For simple playback, you do not need an `AnimationController`.

But when you need advanced control, you can provide your own controller:

```dart
late final AnimationController _controller;

_controller = AnimationController(
  vsync: this,
);
```

Then:

```dart
Lottie.asset(
  'assets/animations/loading.json',
  controller: _controller,
)
```

The important idea is:

```text
Lottie
   ↓
AnimationController
   ↓
Playback control
```

---

# 10. Understanding `onLoaded`

When Lottie loads the animation, you can access its composition:

```dart
onLoaded: (composition) {
  _controller.duration = composition.duration;
}
```

The composition contains information about the animation.

One important piece of information is its duration.

This is especially useful when you are using your own `AnimationController`.

---

# 11. Playing the Animation

You can start the animation using:

```dart
_controller.forward(from: 0);
```

This means:

```text
Start
  ↓
0%
  ↓
...
  ↓
100%
```

---

# 12. Pausing the Animation

You can stop the controller:

```dart
_controller.stop();
```

The animation stays at its current position.

This is useful when implementing:

* Pause buttons
* Interactive animations
* User-controlled animations
* Gesture-driven controls

---

# 13. Repeating the Animation

Use:

```dart
_controller.repeat();
```

This continuously repeats the animation.

Conceptually:

```text
0% → 100%
      ↓
0% → 100%
      ↓
0% → 100%
      ↓
...
```

This is useful for:

* Loading indicators
* Background animations
* Progress animations
* Decorative animations

---

# 14. Reverse Playback

You can play the animation backwards:

```dart
_controller.reverse();
```

Conceptually:

```text
100% → 0%
```

Reverse playback can be useful for:

* Closing animations
* Dismiss animations
* Toggle interactions
* Interactive UI

---

# 15. Animation Progress

The controller's value represents progress:

```dart
_controller.value
```

The value normally ranges from:

```text
0.0 → 1.0
```

For example:

```text
0.0 = beginning
0.5 = middle
1.0 = end
```

You can manually control it:

```dart
_controller.value = 0.5;
```

This jumps the animation to approximately 50%.

---

# 16. Manual Scrubbing

One powerful technique is allowing the user to control animation progress.

For example:

```dart
Slider(
  value: _controller.value,
  min: 0,
  max: 1,
  onChanged: (value) {
    _controller.value = value;
  },
)
```

Now the user can drag the slider and scrub through the animation.

This technique can be useful for:

* Interactive tutorials
* Animation previews
* Timeline controls
* Gesture-driven experiences

---

# 17. Lottie and Flutter's AnimationController

An important senior-level concept is understanding that Lottie does not replace Flutter's animation system.

Instead:

```text
Lottie
   +
AnimationController
   =
Advanced animation control
```

You can combine Lottie with Flutter's animation APIs.

For example:

```dart
AnimationController
        ↓
Animation progress
        ↓
Lottie animation
```

This allows you to build more interactive experiences.

---

# 18. Lottie vs Flutter Implicit Animations

Flutter implicit animations are useful when you want to animate widget properties.

For example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  width: 200,
)
```

Lottie is different.

Lottie is better when the animation itself has already been designed.

### Implicit animation

```text
Flutter Widget
      ↓
Property changes
      ↓
Flutter animates it
```

### Lottie

```text
Designer-created animation
      ↓
JSON
      ↓
Flutter renders it
```

---

# 19. Lottie vs Explicit Animations

Explicit Flutter animation:

```text
AnimationController
Tween
Curve
AnimatedBuilder
Widget
```

Lottie:

```text
Animation JSON
     ↓
Lottie widget
     ↓
Rendered animation
```

Use explicit Flutter animations when you need precise control over Flutter widgets.

Use Lottie when you have a complex pre-designed animation.

---

# 20. Lottie vs Rive

Lottie and Rive are both popular animation technologies, but their strengths are different.

### Lottie

Best for:

* Pre-designed animations
* Illustrations
* Loading animations
* Success/error animations
* Decorative motion
* Designer-to-developer workflows

### Rive

Best for:

* Interactive animations
* State machines
* Character animation
* Complex user interaction
* Animation states
* Runtime interaction

A simple mental model:

```text
Lottie = Play a designed animation

Rive = Build an interactive animation system
```

---

# 21. Common Lottie Use Cases

## Loading

```text
Loading...
   ↓
Lottie animation
```

## Success

```text
Payment completed
       ↓
Success animation
```

## Error

```text
Something went wrong
       ↓
Error animation
```

## Empty State

```text
No data
  ↓
Animated illustration
```

## Onboarding

```text
Page 1
  ↓
Animation
  ↓
Page 2
```

---

# 22. Performance Considerations

Lottie is convenient, but it does not mean every animation is automatically cheap.

Complex animations can consume CPU/GPU resources.

Be careful with:

* Very complex compositions
* Large JSON files
* Many simultaneous Lottie animations
* Heavy effects
* Large animations on low-end devices
* Animations that run continuously without a reason

Avoid doing this unnecessarily:

```text
10 complex Lottie animations
       +
Continuous looping
       +
Large screen
```

---

# 23. Asset Size

Lottie JSON files can be relatively small compared with traditional frame-by-frame animation, but size still matters.

Before adding an animation to a production application, check:

* JSON size
* Complexity
* Number of layers
* Effects
* Image assets
* Rendering performance

---

# 24. Do Not Use Lottie for Everything

Lottie is not the answer to every animation problem.

For example, if you simply need:

```text
Opacity: 0 → 1
```

using:

```dart
AnimatedOpacity
```

is usually much simpler.

If you need:

```text
Container width:
100 → 300
```

use:

```dart
AnimatedContainer
```

If you need a complex designer-created illustration:

```text
Lottie
```

may be a better choice.

---

# 25. Lottie With State Management

Lottie can work with state management solutions such as:

* Provider
* Riverpod
* Bloc
* Cubit
* GetX

For example:

```text
API request
    ↓
Loading state
    ↓
Show Lottie loading animation
    ↓
Request completes
    ↓
Hide Lottie
```

The state management system controls the application state.

Lottie handles the visual animation.

Keep these responsibilities separate.

---

# 26. Lottie With API States

A common production pattern is:

```text
Initial
   ↓
Loading
   ↓
Success
```

or:

```text
Initial
   ↓
Loading
   ↓
Error
```

You can use different Lottie animations for each state:

```text
Loading → loading.json

Success → success.json

Error → error.json
```

This is a good example of using animation as part of UX rather than simply adding decoration.

---

# 27. Lottie and Navigation

Lottie can also be used during navigation.

For example:

```text
Screen A
   ↓
Transition
   ↓
Screen B
```

However, if you need true page transitions, Flutter's:

* PageRoute
* PageRouteBuilder
* Hero
* FadeTransition
* SlideTransition

may be more appropriate.

Lottie should not replace Flutter's navigation transition system unless the design specifically calls for a Lottie-based transition.

---

# 28. Lottie and Accessibility

Animations should not negatively affect users.

Consider:

* Motion sensitivity
* Reduced-motion preferences
* Excessive looping
* Animations that distract from content

A production application should consider whether an animation is essential or purely decorative.

---

# 29. Common Mistakes

## Mistake 1: Using Lottie for simple animations

Do not use a complex Lottie file when:

```text
AnimatedOpacity
```

would solve the problem.

---

## Mistake 2: Too Many Animations

Avoid placing many continuously looping animations on one screen.

---

## Mistake 3: Ignoring Animation Complexity

A small-looking animation can still contain many layers and effects.

Always test on real devices.

---

## Mistake 4: Forgetting Controller Disposal

If you create an `AnimationController`, dispose of it:

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

## Mistake 5: Confusing Lottie With Rive

Remember:

```text
Lottie → animation playback

Rive → interactive animation systems
```

This is not an absolute rule, but it is a useful mental model.

---

# 30. Senior-Level Architecture

In a production Flutter project, avoid scattering raw asset paths everywhere.

Instead of:

```dart
Lottie.asset(
  'assets/animations/loading.json',
)
```

throughout the entire project, centralize asset paths.

For example:

```dart
class AppAnimations {
  static const loading =
      'assets/animations/loading.json';

  static const success =
      'assets/animations/success.json';

  static const error =
      'assets/animations/error.json';
}
```

Then:

```dart
Lottie.asset(
  AppAnimations.loading,
)
```

This makes the project easier to maintain.

---

# 31. Recommended Project Structure

A larger project could use:

```text
lib/
├── core/
│   └── constants/
│       └── app_animations.dart
│
├── features/
│   ├── authentication/
│   ├── payments/
│   └── onboarding/
│
assets/
└── animations/
    ├── loading.json
    ├── success.json
    ├── error.json
    └── onboarding.json
```

This keeps animation assets organized.

---

# 32. Lottie Best Practices

Use Lottie when:

* The animation is complex.
* The animation is designed externally.
* You need an illustration with motion.
* You need a loading/success/error animation.
* The animation will be reused.
* The design team provides Lottie assets.

Prefer Flutter's built-in animation system when:

* You are animating widget properties.
* The animation is simple.
* You need tight integration with layout.
* You need very precise control over Flutter widgets.
* A Lottie file would add unnecessary complexity.

---

# 33. Mental Model

Remember Lottie like this:

```text
             LOTTIE
                │
                ▼
        Designer-created
          animation
                │
                ▼
             JSON
                │
                ▼
        Lottie Flutter
                │
                ▼
       Flutter renders it
                │
                ▼
      AnimationController
       (when control is
          required)
```

---

# 34. What You Should Know as a Senior Flutter Developer

You do not need to memorize every Lottie API.

You should understand:

1. What Lottie is.
2. Why Lottie exists.
3. How Lottie differs from Flutter animations.
4. How to add Lottie assets.
5. How to display a Lottie animation.
6. How to load animations from assets.
7. How to load animations remotely when appropriate.
8. How to use `AnimationController`.
9. How to control playback.
10. How to repeat animations.
11. How to reverse animations.
12. How to control animation progress.
13. How to integrate Lottie with application state.
14. How to evaluate animation complexity.
15. How to consider performance.
16. When to use Lottie.
17. When not to use Lottie.
18. How Lottie differs from Rive.

The key idea is:

> **Lottie is primarily a way to bring designer-created, complex animations into Flutter, while Flutter's own animation system gives you direct control over widget behavior and Rive is particularly strong for interactive animation systems.**

---

# 35. Final Summary

```text
Lottie
│
├── JSON animation
├── Designer-created
├── Vector-based
├── Easy integration
├── Complex visual animations
├── Loading states
├── Success states
├── Error states
├── Onboarding
│
└── Advanced control
    └── AnimationController
```

For a senior Flutter developer, the important skill is not simply knowing:

```dart
Lottie.asset(...)
```

The important skill is knowing **when Lottie is the right tool, how to control it, how it fits into Flutter's animation architecture, and how to keep its performance and maintainability under control.**
