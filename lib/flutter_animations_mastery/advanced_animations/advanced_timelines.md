# Phase 4 — Advanced Animation Timelines

This phase is about **orchestrating animations**, not learning another isolated animation widget.

The demo combines:

- Multiple animations
- `Interval`
- Staggered animations
- `reverse()`
- `repeat()`
- Synchronization
- Multiple controllers
- `Listenable.merge`
- `AnimatedBuilder`
- `AnimatedWidget`
- Lifecycle and disposal
- Performance and architecture

---

## 1. The Big Picture

Phase 3 taught the building blocks:

```text
AnimationController
Tween
CurvedAnimation
Curves
Animation<T>
AnimatedBuilder
AnimatedWidget
```

Phase 4 asks a bigger question:

> How do I coordinate several animations into one coherent animation system?

The main idea is:

```text
AnimationController
        |
        v
   Master Timeline
        |
   +----+----+----+
   |    |    |    |
 Interval Interval Interval
   |    |    |    |
   v    v    v    v
 Header Card Stats Button
```

---

# 2. Multiple Animations

One `AnimationController` can drive many animations.

```dart
final controller = AnimationController(...);

final opacity = Tween<double>(
  begin: 0,
  end: 1,
).animate(controller);

final scale = Tween<double>(
  begin: 0.8,
  end: 1,
).animate(controller);
```

Conceptually:

```text
             Controller
            /    |    \
           /     |     \
      opacity   scale  position
```

This is useful when several visual properties belong to one conceptual sequence.

---

# 3. Why Use One Controller?

Suppose a dashboard enters the screen:

```text
Header
Card
Statistics
Button
```

You want them coordinated.

Instead of:

```text
Controller 1 -> Header
Controller 2 -> Card
Controller 3 -> Stats
Controller 4 -> Button
```

you can use:

```text
One controller
     |
     +--> Header
     +--> Card
     +--> Stats
     +--> Button
```

Then `Interval` decides when each animation runs.

This gives you a shared clock.

---

# 4. The Master Timeline

The demo uses:

```dart
AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 2400),
);
```

The controller represents:

```text
0.0 ---------------------------------- 1.0
|----------------------------------------|
             2400 milliseconds
```

Everything connected to this controller can use that timeline.

---

# 5. Interval

`Interval` selects a portion of the parent animation.

Example:

```dart
const Interval(
  0.0,
  0.25,
  curve: Curves.easeOut,
)
```

means:

```text
0% -------------------------- 100%
|------|-----------------------|
START  END

This animation uses the first 25%.
```

Another:

```dart
const Interval(
  0.70,
  1.0,
)
```

uses the last 30%.

---

# 6. Interval Does Not Create a Controller

This is important.

`Interval` does not create another independent clock.

Instead:

```text
Master controller
0.0 ---------------------------------- 1.0
             |
             +---- Interval 0.4 -> 0.75
```

The interval is a window into the existing timeline.

---

# 7. Interval + CurvedAnimation

A common pattern is:

```dart
final animation = Tween<double>(
  begin: 0,
  end: 1,
).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(
      0.4,
      0.75,
      curve: Curves.easeOutCubic,
    ),
  ),
);
```

This means:

1. Use the master controller.
2. Only animate during 40%–75%.
3. Apply `easeOutCubic`.
4. Convert the resulting value with the Tween.

---

# 8. Staggered Animation

A staggered animation is a group of animations that begin at different points in the same timeline.

The demo uses:

```text
Header: 0.00 -> 0.25
Card:   0.15 -> 0.50
Stats:  0.40 -> 0.75
Button: 0.70 -> 1.00
```

Visualized:

```text
0%    15%   25%   40%   50%   70%   75%   100%
|------|-----|-----|-----|-----|-----|-----|------|

Header
|-----------|

Card
      |------------------|

Stats
                         |------------------|

Button
                                      |----------|
```

That is a staggered timeline.

---

# 9. Staggered Does Not Mean Sequential

Sequential animation:

```text
A: |------|
B:        |------|
C:                |------|
```

Staggered animation can overlap:

```text
A: |------|
B:    |------|
C:        |------|
```

Overlapping animations often make UI entrances feel faster and more natural.

---

# 10. Designing a Staggered Timeline

Before writing code, design the timeline.

For example:

```text
0.0 -> 0.25   Header
0.15 -> 0.50  Card
0.40 -> 0.75  Stats
0.70 -> 1.00  Button
```

Then implement each section with an `Interval`.

This is much easier to reason about than randomly creating controllers.

---

# 11. Synchronization

Synchronization means making animations follow a controlled timing relationship.

The easiest form is a shared controller:

```text
               Controller
              /    |    \
             /     |     \
          Header  Card  Button
```

They are synchronized because all depend on the same clock.

---

# 12. One Controller vs Multiple Controllers

Use **one controller** when animations belong to one conceptual timeline.

Example:

```text
Page entrance
    |
    +--> Header
    +--> Card
    +--> Stats
    +--> Button
```

Use **separate controllers** when animations have independent lifecycles.

Example:

```text
Entrance controller
       |
       +--> page entrance

Pulse controller
       |
       +--> infinite live indicator
```

The demo intentionally uses both approaches.

---

# 13. The Demo Has Two Timelines

### Master timeline

```text
_controller
```

It handles:

```text
Header
Card
Stats
Button
```

and normally plays once.

### Independent timeline

```text
_pulseController
```

It handles:

```text
Live synchronization indicator
```

and repeats forever.

So:

```text
MASTER
0 -> 1

PULSE
0 -> 1 -> 0 -> 1 -> 0 -> ...
```

This is a realistic production pattern.

---

# 14. Why the Pulse Uses a Separate Controller

The entrance animation has a lifecycle:

```text
start -> finish
```

The pulse has a lifecycle:

```text
start -> repeat -> repeat -> repeat -> ...
```

They are conceptually different.

Trying to force both into one controller would make the timeline more complicated.

Use separate controllers for independent behaviors.

---

# 15. `Listenable.merge`

The demo uses:

```dart
AnimatedBuilder(
  animation: Listenable.merge([
    _controller,
    _pulseController,
  ]),
  builder: (context, child) {
    ...
  },
)
```

This combines multiple `Listenable`s.

Conceptually:

```text
Controller A ----\
                  \
                   -> AnimatedBuilder
                  /
Controller B ----/
```

When either source changes, the builder can rebuild.

Use this when one UI area genuinely depends on several listenable sources.

---

# 16. Reverse

Explicit animation can run backward:

```dart
_controller.reverse();
```

Forward:

```text
0 -> 1
```

Reverse:

```text
1 -> 0
```

Because the staggered animations depend on the same master controller, the whole timeline can be reversed together.

---

# 17. Reverse Is Not Reset

These are different:

```dart
_controller.reverse();
```

means:

```text
animate backward
```

while:

```dart
_controller.reset();
```

means:

```text
jump immediately to the lower bound
```

So:

```text
reverse:
1.0 -----> 0.0

reset:
1.0 ----X 0.0
```

---

# 18. `reverseCurve`

For polished UI, forward and reverse motion can use different curves.

Example:

```dart
CurvedAnimation(
  parent: controller,
  curve: Curves.easeOut,
  reverseCurve: Curves.easeIn,
)
```

Forward:

```text
easeOut
```

Reverse:

```text
easeIn
```

This often produces more natural movement.

---

# 19. Repeat

You can repeat a controller:

```dart
_controller.repeat();
```

Conceptually:

```text
0 -> 1
0 -> 1
0 -> 1
...
```

This is useful for animations that need to loop.

Examples:

- loading indicators
- pulsing status
- breathing effects
- attention indicators

---

# 20. Repeat With Reverse

The pulse uses:

```dart
_pulseController.repeat(
  reverse: true,
);
```

So the timeline becomes:

```text
0 -> 1 -> 0 -> 1 -> 0
```

This is ideal for a pulse because the value smoothly grows and shrinks.

---

# 21. Repeat the Master Timeline

The demo's Repeat button does:

```dart
_controller.repeat(
  reverse: true,
);
```

This makes the complete staggered sequence travel:

```text
0 -> 1 -> 0 -> 1 -> 0
```

Because every staggered animation depends on `_controller`, the entire sequence repeats together.

That is synchronization through a shared timeline.

---

# 22. `forward(from: 0.0)`

Replay uses:

```dart
_controller.forward(from: 0.0);
```

This means:

```text
go to beginning
    ↓
play forward
```

It is useful for replay buttons.

---

# 23. `stop()`

The demo has:

```dart
_controller.stop();
```

This freezes the master timeline at its current position.

Example:

```text
0.0 -> 0.2 -> 0.4 -> STOP
```

The controller stays around `0.4`.

It does not automatically reset.

---

# 24. `reset()`

The demo also has:

```dart
_controller.reset();
```

This immediately returns the controller to its lower bound.

No reverse animation occurs.

It is useful when you want to prepare the animation for a fresh start.

---

# 25. Complete Timeline of the Demo

The main sequence is:

```text
MASTER CONTROLLER

0%        25%       50%       75%       100%
|----------|---------|---------|----------|

HEADER
|----------|

CARD
   |----------------|

STATS
          |----------------|

BUTTON
                    |------------------|
```

Meanwhile:

```text
PULSE CONTROLLER

0 -> 1 -> 0 -> 1 -> 0 -> 1 -> ...
```

This demonstrates both shared and independent animation systems.

---

# 26. Animation Architecture

The overall architecture is:

```text
                  MASTER CONTROLLER
                         |
        +----------------+----------------+
        |                |                |
        v                v                v
     Header             Card             Stats
        |                |                |
     Interval         Interval         Interval
        |                |                |
      Tween            Tween            Tween

                         |
                         v
                       Button
                         |
                      Interval

                  PULSE CONTROLLER
                         |
                         v
                   Live Indicator
```

---

# 27. When to Use One Controller

Prefer one controller when:

- animations are part of one sequence
- timing must be synchronized
- you need a shared reverse operation
- you need a shared repeat operation
- you want staggered animations
- one user action controls the entire sequence

---

# 28. When to Use Multiple Controllers

Prefer multiple controllers when:

- animations have different lifecycles
- one repeats forever
- one is user-driven
- one is a page transition
- another is a background effect
- their durations and states are unrelated

A useful senior-level rule is:

```text
One conceptual timeline
    -> one controller

Independent conceptual timelines
    -> separate controllers
```

---

# 29. Common Mistake — Too Many Controllers

Avoid:

```text
Controller 1 -> Header
Controller 2 -> Card
Controller 3 -> Stats
Controller 4 -> Button
```

if they are all part of one entrance sequence.

Prefer:

```text
Controller
   |
   +--> Header Interval
   +--> Card Interval
   +--> Stats Interval
   +--> Button Interval
```

This makes synchronization much simpler.

---

# 30. Common Mistake — One Controller for Everything

The opposite is also bad.

Don't put:

```text
Page entrance
Infinite pulse
Drag interaction
Loading spinner
Background effect
```

into one giant timeline just because technically you can.

Separate unrelated behaviors.

---

# 31. Common Mistake — Forgetting Disposal

Every controller created by the State must be disposed.

The demo uses:

```dart
@override
void dispose() {
  _controller.dispose();
  _pulseController.dispose();
  super.dispose();
}
```

This releases the controller's ticker resources.

---

# 32. Common Mistake — Infinite Animation Without Purpose

An infinite animation:

```dart
controller.repeat();
```

should have a UX reason.

Avoid decorative infinite motion when it:

- distracts users
- consumes unnecessary resources
- creates accessibility problems
- adds no meaningful information

---

# 33. `AnimatedBuilder`

`AnimatedBuilder` is useful for advanced timelines because multiple values can change every frame.

The demo uses:

```dart
AnimatedBuilder(
  animation: Listenable.merge([
    _controller,
    _pulseController,
  ]),
  builder: (context, child) {
    ...
  },
)
```

This lets the screen respond to both timelines.

For larger screens, isolate the builder to the smallest reasonable animated region.

---

# 34. `AnimatedWidget`

The live indicator extends:

```dart
AnimatedWidget
```

because it has one simple animation dependency:

```text
pulse
```

That gives it a clean responsibility:

```text
Pulse animation
      ↓
Live status widget
```

---

# 35. Performance

For production animations:

### Isolate rebuilds

Don't rebuild unrelated UI every frame.

### Reuse static children

Use the `child` parameter of `AnimatedBuilder` when appropriate.

### Avoid unnecessary controllers

Use one master controller for one conceptual sequence.

### Be careful with infinite animation

Only repeat when needed.

### Profile

Use Flutter DevTools when an animation is complex or janky.

---

# 36. Accessibility

Production animation should also consider reduced motion.

Depending on the Flutter version/API you target, inspect:

```dart
MediaQuery.of(context).disableAnimations
```

and consider:

- shortening durations
- skipping decorative motion
- reducing repeated effects
- keeping state changes understandable without animation

Animation is a communication tool, not a requirement for understanding the UI.

---

# 37. Real-World Use Cases

### Onboarding

```text
Logo
  ↓
Title
  ↓
Description
  ↓
Button
```

### Dashboard

```text
Header
  ↓
Cards
  ↓
Statistics
  ↓
Actions
```

### E-commerce

```text
Product image
  ↓
Title
  ↓
Price
  ↓
Add to cart
```

### Authentication

```text
Logo
  ↓
Form
  ↓
Validation
  ↓
Button
```

### Loading / Success

```text
Loading
  ↓
Progress
  ↓
Success
```

---

# 38. Senior-Level Way to Design Timelines

Do not start by asking:

> Which animation widget should I use?

Start by designing the timeline:

```text
0.00 -> 0.25  Header
0.15 -> 0.50  Card
0.40 -> 0.75  Statistics
0.70 -> 1.00  Button
```

Then decide:

```text
Header -> opacity + slide
Card -> opacity + scale
Stats -> opacity + slide
Button -> opacity + scale
```

Then implement the Tweens and curves.

This makes complex animation much easier to reason about.

---

# 39. Phase 3 vs Phase 4

## Phase 3

You learned:

```text
How to build an explicit animation
```

Example:

```text
Controller
   ↓
Tween
   ↓
Curve
   ↓
AnimatedBuilder
   ↓
Widget
```

## Phase 4

You learn:

```text
How to orchestrate multiple animations
```

Example:

```text
Controller
   |
   +--> Interval -> Header
   |
   +--> Interval -> Card
   |
   +--> Interval -> Stats
   |
   +--> Interval -> Button
```

This is the major conceptual upgrade.

---

# 40. Final Mental Model

Remember Phase 4 as:

```text
MULTIPLE ANIMATIONS
        ↓
One controller can drive many values
        ↓
INTERVAL
        ↓
Each animation gets a section of the timeline
        ↓
STAGGERED ANIMATION
        ↓
Those sections create coordinated motion
        ↓
SYNCHRONIZATION
        ↓
Animations follow one timeline or controlled relationships
        ↓
REVERSE
        ↓
The timeline can travel backward
        ↓
REPEAT
        ↓
The timeline can run repeatedly
```

The senior-level difference is:

```text
Phase 3:
"How do I animate a widget?"

Phase 4:
"How do I design and control an animation timeline?"
```

That is the main idea you should take from this phase.
