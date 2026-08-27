# Physics Animations in Flutter

Physics animations are animations based on physical behavior rather than a fixed duration and curve.

Instead of saying:

> Move from A to B in 500 milliseconds.

we can say:

> Start with this position and velocity, then let the physical simulation determine what happens.

This makes animations feel more natural and interactive.

Flutter provides a powerful physics system through the `Simulation` class and several built-in implementations.

The main topics in this section are:

* `SpringSimulation`
* `GravitySimulation`
* `FrictionSimulation`
* Custom `Simulation`

---

# 1. What Are Physics Animations?

A normal animation usually follows this model:

```text
Start
  ↓
Duration
  ↓
Curve
  ↓
End
```

For example:

```dart
controller.animateTo(
  1,
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeOut,
);
```

The developer controls:

* Start value
* End value
* Duration
* Curve

Physics animation works differently:

```text
Initial position
       +
Initial velocity
       +
Physical parameters
       ↓
    Simulation
       ↓
Position over time
```

Instead of manually deciding every movement, the physics simulation calculates the movement based on physical rules.

---

# 2. The Core Physics System

Flutter's physics animations are built around:

```dart
Simulation
```

A `Simulation` describes how a value changes over time.

The important methods are:

```dart
double x(double time)
```

```dart
double dx(double time)
```

```dart
bool isDone(double time)
```

Conceptually:

```text
             Simulation
                 │
       ┌─────────┼─────────┐
       ↓         ↓         ↓
    x(time)   dx(time)  isDone(time)
       │         │         │
       ↓         ↓         ↓
   position   velocity   finished?
```

---

# 3. x(time)

The `x()` method returns the simulated position at a particular time.

Example:

```dart
@override
double x(double time) {
  return time * 100;
}
```

Conceptually:

```text
time       position

0.0   →      0
0.5   →     50
1.0   →    100
2.0   →    200
```

Flutter uses this value to update the animation.

---

# 4. dx(time)

The `dx()` method represents the velocity of the simulation at a particular time.

Conceptually:

```text
x(time)
   ↓
position

dx(time)
   ↓
velocity
```

Velocity is especially important in physics animations because the current velocity affects what happens next.

For example, a fast-moving object should continue farther than a slowly moving object.

---

# 5. isDone(time)

`isDone()` tells Flutter whether the simulation has finished.

Example:

```dart
@override
bool isDone(double time) {
  return time >= 2.0;
}
```

This means:

```text
0.0 seconds → running
1.0 seconds → running
2.0 seconds → finished
```

---

# 6. AnimationController + Simulation

The most important API for running a physics simulation is:

```dart
controller.animateWith(simulation);
```

Example:

```dart
final simulation = SpringSimulation(
  spring,
  start,
  end,
  velocity,
);

controller.animateWith(simulation);
```

The architecture is:

```text
AnimationController
        ↓
   animateWith()
        ↓
    Simulation
        ↓
     x(time)
        ↓
controller.value
        ↓
       Widget
```

The `AnimationController` provides the ticker and animation lifecycle, while the `Simulation` determines the physical movement.

---

# 7. AnimationController.unbounded()

A normal `AnimationController` normally operates between:

```text
0.0 → 1.0
```

Physics simulations do not always stay in that range.

For example, a physical position might be:

```text
-300 → -100 → 0 → 200 → 500
```

For these cases, you can use:

```dart
AnimationController.unbounded(
  vsync: this,
);
```

This allows the controller's value to represent arbitrary values.

For example:

```dart
controller.value = 250;
```

or:

```dart
controller.value = -100;
```

This is particularly useful when the controller represents a physical position instead of animation progress.

---

# 8. SpringSimulation

`SpringSimulation` models spring-like behavior.

Think about pulling a rubber band and releasing it.

```text
              target
                ●
               / \
              /   \
             /     \
────────────●───────
          object
```

The object can:

* Move toward a target
* Overshoot the target
* Move back
* Oscillate
* Eventually settle

---

# 9. SpringDescription

A spring is configured using:

```dart
SpringDescription
```

Example:

```dart
const SpringDescription(
  mass: 1,
  stiffness: 180,
  damping: 12,
)
```

The three important parameters are:

```text
mass
stiffness
damping
```

---

# 10. Mass

Mass represents how heavy the object behaves in the simulation.

Higher mass generally makes the object feel heavier and slower to respond.

Conceptually:

```text
Low mass
    ↓
Quick response


High mass
    ↓
Heavier response
```

Mass should be chosen according to the interaction you are trying to create.

---

# 11. Stiffness

Stiffness controls how strongly the spring pulls toward its target.

Higher stiffness generally means:

```text
Stronger spring
      ↓
Faster movement toward target
```

Lower stiffness generally means:

```text
Weaker spring
      ↓
Slower movement
```

---

# 12. Damping

Damping controls how much oscillation is reduced.

Low damping can produce:

```text
target
  ↑
  │   overshoot
  │      ╲
  │       ╲
  │        ╲
  │    ╱────╲
  │───╯
```

The object may repeatedly move past the target before settling.

Higher damping produces less oscillation:

```text
object
   ↓
target
   ↓
settle
```

---

# 13. SpringSimulation Constructor

A common form is:

```dart
SpringSimulation(
  spring,
  start,
  end,
  velocity,
)
```

Example:

```dart
final simulation = SpringSimulation(
  const SpringDescription(
    mass: 1,
    stiffness: 180,
    damping: 12,
  ),
  100,
  0,
  0,
);
```

This means:

```text
Start position  = 100
Target position = 0
Initial velocity = 0
```

The spring then calculates how the object moves from `100` toward `0`.

---

# 14. Spring with Initial Velocity

The velocity parameter becomes especially useful after a gesture.

For example:

```dart
final velocity =
    details.velocity.pixelsPerSecond.dx;
```

Then:

```dart
final simulation = SpringSimulation(
  spring,
  currentPosition,
  targetPosition,
  velocity,
);
```

Now the spring does not simply start from rest.

It begins with the velocity produced by the user's gesture.

This can make interactions feel much more natural.

---

# 15. Spring Use Cases

`SpringSimulation` is excellent for:

* Dragged objects returning to position
* Bottom sheets
* Interactive navigation
* Swipe cards
* Elastic UI
* Toggles
* Reordering
* Snap-to-position controls
* Custom transitions

---

# 16. GravitySimulation

`GravitySimulation` models constant acceleration.

The simplest example is a falling object.

```text
Object
  ●
  │
  │
  ↓
  ↓
  ↓
────────────
   ground
```

Gravity accelerates the object downward.

---

# 17. GravitySimulation Parameters

A common constructor is:

```dart
GravitySimulation(
  acceleration,
  distance,
  endDistance,
  velocity,
)
```

Example:

```dart
final simulation = GravitySimulation(
  600,
  0,
  120,
  0,
);
```

Conceptually:

```text
acceleration = 600
start        = 0
end          = 120
velocity     = 0
```

---

# 18. Gravity and Velocity

Gravity changes velocity over time.

Initially:

```text
velocity = 0
```

Then:

```text
velocity increases
```

Then:

```text
object moves faster
```

So the relationship is:

```text
Gravity
   ↓
Acceleration
   ↓
Velocity
   ↓
Position
```

---

# 19. Gravity Use Cases

Gravity can be useful for:

* Falling objects
* Game objects
* Dropped cards
* Physics demonstrations
* Bouncing objects
* Custom particle-like effects
* Physics-based UI

---

# 20. Important Gravity Consideration

`GravitySimulation` models acceleration, but it does not automatically provide a complete collision system.

For example:

```text
Object
  ↓
  ↓
  ↓
Ground
```

If you want:

```text
fall
 ↓
hit ground
 ↓
bounce
 ↓
fall
 ↓
settle
```

you need additional logic or another simulation to model the collision and bounce behavior.

This is an important distinction:

```text
GravitySimulation
        ≠
Complete physics engine
```

It provides a specific physical simulation.

---

# 21. FrictionSimulation

`FrictionSimulation` models movement that gradually slows because of friction.

Imagine throwing an object across a surface:

```text
FAST
──────────────→

──────────→

──────→

──→

→

STOP
```

The object starts with velocity and gradually loses it.

---

# 22. FrictionSimulation Parameters

A common constructor is:

```dart
FrictionSimulation(
  drag,
  position,
  velocity,
)
```

Example:

```dart
final simulation = FrictionSimulation(
  0.6,
  0,
  1500,
);
```

Conceptually:

```text
drag     = 0.6
position = 0
velocity = 1500
```

---

# 23. Drag

The drag value controls how quickly the movement slows.

Conceptually:

```text
Higher drag
    ↓
Faster slowdown
    ↓
Shorter movement
```

and:

```text
Lower drag
    ↓
Slower slowdown
    ↓
Longer movement
```

The exact value should be tuned based on the interaction.

---

# 24. Friction Use Cases

`FrictionSimulation` is useful for:

* Fling gestures
* Custom scrolling
* Swipe interactions
* Momentum-based controls
* Custom carousels
* Interactive panels
* Maps
* Physics-like movement

---

# 25. Fling + Friction

Friction is particularly useful after a gesture.

During the gesture:

```dart
position += details.delta.dx;
```

When the user releases:

```dart
final velocity =
    details.velocity.pixelsPerSecond.dx;
```

Then:

```dart
final simulation = FrictionSimulation(
  0.6,
  position,
  velocity,
);

controller.animateWith(simulation);
```

The result is:

```text
User drags
    ↓
User releases
    ↓
Velocity captured
    ↓
FrictionSimulation
    ↓
Object continues moving
    ↓
Velocity decreases
    ↓
Object stops
```

This is the basic architecture behind momentum-based interactions.

---

# 26. Custom Simulation

Flutter allows you to create your own simulation.

You can extend:

```dart
Simulation
```

Example:

```dart
class MySimulation extends Simulation {
  @override
  double x(double time) {
    // Position
  }

  @override
  double dx(double time) {
    // Velocity
  }

  @override
  bool isDone(double time) {
    // Completion
  }
}
```

This gives you complete control over the mathematical behavior.

---

# 27. Custom Simulation: x()

The `x()` method defines the position.

Example:

```dart
@override
double x(double time) {
  return time * 100;
}
```

Conceptually:

```text
time     position

0.0   →     0
1.0   →   100
2.0   →   200
3.0   →   300
```

You can implement much more complex mathematical functions.

---

# 28. Custom Simulation: dx()

The `dx()` method represents velocity.

For constant velocity:

```dart
@override
double dx(double time) {
  return 100;
}
```

For changing velocity, calculate the derivative of your position function or otherwise provide the appropriate velocity model.

A good custom simulation should keep the relationship between:

```text
position
velocity
time
```

mathematically consistent.

---

# 29. Custom Simulation: isDone()

Example:

```dart
@override
bool isDone(double time) {
  return time >= 2;
}
```

This tells Flutter that the simulation is complete after two seconds.

You can also finish based on a physical condition.

For example:

```text
velocity is almost zero
        AND
distance from target is very small
```

Then the simulation can be considered finished.

---

# 30. Custom Physics Examples

Custom simulations can be used for:

```text
Custom bounce
Elastic movement
Wave motion
Oscillation
Magnetic movement
Custom gravity
Custom friction
Special motion
Game-like physics
```

For example:

```text
Position
   ↑
   │       ╭──╮
   │     ╭─╯  ╰─╮
   │   ╭─╯      ╰──
   │ ╭─╯
   │─╯
   └────────────────→ Time
```

The exact mathematical behavior is completely under your control.

---

# 31. Physics vs Curves

This distinction is extremely important.

## Curve-based Animation

A normal animation generally defines:

```text
Start
End
Duration
Curve
```

Example:

```dart
controller.animateTo(
  1,
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeOut,
);
```

The developer controls the timing.

---

## Physics Animation

A physics animation generally defines:

```text
Position
Velocity
Acceleration
Mass
Stiffness
Damping
Friction
```

The simulation determines the movement.

---

# 32. Curve Mental Model

Think of a curve-based animation as:

```text
Developer
    ↓
Duration + Curve
    ↓
Predictable animation
```

For example:

```text
0% ─────────────── 100%
```

The animation always follows the specified timing.

---

# 33. Physics Mental Model

Think of physics as:

```text
Initial conditions
       ↓
Physical rules
       ↓
Simulation
       ↓
Movement
```

The movement is determined by the simulation.

This makes physics particularly useful when the user's input affects the result.

---

# 34. Physics + Gesture

Physics animations become especially powerful when combined with gestures.

The general flow is:

```text
User drags
    ↓
Position changes
    ↓
User releases
    ↓
Velocity calculated
    ↓
Physics simulation
    ↓
Object continues naturally
```

For example:

```text
GestureDetector
       ↓
onPanUpdate
       ↓
current position
       ↓
onPanEnd
       ↓
velocity
       ↓
Simulation
       ↓
AnimationController
```

---

# 35. Drag + Spring

A common pattern is:

```text
User drags object
       ↓
Object follows finger
       ↓
User releases
       ↓
SpringSimulation
       ↓
Object returns to target
```

During the drag:

```dart
controller.value = currentPosition;
```

After release:

```dart
final simulation = SpringSimulation(
  spring,
  currentPosition,
  targetPosition,
  velocity,
);

controller.animateWith(simulation);
```

This is useful for snap-back interactions.

---

# 36. Drag + Friction

Another common pattern is:

```text
User drags
    ↓
User releases quickly
    ↓
Velocity exists
    ↓
FrictionSimulation
    ↓
Object keeps moving
    ↓
Object slows down
```

This is useful for:

* Flinging cards
* Custom carousels
* Momentum controls
* Interactive panels

---

# 37. Spring vs Friction

These two are easy to confuse.

## SpringSimulation

Main purpose:

```text
Move toward a target
```

Example:

```text
Object ─────→ Target
```

The object may overshoot and settle.

---

## FrictionSimulation

Main purpose:

```text
Continue moving and slow down
```

Example:

```text
Object ───────────────→
                  slow ↓
                       stop
```

There does not need to be a target.

---

# 38. Gravity vs Friction

Gravity and friction have different purposes.

## Gravity

```text
Acceleration
    ↓
Velocity increases
```

Example:

```text
Object
  ↓
  ↓
  ↓
```

---

## Friction

```text
Deceleration
    ↓
Velocity decreases
```

Example:

```text
Object →→→→→→→→
             →→
              →
             STOP
```

---

# 39. Combining Physics

You can combine multiple physical behaviors.

For example:

```text
Gravity
   +
Friction
   +
Collision
   +
Spring
```

This can create:

```text
Fall
 ↓
Hit ground
 ↓
Bounce
 ↓
Spring
 ↓
Settle
```

However, Flutter's `Simulation` classes are individual mathematical models. Combining them usually requires your own coordination logic.

---

# 40. AnimationController Lifecycle

Physics animations still use normal `AnimationController` lifecycle rules.

Create the controller in `initState()`:

```dart
@override
void initState() {
  super.initState();

  controller = AnimationController.unbounded(
    vsync: this,
  );
}
```

Dispose it:

```dart
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

Never create an `AnimationController` inside `build()`.

---

# 41. TickerProvider

Because `AnimationController` needs a ticker, the State usually uses:

```dart
with SingleTickerProviderStateMixin
```

when there is one controller.

Example:

```dart
class _DemoState extends State<Demo>
    with SingleTickerProviderStateMixin {
}
```

If you need multiple controllers:

```dart
with TickerProviderStateMixin
```

is usually appropriate.

---

# 42. Why Not Create the Controller in build()?

This is wrong:

```dart
Widget build(BuildContext context) {
  final controller = AnimationController(
    vsync: this,
  );

  return ...;
}
```

`build()` can run many times.

You would potentially create many controllers and tickers.

Instead:

```text
initState()
    ↓
Create controller

build()
    ↓
Use controller

dispose()
    ↓
Dispose controller
```

---

# 43. AnimatedBuilder with Physics

A physics animation can be rendered using `AnimatedBuilder`.

Example:

```dart
AnimatedBuilder(
  animation: controller,
  builder: (context, child) {
    return Transform.translate(
      offset: Offset(controller.value, 0),
      child: child,
    );
  },
  child: const MyWidget(),
)
```

This is useful because only the animated portion needs to rebuild.

---

# 44. Performance

Physics simulations can update every frame.

Therefore, avoid unnecessarily rebuilding large widget trees.

Prefer:

```text
Screen
│
├── Static content
│
├── Static content
│
└── AnimatedBuilder
     └── Physics object
```

Instead of rebuilding the entire screen every frame.

---

# 45. Physics and setState

For simple demonstrations, this is acceptable:

```dart
controller.addListener(() {
  setState(() {
    position = controller.value;
  });
});
```

But for larger UIs, consider letting `AnimatedBuilder` directly consume the controller:

```dart
AnimatedBuilder(
  animation: controller,
  builder: (context, child) {
    return Transform.translate(
      offset: Offset(controller.value, 0),
      child: child,
    );
  },
)
```

This makes the animated area easier to isolate.

---

# 46. Common Mistake: Forgetting dispose

Always dispose the controller:

```dart
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

Otherwise, the ticker may continue existing after the widget is removed.

---

# 47. Common Mistake: Wrong Controller Type

If the simulation represents an arbitrary physical position, a bounded controller may be inappropriate.

For example:

```text
-200
  ↓
0
  ↓
300
```

Consider:

```dart
AnimationController.unbounded(
  vsync: this,
);
```

instead of forcing physical values into:

```text
0.0 → 1.0
```

---

# 48. Common Mistake: Ignoring Velocity

For gesture-driven physics, velocity is often critical.

Bad interaction:

```text
User slowly drags
User quickly flings
```

Both produce the same result.

Better interaction:

```text
Slow release
    ↓
Short movement

Fast release
    ↓
Longer movement
```

Velocity makes the interaction respond to how the user actually moved.

---

# 49. Common Mistake: Unrealistic Spring Parameters

For example:

```text
Very high stiffness
+
Very low damping
```

can produce excessive oscillation.

Instead, tune:

```text
mass
stiffness
damping
```

according to the desired UX.

Physics parameters are not universal constants for UI.

---

# 50. Common Mistake: Using Physics Everywhere

Physics is not automatically better.

If you simply need:

```text
Move from A to B
in 300 milliseconds
```

a normal animation may be simpler:

```dart
controller.animateTo(
  1,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOut,
);
```

Use physics when physical behavior adds value.

---

# 51. Physics vs Normal Animation

Use a normal animation when you know:

```text
Start
End
Duration
Curve
```

Use physics when the result depends on:

```text
Velocity
Acceleration
Momentum
Spring
Friction
Mass
Damping
Stiffness
```

---

# 52. When to Use SpringSimulation

Use `SpringSimulation` when something should:

* Snap to a position
* Return to a position
* Bounce
* Settle
* Feel elastic
* Follow spring behavior

Common examples:

```text
Bottom sheet
Drag-to-dismiss
Interactive navigation
Elastic card
Snap controls
Reordering
```

---

# 53. When to Use GravitySimulation

Use `GravitySimulation` when something should:

* Fall
* Accelerate downward
* Simulate constant acceleration

Common examples:

```text
Games
Physics demos
Falling objects
Dropped cards
Custom effects
```

---

# 54. When to Use FrictionSimulation

Use `FrictionSimulation` when something should:

* Continue moving after release
* Preserve momentum
* Gradually slow down

Common examples:

```text
Fling
Swipe
Carousel
Custom scrolling
Interactive panels
Momentum-based controls
```

---

# 55. When to Use Custom Simulation

Use a custom `Simulation` when Flutter's built-in simulations don't provide the behavior you need.

Examples:

```text
Custom bounce
Magnetic movement
Wave motion
Oscillation
Special easing
Game physics
Custom motion
```

---

# 56. Comparison

| Simulation           | Main Idea                    | Typical Use          |
| -------------------- | ---------------------------- | -------------------- |
| `SpringSimulation`   | Move toward a target         | Snap, bounce, settle |
| `GravitySimulation`  | Constant acceleration        | Falling objects      |
| `FrictionSimulation` | Velocity gradually decreases | Fling, momentum      |
| Custom `Simulation`  | Your own mathematical model  | Advanced behavior    |

---

# 57. Physics + AnimationController Architecture

A good mental model is:

```text
                    INPUT
                      │
          ┌───────────┴───────────┐
          │                       │
       Position                Velocity
          │                       │
          └───────────┬───────────┘
                      ↓
                 Simulation
                      │
          ┌───────────┼───────────┐
          ↓           ↓           ↓
       Spring      Gravity     Friction
          │           │           │
          └───────────┴───────────┘
                      ↓
                    x(t)
                      ↓
             AnimationController
                      ↓
                     UI
```

---

# 58. Physics Animation Mental Model

The most important thing to understand is:

```text
Normal animation:

Start
 ↓
Duration + Curve
 ↓
End
```

Physics animation:

```text
Initial state
 ↓
Physical rules
 ↓
Simulation
 ↓
Position over time
 ↓
Final state
```

And gesture-driven physics:

```text
Gesture
   ↓
Position + Velocity
   ↓
Simulation
   ↓
AnimationController
   ↓
UI
```

---

# 59. Practical Example: Interactive Bottom Sheet

A bottom sheet can combine:

```text
Gesture
+
AnimationController
+
SpringSimulation
```

During the drag:

```text
Finger
  ↓
Drag progress
  ↓
controller.value
  ↓
Sheet position
```

When the user releases:

```text
Enough progress?
      │
   ┌──┴──┐
   │     │
  Yes    No
   │     │
   ↓     ↓
 Open   Close
   │     │
   └──┬──┘
      ↓
SpringSimulation
```

This creates a natural interaction.

---

# 60. Practical Example: Swipe Card

A swipe card can use:

```text
GestureDetector
      ↓
Drag position
      ↓
Rotation
      ↓
Opacity
      ↓
User releases
      ↓
Velocity + threshold
      ↓
Spring / Friction
```

For example:

```text
Small swipe
    ↓
Spring back

Large swipe
    ↓
Dismiss

Fast fling
    ↓
Friction / continuation
```

---

# 61. Practical Example: Drag-to-Dismiss

Architecture:

```text
GestureDetector
      ↓
onPanUpdate
      ↓
card position
      ↓
Transform
      ↓
onPanEnd
      ↓
distance + velocity
      ↓
decision
      ↓
Spring / Friction / Completion
```

This is a reusable pattern for many mobile interfaces.

---

# 62. Custom Simulation Design

When creating a custom simulation, think about three things:

## 1. Position

Where is the object?

```dart
double x(double time)
```

## 2. Velocity

How fast is it moving?

```dart
double dx(double time)
```

## 3. Completion

When should it stop?

```dart
bool isDone(double time)
```

Therefore:

```text
Position
+
Velocity
+
Completion
=
Simulation
```

---

# 63. Senior-Level Design Thinking

Before using a physics animation, ask:

### Question 1

Does the animation need physical behavior?

If no:

```text
Use normal animation.
```

If yes:

```text
Consider Simulation.
```

### Question 2

Does user velocity affect the result?

If yes:

```text
Use physics.
```

### Question 3

Does the object need to settle toward a target?

If yes:

```text
Consider SpringSimulation.
```

### Question 4

Should the object continue moving and slow down?

If yes:

```text
Consider FrictionSimulation.
```

### Question 5

Should the object accelerate because of gravity?

If yes:

```text
Consider GravitySimulation.
```

### Question 6

Does none of the built-in simulations match the behavior?

If yes:

```text
Create a Custom Simulation.
```

---

# 64. Performance Best Practices

For production applications:

* Create controllers in `initState()`
* Dispose controllers in `dispose()`
* Avoid unnecessary rebuilds
* Isolate animated widgets
* Prefer `AnimatedBuilder` when appropriate
* Avoid expensive work during every frame
* Keep simulation calculations efficient
* Avoid creating objects repeatedly inside frame callbacks
* Test on real devices
* Tune physics parameters for the actual interaction

---

# 65. Physics Animation Checklist

Before considering a physics animation complete, check:

* [ ] Is the physical behavior actually useful?
* [ ] Is the correct `Simulation` being used?
* [ ] Does the animation need velocity?
* [ ] Is `AnimationController.unbounded()` appropriate?
* [ ] Is the controller created in `initState()`?
* [ ] Is the controller disposed?
* [ ] Is the animated subtree isolated?
* [ ] Are physics parameters tuned?
* [ ] Does the interaction feel natural?
* [ ] Does the animation stop correctly?
* [ ] Does it behave correctly after interruption?
* [ ] Does it work correctly with gestures?
* [ ] Has it been tested on a real device?

---

# 66. Recommended Learning Progression

Learn physics animations in this order:

```text
1. Understand AnimationController
          ↓
2. Understand animateWith()
          ↓
3. Understand Simulation
          ↓
4. SpringSimulation
          ↓
5. FrictionSimulation
          ↓
6. GravitySimulation
          ↓
7. Gesture + Physics
          ↓
8. Custom Simulation
          ↓
9. Advanced interactive physics
```

Do not start with custom simulations.

First understand the built-in simulations.

---

# 67. APIs to Remember

The most important APIs for this topic are:

```dart
AnimationController.unbounded()
```

```dart
controller.animateWith(simulation);
```

```dart
SpringSimulation(...)
```

```dart
GravitySimulation(...)
```

```dart
FrictionSimulation(...)
```

```dart
Simulation
```

And for gesture-driven physics:

```dart
DragStartDetails
DragUpdateDetails
DragEndDetails
```

especially:

```dart
details.velocity.pixelsPerSecond
```

---

# 68. Final Summary

Flutter physics animations allow you to create movement based on physical rules instead of only fixed durations and curves.

The four main concepts are:

## SpringSimulation

```text
Move toward a target
+
Spring behavior
+
Possible overshoot
+
Settling
```

## GravitySimulation

```text
Constant acceleration
+
Falling movement
```

## FrictionSimulation

```text
Initial velocity
+
Gradual slowdown
+
Momentum
```

## Custom Simulation

```text
Your own mathematical model
```

The most important API is:

```dart
controller.animateWith(simulation);
```

The most important architecture is:

```text
Initial State
     ↓
Position + Velocity
     ↓
Simulation
     ↓
AnimationController
     ↓
Widget
```

And when combined with gestures:

```text
User Gesture
     ↓
Position + Velocity
     ↓
Physics Simulation
     ↓
AnimationController
     ↓
Natural UI movement
```

The key distinction to remember is:

```text
Curves answer:

"How should the animation progress over time?"

Physics answers:

"How should the object behave based on physical conditions?"
```

Once you understand that distinction, `SpringSimulation`, `GravitySimulation`, `FrictionSimulation`, and custom simulations become much easier to choose and implement.
