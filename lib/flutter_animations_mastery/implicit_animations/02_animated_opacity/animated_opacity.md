# AnimatedOpacity — Implicit Animation

## Overview

`AnimatedOpacity` is one of Flutter's built-in **implicit animation widgets**.

It automatically animates changes to a widget's opacity when the `opacity` value changes.

Instead of manually creating:

* `AnimationController`
* `Tween`
* `Animation`
* `Ticker`
* `setState()` for every animation frame

you simply provide a new opacity value and a duration.

Flutter handles the transition automatically.

---

# 1. What is Opacity?

Opacity describes how transparent or visible a widget is.

The `opacity` value is a `double` between:

```dart
0.0
```

and:

```dart
1.0
```

The meaning is:

|  Value | Meaning                |
| -----: | ---------------------- |
|  `0.0` | Completely transparent |
| `0.25` | 25% visible            |
|  `0.5` | 50% visible            |
| `0.75` | 75% visible            |
|  `1.0` | Completely visible     |

Example:

```dart
AnimatedOpacity(
  opacity: 1.0,
  duration: Duration(milliseconds: 500),
  child: Text('Hello'),
)
```

The widget is completely visible.

If the opacity changes to:

```dart
opacity: 0.0
```

Flutter animates the widget from visible to invisible.

---

# 2. What is AnimatedOpacity?

`AnimatedOpacity` is an implicit animation widget that automatically animates changes to the `opacity` property.

Basic structure:

```dart
AnimatedOpacity(
  opacity: opacity,
  duration: const Duration(milliseconds: 500),
  child: const Text('Hello'),
)
```

When:

```dart
opacity
```

changes, Flutter automatically starts an animation.

For example:

```dart
opacity: 1.0
```

changes to:

```dart
opacity: 0.0
```

Flutter internally interpolates values approximately like:

```text
1.0
0.9
0.8
0.7
0.6
0.5
0.4
0.3
0.2
0.1
0.0
```

The actual number of frames depends on the device's refresh rate and animation duration.

---

# 3. Why is AnimatedOpacity an Implicit Animation?

Flutter animations can broadly be divided into:

```text
Animations
│
├── Implicit Animations
│   ├── AnimatedContainer
│   ├── AnimatedOpacity
│   ├── AnimatedPadding
│   ├── AnimatedAlign
│   ├── AnimatedPositioned
│   └── ...
│
└── Explicit Animations
    ├── AnimationController
    ├── Tween
    ├── Curves
    └── Animation
```

With an implicit animation, you describe the **new state**.

Flutter handles the transition.

For example:

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  child: widget,
)
```

You don't tell Flutter:

```text
start animation
go from 1.0
to 0.0
update every frame
stop animation
```

Instead, you simply tell Flutter:

```text
The desired opacity is now 0.0.
```

Flutter handles the animation.

---

# 4. AnimatedOpacity API

The simplified structure is:

```dart
AnimatedOpacity({
  Key? key,
  required double opacity,
  required Duration duration,
  Curve curve = Curves.linear,
  VoidCallback? onEnd,
  HitTestBehavior behavior = HitTestBehavior.deferToChild,
  required Widget child,
})
```

The most important properties are:

```text
opacity
duration
curve
onEnd
child
```

---

# 5. opacity

The `opacity` property determines the target opacity.

Type:

```dart
double
```

Valid range:

```dart
0.0 <= opacity <= 1.0
```

Example:

```dart
AnimatedOpacity(
  opacity: 0.5,
  duration: const Duration(milliseconds: 500),
  child: const FlutterLogo(),
)
```

The widget becomes 50% visible.

---

# 6. duration

`duration` determines how long the transition takes.

Example:

```dart
duration: const Duration(milliseconds: 500)
```

This means the animation takes approximately:

```text
500 milliseconds
=
0.5 seconds
```

Example:

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 800),
  child: const FlutterLogo(),
)
```

Longer duration:

```dart
Duration(seconds: 2)
```

produces a slower transition.

Shorter duration:

```dart
Duration(milliseconds: 150)
```

produces a faster transition.

---

# 7. curve

The `curve` determines how the opacity changes over time.

Without a curve:

```dart
curve: Curves.linear
```

the value changes at a constant rate.

Example:

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  child: const FlutterLogo(),
)
```

Common curves include:

```dart
Curves.linear
Curves.easeIn
Curves.easeOut
Curves.easeInOut
Curves.fastOutSlowIn
Curves.decelerate
Curves.bounceIn
Curves.bounceOut
Curves.elasticOut
```

For UI opacity transitions, common choices are:

```dart
Curves.easeInOut
```

or:

```dart
Curves.easeOut
```

---

# 8. Understanding Curves

Suppose the animation goes from:

```text
0.0 → 1.0
```

with:

```dart
Curves.linear
```

the progression is approximately:

```text
Time:     0%  25%  50%  75%  100%
Opacity:  0   .25  .50  .75  1.0
```

With:

```dart
Curves.easeOut
```

the animation changes quickly at the beginning and slows down near the end.

Conceptually:

```text
0.0
 |
 |████████
 |       ███
 |          ██
 |            █
 |             █
 +----------------
              1.0
```

This often feels more natural for UI elements appearing on screen.

---

# 9. onEnd

`onEnd` is called when the implicit animation finishes.

Example:

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  onEnd: () {
    debugPrint('Animation finished');
  },
  child: const FlutterLogo(),
)
```

This can be useful when another action should happen after the animation.

For example:

```dart
onEnd: () {
  debugPrint('Fade completed');
}
```

---

# 10. child

`child` is the widget whose opacity is animated.

Example:

```dart
AnimatedOpacity(
  opacity: opacity,
  duration: const Duration(milliseconds: 500),
  child: Container(
    width: 200,
    height: 200,
  ),
)
```

A useful optimization is to keep the animated child separate when possible.

Example:

```dart
AnimatedOpacity(
  opacity: opacity,
  duration: const Duration(milliseconds: 500),
  child: const ExpensiveWidget(),
)
```

The opacity animation itself doesn't require rebuilding the child every frame.

This is one reason Flutter's implicit animation widgets are convenient for UI development.

---

# 11. Basic Example

```dart
class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  double opacity = 1.0;

  void toggleOpacity() {
    setState(() {
      opacity = opacity == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 500),
          child: const FlutterLogo(
            size: 150,
          ),
        ),
        ElevatedButton(
          onPressed: toggleOpacity,
          child: const Text('Toggle'),
        ),
      ],
    );
  }
}
```

When the button is pressed:

```text
1.0 → 0.0
```

or:

```text
0.0 → 1.0
```

is animated automatically.

---

# 12. AnimatedOpacity vs Opacity

Flutter provides both:

```dart
Opacity
```

and:

```dart
AnimatedOpacity
```

They are not the same.

## Opacity

`Opacity` applies an opacity value immediately.

```dart
Opacity(
  opacity: 0.5,
  child: widget,
)
```

Changing the value does not automatically create a transition.

---

## AnimatedOpacity

`AnimatedOpacity` automatically animates between old and new values.

```dart
AnimatedOpacity(
  opacity: 0.5,
  duration: const Duration(milliseconds: 500),
  child: widget,
)
```

So:

```text
Opacity
    ↓
Immediate change

AnimatedOpacity
    ↓
Animated transition
```

---

# 13. AnimatedOpacity vs AnimatedContainer

Both are implicit animations.

`AnimatedContainer` is designed to animate multiple visual/layout properties.

For example:

```dart
width
height
padding
margin
color
alignment
borderRadius
boxShadow
transform
```

`AnimatedOpacity` focuses specifically on:

```dart
opacity
```

Use:

```text
AnimatedOpacity
```

when the main requirement is fading.

Use:

```text
AnimatedContainer
```

when several container properties need to transition.

---

# 14. Fade In

A common use case is a fade-in effect.

Start with:

```dart
opacity = 0.0
```

Then change it to:

```dart
opacity = 1.0
```

Example:

```dart
AnimatedOpacity(
  opacity: visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  child: widget,
)
```

Flow:

```text
Invisible
   ↓
opacity = 0
   ↓
State changes
   ↓
opacity = 1
   ↓
AnimatedOpacity
   ↓
Fade in
   ↓
Visible
```

---

# 15. Fade Out

The reverse is a fade-out.

Start:

```dart
opacity = 1.0
```

Then change to:

```dart
opacity = 0.0
```

Example:

```dart
AnimatedOpacity(
  opacity: visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  child: widget,
)
```

---

# 16. Important Behavior: Opacity 0 Does Not Remove the Widget

This is one of the most important concepts.

When:

```dart
opacity: 0.0
```

the widget becomes visually transparent.

But it still exists in the widget tree and may still participate in hit testing.

Therefore:

```text
Invisible
≠
Removed
```

For example:

```dart
AnimatedOpacity(
  opacity: 0.0,
  duration: const Duration(milliseconds: 300),
  child: ElevatedButton(
    onPressed: () {},
    child: const Text('Invisible Button'),
  ),
)
```

The button may still receive pointer events even though it cannot be seen.

This can create unexpected behavior.

---

# 17. IgnorePointer

If an invisible widget should not receive pointer events, you can combine `AnimatedOpacity` with `IgnorePointer`.

Example:

```dart
IgnorePointer(
  ignoring: opacity == 0.0,
  child: AnimatedOpacity(
    opacity: opacity,
    duration: const Duration(milliseconds: 300),
    child: widget,
  ),
)
```

However, if you need a clean "visible + interactive" state transition, you should think carefully about when interaction should be enabled or disabled.

---

# 18. AnimatedOpacity Does Not Remove Layout Space

Another important concept:

```dart
AnimatedOpacity
```

does not remove the widget's layout space.

For example:

```dart
Column(
  children: [
    AnimatedOpacity(
      opacity: 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: 100,
      ),
    ),
    const Text('Hello'),
  ],
)
```

The invisible container still occupies approximately 100 logical pixels of vertical space.

So:

```text
opacity = 0
```

does not mean:

```text
height = 0
```

If you want the widget to disappear from layout, you need a different approach.

For example:

```dart
AnimatedSwitcher
```

or conditional rendering:

```dart
if (visible)
  widget
```

depending on the desired behavior.

---

# 19. AnimatedOpacity and Performance

Opacity can have rendering implications.

When opacity is applied to a widget subtree, Flutter may need to use compositing or an offscreen rendering strategy depending on the widget and rendering situation.

This means opacity animations are convenient, but you should not assume they are free.

Be especially careful when animating opacity on:

```text
Large widget trees
Complex images
Large lists
Multiple expensive widgets
Complex CustomPaint content
Video/content-heavy widgets
```

A single small fade animation is generally fine.

The senior-level rule is:

```text
Don't avoid AnimatedOpacity.
Don't abuse AnimatedOpacity.
Measure when performance matters.
```

Use Flutter DevTools when investigating rendering performance.

---

# 20. Opacity and Large Subtrees

Consider:

```dart
AnimatedOpacity(
  opacity: opacity,
  duration: const Duration(milliseconds: 500),
  child: VeryLargeWidgetTree(),
)
```

If the subtree is extremely expensive to render, repeatedly compositing it may have a noticeable cost.

Instead of blindly optimizing, first profile the actual application.

Useful tools include:

```text
Flutter DevTools
Performance view
CPU profiling
Frame rendering information
Raster statistics
```

Optimization should be based on evidence rather than assumptions.

---

# 21. AnimatedOpacity and Images

A common use case is fading images into the UI.

Example:

```dart
AnimatedOpacity(
  opacity: imageLoaded ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 400),
  child: Image.network(
    imageUrl,
  ),
)
```

This can create a smooth image appearance.

However, for image-loading transitions, Flutter also provides specialized approaches such as:

```dart
FadeInImage
```

and image loading builders.

Choose the solution based on the actual requirement.

---

# 22. AnimatedOpacity for Loading States

Example:

```dart
AnimatedOpacity(
  opacity: isLoading ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 300),
  child: const CircularProgressIndicator(),
)
```

This can be useful for small UI state transitions.

However, remember that opacity alone does not remove the widget from layout or necessarily disable interaction.

---

# 23. AnimatedOpacity for Error Messages

Example:

```dart
AnimatedOpacity(
  opacity: hasError ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 250),
  child: const Text(
    'Something went wrong',
  ),
)
```

This creates a simple fade transition for the error message.

---

# 24. AnimatedOpacity for Buttons

Example:

```dart
AnimatedOpacity(
  opacity: canSubmit ? 1.0 : 0.5,
  duration: const Duration(milliseconds: 200),
  child: ElevatedButton(
    onPressed: canSubmit ? submit : null,
    child: const Text('Submit'),
  ),
)
```

Notice the distinction:

```text
opacity
```

controls visual appearance.

```text
onPressed
```

controls interaction.

Do not use opacity as a replacement for application state.

---

# 25. AnimatedOpacity and State

`AnimatedOpacity` doesn't decide when an animation should happen.

Your state determines that.

For example:

```dart
bool isVisible = true;
```

Then:

```dart
AnimatedOpacity(
  opacity: isVisible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 400),
  child: widget,
)
```

State changes:

```text
isVisible = true
        ↓
opacity = 1.0

isVisible = false
        ↓
opacity = 0.0
```

This is a fundamental Flutter pattern:

```text
State
  ↓
Widget property
  ↓
Implicit animation
  ↓
Visual transition
```

---

# 26. What Happens Internally?

Conceptually, when the target opacity changes:

```dart
opacity: 1.0
```

to:

```dart
opacity: 0.0
```

Flutter's implicit animation machinery detects the property change.

Conceptually:

```text
Old value
1.0
  ↓
Animation system
  ↓
Tween / interpolation
  ↓
Curve
  ↓
New value
0.0
```

The framework produces intermediate values over the animation duration.

You don't manually manage the animation controller.

This is the major advantage of implicit animations.

---

# 27. Implicit vs Explicit Animation

## Implicit

```dart
AnimatedOpacity(
  opacity: visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 500),
  child: widget,
)
```

Advantages:

* Simple
* Less code
* Easy to maintain
* Great for common UI transitions
* No manual `AnimationController`
* No manual disposal

Disadvantages:

* Less control
* Limited animation orchestration
* Difficult for complex sequences
* Less control over animation lifecycle

---

## Explicit

With an explicit animation you may use:

```dart
AnimationController
```

and:

```dart
Tween<double>
```

Example conceptually:

```text
AnimationController
        ↓
Tween<double>
        ↓
CurvedAnimation
        ↓
Opacity
```

Explicit animations are better when you need:

* pause
* resume
* reverse
* repeat
* staggered animations
* complex synchronization
* manual animation lifecycle
* precise control

---

# 28. When Should You Use AnimatedOpacity?

Use it when:

* A widget needs to fade in
* A widget needs to fade out
* Visibility changes smoothly
* You need a simple opacity transition
* You don't need manual animation control

Examples:

```text
Dialogs
Tooltips
Error messages
Loading indicators
Images
Cards
Overlays
Empty states
Authentication UI
Onboarding screens
Buttons
Notifications
```

---

# 29. When Should You NOT Use AnimatedOpacity?

Avoid using it when the actual requirement is:

```text
Remove widget from layout
```

because opacity does not remove layout space.

Also reconsider it when you need:

```text
Complex animation sequences
Manual animation control
Staggered animations
Animation synchronization
Physics-based behavior
Precise controller control
```

In those situations, explicit animation APIs may be more appropriate.

---

# 30. AnimatedOpacity vs Visibility

These widgets solve different problems.

### AnimatedOpacity

```dart
AnimatedOpacity(
  opacity: visible ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 300),
  child: widget,
)
```

The widget remains in the tree and layout.

### Visibility

```dart
Visibility(
  visible: visible,
  child: widget,
)
```

Controls whether the widget is visible and can optionally preserve layout/state depending on configuration.

So:

```text
AnimatedOpacity
    ↓
Visual transparency

Visibility
    ↓
Visibility/layout behavior
```

---

# 31. AnimatedOpacity vs AnimatedSwitcher

`AnimatedSwitcher` is often more appropriate when one widget should transition into another.

Example:

```text
Loading
   ↓
Success
```

or:

```text
Login
   ↓
Logout
```

`AnimatedOpacity` is mainly:

```text
same widget
    ↓
different opacity
```

`AnimatedSwitcher` is:

```text
old child
    ↓
transition
    ↓
new child
```

---

# 32. Common Mistake #1 — Expecting Removal

Incorrect assumption:

```dart
AnimatedOpacity(
  opacity: 0.0,
  duration: const Duration(milliseconds: 300),
  child: widget,
)
```

means:

```text
widget is removed
```

It doesn't.

It means:

```text
widget becomes transparent
```

---

# 33. Common Mistake #2 — Forgetting Hit Testing

An invisible widget can still affect interaction.

If necessary, use:

```dart
IgnorePointer
```

or manage interaction based on your application state.

---

# 34. Common Mistake #3 — Using Opacity for Disabled State Logic

This:

```dart
AnimatedOpacity(
  opacity: enabled ? 1.0 : 0.5,
  duration: const Duration(milliseconds: 200),
  child: button,
)
```

does not actually disable the button.

You still need:

```dart
onPressed: enabled ? action : null
```

Visual state and behavioral state should remain separate.

---

# 35. Common Mistake #4 — Using Extremely Long Durations

Avoid unnecessarily long transitions such as:

```dart
Duration(seconds: 5)
```

for normal application UI.

Most UI feedback animations should feel responsive.

Choose duration based on the interaction and design system rather than blindly using a fixed value.

---

# 36. Common Mistake #5 — Using Complex Curves Everywhere

A curve like:

```dart
Curves.elasticOut
```

may look interesting but is not appropriate for every UI element.

A senior developer chooses animation behavior based on:

```text
Purpose
Context
Motion hierarchy
User interaction
Design system
Accessibility
Performance
```

not simply because an animation looks impressive.

---

# 37. Accessibility Considerations

Some users may prefer reduced motion.

Applications with substantial motion should consider accessibility preferences and provide appropriate reduced-motion behavior where practical.

For example, you may choose a shorter duration or disable nonessential motion when reduced motion is requested.

Animation should communicate state, not become a barrier to using the application.

---

# 38. Senior Design Principle

A good opacity animation should usually answer:

```text
Why is this element appearing?
Why is it disappearing?
What state changed?
What information does the animation communicate?
```

Avoid animation simply for decoration.

For example:

```text
Data loaded
    ↓
Fade content in
```

has meaning.

But:

```text
Every button fades every time
```

may create unnecessary motion.

---

# 39. Animation Duration Guidelines

There is no universal duration that works for every interface.

A useful starting point might be:

```text
Very small UI change
100–200ms

Normal UI transition
200–400ms

Larger transition
400–600ms

Large visual transition
600ms+
```

These are starting points, not strict rules.

Always consider:

```text
Distance
Visual complexity
User expectation
Interaction frequency
Motion hierarchy
```

---

# 40. Experiment Checklist

After implementing the demo, experiment with:

### Opacity

```dart
0.0
0.25
0.5
0.75
1.0
```

### Duration

```dart
100ms
200ms
300ms
500ms
1000ms
```

### Curves

```dart
Curves.linear
Curves.easeIn
Curves.easeOut
Curves.easeInOut
Curves.bounceOut
Curves.elasticOut
```

### Content

Try animating:

```text
Text
Container
Image
Icon
Card
Button
Column
Row
CustomPaint
```

---

# 41. Mental Model

Remember this:

```text
State changes
      ↓
opacity target changes
      ↓
AnimatedOpacity detects change
      ↓
Flutter interpolates old → new value
      ↓
Curve modifies timing
      ↓
Frames are rendered
      ↓
Widget visually fades
```

This is the core mental model you should remember.

---

# 42. Production Example

A realistic example:

```dart
class ProfileHeader extends StatelessWidget {
  final bool loaded;

  const ProfileHeader({
    super.key,
    required this.loaded,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: loaded ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      child: const Text(
        'Welcome back!',
      ),
    );
  }
}
```

The state controls the target value.

The animation widget controls the transition.

This separation is clean and maintainable.

---

# 43. Key Takeaways

Remember these concepts:

1. `AnimatedOpacity` is an implicit animation widget.
2. `opacity` accepts values from `0.0` to `1.0`.
3. `0.0` means fully transparent.
4. `1.0` means fully visible.
5. `duration` controls animation length.
6. `curve` controls animation timing.
7. `onEnd` runs after the animation finishes.
8. Opacity does not remove the widget from the widget tree.
9. Opacity does not remove layout space.
10. An invisible widget may still participate in hit testing.
11. Use `IgnorePointer` when appropriate.
12. Use explicit animations when you need advanced control.
13. Don't use opacity as a replacement for application state.
14. Profile complex opacity animations when performance matters.
15. Good animation communicates state or hierarchy.

---

# 44. What You Should Master Before Moving On

Before moving to the next animation, you should be able to explain:

```text
What is AnimatedOpacity?
```

```text
Why is it called an implicit animation?
```

```text
What does opacity = 0.0 mean?
```

```text
What does opacity = 1.0 mean?
```

```text
What does duration do?
```

```text
What does curve do?
```

```text
What does onEnd do?
```

```text
Does opacity = 0 remove the widget?
```

```text
Does opacity = 0 remove layout space?
```

```text
Can an invisible widget still receive interaction?
```

```text
When should you use AnimatedOpacity?
```

```text
When should you use AnimationController instead?
```

If you can answer these questions and reproduce the demo without copying it, you have a solid understanding of `AnimatedOpacity`.

---

# Next Topic

After mastering `AnimatedOpacity`, continue with the next implicit animation in the sequence.

Recommended sequence:

```text
AnimatedContainer
      ↓
AnimatedOpacity
      ↓
AnimatedPadding
      ↓
AnimatedAlign
      ↓
AnimatedPositioned
      ↓
AnimatedDefaultTextStyle
      ↓
AnimatedPhysicalModel
      ↓
AnimatedCrossFade
      ↓
AnimatedSwitcher
```

Then move into:

```text
Explicit Animations
      ↓
AnimationController
      ↓
Animation
      ↓
Tween
      ↓
Curves
      ↓
AnimatedBuilder
      ↓
...
```
