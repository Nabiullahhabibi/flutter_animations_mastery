# Flutter Animation — 01: Animation Fundamentals & AnimatedContainer

## Learning Goal

This lesson introduces the fundamental concepts behind Flutter animation and then implements the first practical implicit animation: `AnimatedContainer`.

The goal is not only to make something move, but to understand **what is changing, why it changes, and how Flutter animates it**.

---

# 1. What Is Animation?

Animation is the process of changing a value over time.

In Flutter, many visual properties can change over time:

- position
- size
- color
- opacity
- padding
- alignment
- rotation
- scale
- decoration

For example, if a widget changes its width from `100` to `300`, Flutter can display the intermediate values:

```text
100 → 120 → 145 → 170 → 210 → 250 → 300
```

The user sees this continuous sequence as movement.

### Core idea

```text
Animation
    ↓
Value changes
    ↓
Over time
    ↓
Flutter renders updated frames
    ↓
The user perceives motion
```

Animation is therefore not a separate visual object. It is usually a **value that changes over time and drives rendering**.

---

# 2. Frames

A frame is one rendered image of the application at a particular moment.

Animation creates the illusion of continuous movement by producing many frames.

For example:

```text
Frame 1 → position = 0
Frame 2 → position = 10
Frame 3 → position = 20
Frame 4 → position = 30
Frame 5 → position = 40
...
```

At common refresh rates:

- 60 Hz ≈ 16.67 ms per frame
- 90 Hz ≈ 11.11 ms per frame
- 120 Hz ≈ 8.33 ms per frame

A smooth animation needs Flutter to keep up with the available frame budget.

### Important

Do not think:

> "Flutter moves the widget."

Think:

> "Flutter repeatedly renders the widget with different values."

That mental model becomes very important when learning explicit animations, custom painting, and shaders.

---

# 3. Duration

`Duration` defines how long an animation should take.

Example:

```dart
const Duration(milliseconds: 500)
```

means the transition should take approximately 500 milliseconds.

Common examples:

```dart
const Duration(milliseconds: 150)
const Duration(milliseconds: 300)
const Duration(milliseconds: 500)
const Duration(seconds: 1)
```

### Choosing duration

There is no universal correct duration.

A useful starting point:

| Interaction | Typical starting range |
|---|---:|
| Small UI feedback | 100–200 ms |
| Button/state transition | 200–300 ms |
| Card/size transition | 300–500 ms |
| Larger entrance animation | 400–700 ms |

These are starting points, not strict rules.

The animation should feel appropriate to the interaction.

---

# 4. Animation Value

An animation is often represented by a value that changes over time.

For example:

```text
0.0 → 0.1 → 0.2 → 0.3 → ... → 1.0
```

This is especially important with explicit animations.

The value can then be mapped to another range.

For example:

```text
Animation progress:
0.0 → 1.0

Width:
100 → 300
```

Conceptually:

```text
0.0 → 100
0.25 → 150
0.50 → 200
0.75 → 250
1.0 → 300
```

This concept becomes central when we later learn:

- `AnimationController`
- `Animation<T>`
- `Tween<T>`
- `Curves`
- `AnimatedBuilder`

---

# 5. Curves

A curve controls **how an animation progresses through time**.

Without a curve, the value can change linearly:

```text
0 ───────────────────→ 1
```

With an easing curve, the animation may start slowly, move quickly, and then slow down.

Common Flutter curves include:

```dart
Curves.linear
Curves.easeIn
Curves.easeOut
Curves.easeInOut
Curves.fastOutSlowIn
Curves.bounceOut
Curves.elasticOut
```

### Example

```dart
curve: Curves.easeInOut
```

The same start and end values can feel completely different depending on the curve.

### Important distinction

```text
Duration = how long
Curve    = how the value progresses during that time
```

---

# 6. Implicit Animations

An **implicit animation** is an animation where Flutter automatically animates between the old property value and the new property value.

You generally provide:

1. the new value
2. the duration
3. optionally, a curve

Flutter handles the interpolation and animation lifecycle for you.

Conceptually:

```text
Old value
   ↓
New value
   ↓
Flutter calculates intermediate values
   ↓
Animated result
```

Example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  width: isExpanded ? 300 : 100,
)
```

When `isExpanded` changes, Flutter animates the width.

---

# 7. AnimatedContainer

`AnimatedContainer` is one of Flutter's most useful implicit animation widgets.

It is useful when a container's visual properties change and you want Flutter to animate those changes automatically.

It can animate properties such as:

- `width`
- `height`
- `padding`
- `margin`
- `alignment`
- `color`
- `decoration`
- `transform`
- and other supported properties

---

# 8. Basic AnimatedContainer Example

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  width: isExpanded ? 300 : 100,
  height: 100,
  color: isExpanded ? Colors.blue : Colors.grey,
)
```

Initially:

```text
width  = 100
color  = grey
```

After the state changes:

```text
width  = 300
color  = blue
```

Flutter animates between those states.

---

# 9. How This Example Works

The application contains a boolean state:

```dart
bool isExpanded = false;
```

When the button is pressed:

```dart
setState(() {
  isExpanded = !isExpanded;
});
```

Flutter rebuilds the widget tree.

The `AnimatedContainer` receives different property values.

Before:

```text
width = 100
color = grey
```

After:

```text
width = 300
color = blue
```

Because `AnimatedContainer` is an implicit animation widget, it interpolates between the old and new values.

---

# 10. What AnimatedContainer Does NOT Give You

`AnimatedContainer` is convenient, but it does not give the same level of manual control as an `AnimationController`.

For example, you generally do not directly control:

- animation progress
- manual `forward()`
- manual `reverse()`
- physics simulations
- complex synchronized timelines
- gesture-driven progress

For those situations, we will later use explicit animations.

### Rule

Use `AnimatedContainer` when:

> "A property changes and I simply want Flutter to animate from the old state to the new state."

Use `AnimationController` when:

> "I need direct control over the animation."

---

# 11. Senior-Level Mental Model

For this lesson, remember:

```text
State changes
     ↓
AnimatedContainer receives new values
     ↓
Flutter compares old and new values
     ↓
Flutter interpolates supported properties
     ↓
Frames are rendered during the duration
     ↓
The UI reaches the new state
```

This is the foundation for the rest of Flutter animation.

---

# 12. Example Included in This Lesson

The accompanying Dart file demonstrates:

- changing width
- changing height
- changing color
- changing border radius
- changing padding
- changing alignment
- changing the duration
- changing the curve
- triggering the animation with a button

The example is intentionally self-contained so it can be copied into an existing Flutter project.

---

# 13. Experiment With It

After running the example, change:

```dart
duration: const Duration(milliseconds: 500)
```

Try:

```dart
duration: const Duration(milliseconds: 150)
```

Then:

```dart
duration: const Duration(seconds: 1)
```

Try different curves:

```dart
Curves.linear
Curves.easeIn
Curves.easeOut
Curves.easeInOut
Curves.bounceOut
Curves.elasticOut
```

Then change:

```dart
width
height
padding
alignment
borderRadius
```

The goal is to observe how each property participates in the implicit animation.

---

# 14. When Should You Use AnimatedContainer?

Good use cases:

- expanding cards
- selected/unselected states
- buttons changing appearance
- animated borders
- animated padding
- animated sizes
- expanding/collapsing UI
- simple interactive UI feedback

Avoid using it when you need:

- manual animation progress
- physics
- gesture-controlled progress
- multiple complex animation timelines
- precise synchronization with another controller

Those topics come later.

---

# 15. Learning Progress

Current position:

```text
Flutter Animation
│
└── 1. Implicit Animations
    │
    └── AnimatedContainer ← YOU ARE HERE
```

Next:

```text
AnimatedOpacity
```

Then:

```text
AnimatedPositioned
AnimatedAlign
AnimatedPadding
AnimatedDefaultTextStyle
TweenAnimationBuilder
```

After completing implicit animations, we move to:

```text
2. Explicit Animations
```

with:

```text
AnimationController
Animation<T>
Tween
Curves
AnimatedBuilder
AnimatedWidget
AnimatedSwitcher
```

---

# 16. Key Takeaways

Remember these five concepts:

### 1. Animation

A value changes over time.

### 2. Frames

The screen displays many rendered states that create the perception of motion.

### 3. Duration

Controls how long the transition takes.

### 4. Animation value

Represents the changing state/progress that can drive a visual property.

### 5. Curve

Controls the timing/easing of that change.

And for this lesson:

```text
Implicit Animation
       ↓
AnimatedContainer
       ↓
Old value → New value
       ↓
Flutter animates automatically
```

---

# 17. First Senior Rule of Flutter Animation

**Start with the simplest animation abstraction that solves the problem.**

If `AnimatedContainer` is enough, don't immediately create an `AnimationController`.

As the requirements become more complex, move toward:

```text
Implicit
   ↓
TweenAnimationBuilder
   ↓
AnimationController
   ↓
Gesture / Physics
   ↓
CustomPainter
   ↓
Shader / Custom Rendering
```

That progression keeps your code easier to understand, maintain, and optimize.
