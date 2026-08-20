# AnimatedAlign — Flutter Animation Mastery

> **Category:** Implicit Animations
> **Widget:** `AnimatedAlign`
> **Difficulty:** Intermediate → Senior
> **Prerequisites:** `AnimatedContainer`, Flutter layout system, `Alignment`

---

# 1. What is AnimatedAlign?

`AnimatedAlign` is an **implicit animation widget** that automatically animates changes to the `alignment` of its child.

Instead of manually creating an `AnimationController`, `Tween`, and animation listener, you simply change the `alignment`.

Flutter detects the changed value and automatically animates from the old alignment to the new alignment.

Basic example:

```dart
AnimatedAlign(
  alignment: Alignment.centerLeft,
  duration: const Duration(milliseconds: 500),
  child: const FlutterLogo(),
)
```

When the alignment changes:

```dart
alignment: Alignment.centerRight
```

Flutter automatically animates the child from the left side to the right side.

---

# 2. Where AnimatedAlign Fits in Flutter Animation

The Flutter animation system can be broadly organized like this:

```text
Flutter Animations
│
├── Implicit Animations
│   │
│   ├── AnimatedContainer
│   ├── AnimatedAlign
│   ├── AnimatedOpacity
│   ├── AnimatedPadding
│   ├── AnimatedPositioned
│   ├── AnimatedScale
│   ├── AnimatedRotation
│   └── ...
│
└── Explicit Animations
    │
    ├── AnimationController
    ├── Tween
    ├── Curves
    ├── AnimatedBuilder
    └── ...
```

`AnimatedAlign` belongs to:

```text
Implicit Animation
        ↓
AnimatedAlign
        ↓
Animate child's position inside its parent's available space
```

---

# 3. The Core Idea

The most important thing to understand is:

> `AnimatedAlign` does not directly animate the child's `x` and `y` coordinates.

Instead, it animates an **alignment value**.

For example:

```dart
Alignment.centerLeft
```

to:

```dart
Alignment.centerRight
```

Flutter calculates the child's position based on:

1. Parent's available size
2. Child's size
3. Current alignment
4. Alignment interpolation

Conceptually:

```text
Parent
┌─────────────────────────────────────┐
│                                     │
│  Child                              │
│  ┌──────┐                           │
│  │      │                           │
│  └──────┘                           │
│                                     │
└─────────────────────────────────────┘
```

Change:

```text
centerLeft
```

to:

```text
centerRight
```

and Flutter animates the child across the available space.

---

# 4. Basic Syntax

```dart
AnimatedAlign(
  alignment: Alignment.center,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: child,
)
```

The most important properties are:

| Property       | Purpose                                  |
| -------------- | ---------------------------------------- |
| `alignment`    | Determines where the child is positioned |
| `duration`     | Determines how long the animation takes  |
| `curve`        | Controls the animation's motion          |
| `widthFactor`  | Controls width based on child size       |
| `heightFactor` | Controls height based on child size      |
| `onEnd`        | Called when the animation completes      |
| `child`        | Widget being aligned                     |

---

# 5. Alignment

`alignment` is the most important property.

Flutter provides predefined alignments.

```dart
Alignment.topLeft
Alignment.topCenter
Alignment.topRight

Alignment.centerLeft
Alignment.center
Alignment.centerRight

Alignment.bottomLeft
Alignment.bottomCenter
Alignment.bottomRight
```

Visual representation:

```text
┌─────────────────────────────────────┐
│ topLeft     topCenter     topRight  │
│                                     │
│ centerLeft  center       centerRight│
│                                     │
│ bottomLeft bottomCenter bottomRight │
└─────────────────────────────────────┘
```

---

# 6. Alignment Coordinates

Flutter's `Alignment` uses a coordinate system based on the center.

```text
(-1, -1)                 (1, -1)
   top-left                top-right

                (0, 0)
                center

(-1, 1)                  (1, 1)
 bottom-left             bottom-right
```

Therefore:

```dart
Alignment(-1, -1)
```

means:

```text
Top Left
```

and:

```dart
Alignment(1, 1)
```

means:

```text
Bottom Right
```

while:

```dart
Alignment(0, 0)
```

means:

```text
Center
```

---

# 7. Custom Alignment

You are not limited to the predefined constants.

You can create:

```dart
Alignment(-0.5, 0)
```

or:

```dart
Alignment(0.5, -0.2)
```

For example:

```dart
AnimatedAlign(
  alignment: Alignment(0.5, -0.2),
  duration: const Duration(milliseconds: 500),
  child: const FlutterLogo(),
)
```

This gives you more precise positioning.

---

# 8. Alignment Interpolation

One of the most important senior-level concepts is that Flutter can interpolate between alignments.

Suppose we animate:

```dart
Alignment.centerLeft
```

to:

```dart
Alignment.centerRight
```

Conceptually:

```text
-1.0
 ↓
-0.5
 ↓
 0.0
 ↓
 0.5
 ↓
 1.0
```

The animation continuously changes the alignment value.

This is why the child appears to smoothly move.

---

# 9. Duration

`duration` controls how long the transition takes.

Example:

```dart
duration: const Duration(milliseconds: 300)
```

Short:

```dart
Duration(milliseconds: 150)
```

Medium:

```dart
Duration(milliseconds: 300)
```

Slow:

```dart
Duration(milliseconds: 800)
```

Very slow:

```dart
Duration(seconds: 2)
```

Typical UI animations often use something around:

```text
150–300 ms
```

but the correct value depends on the interaction.

---

# 10. Curve

The curve controls how the animation progresses through time.

Example:

```dart
curve: Curves.easeInOut
```

Common curves:

```dart
Curves.linear
Curves.easeIn
Curves.easeOut
Curves.easeInOut
Curves.fastOutSlowIn
Curves.easeOutCubic
Curves.easeOutBack
```

Example:

```dart
AnimatedAlign(
  alignment: alignment,
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeOutCubic,
  child: child,
)
```

---

# 11. Curve Comparison

### Linear

```dart
Curves.linear
```

Motion is constant.

```text
───────
```

Useful for:

* progress-like motion
* mechanical movement

---

### Ease In

```dart
Curves.easeIn
```

Starts slowly and accelerates.

Useful for:

* elements leaving the screen
* exit-style movement

---

### Ease Out

```dart
Curves.easeOut
```

Starts quickly and slows down.

Useful for:

* elements entering
* buttons
* cards
* menus

---

### Ease In Out

```dart
Curves.easeInOut
```

Starts slowly, accelerates, then slows.

Useful for:

* general UI transitions

---

### Ease Out Back

```dart
Curves.easeOutBack
```

Creates an overshoot effect.

Useful for:

* playful UI
* badges
* notifications
* selected indicators

Use carefully in professional interfaces.

---

# 12. The Child

The child is the widget whose position changes.

Example:

```dart
AnimatedAlign(
  alignment: Alignment.centerRight,
  duration: const Duration(milliseconds: 500),
  child: Container(
    width: 100,
    height: 100,
  ),
)
```

The child itself is not necessarily resized.

Its **position inside the available parent space** changes.

---

# 13. Parent Constraints Matter

This is one of the most important concepts.

`AnimatedAlign` needs available space to position its child.

For example:

```dart
SizedBox(
  width: double.infinity,
  height: 300,
  child: AnimatedAlign(
    alignment: Alignment.centerRight,
    duration: const Duration(milliseconds: 500),
    child: ...
  ),
)
```

The parent provides a large area.

Therefore the child can move.

Conceptually:

```text
Parent
┌───────────────────────────────────────┐
│                                       │
│                              Child    │
│                              ┌────┐   │
│                              │    │   │
│                              └────┘   │
│                                       │
└───────────────────────────────────────┘
```

If the parent is only as large as the child, there may be little or no space for movement.

---

# 14. AnimatedAlign vs Positioned

These widgets are related but solve different problems.

## AnimatedAlign

Use when:

> I want to align a child inside available space.

Example:

```dart
AnimatedAlign(
  alignment: Alignment.centerRight,
  duration: const Duration(milliseconds: 400),
  child: child,
)
```

---

## AnimatedPositioned

Use when:

> I need explicit positional control inside a `Stack`.

Example:

```dart
AnimatedPositioned(
  left: 20,
  top: 50,
  duration: const Duration(milliseconds: 400),
  child: child,
)
```

---

# 15. AnimatedAlign vs Transform.translate

Another important distinction.

### AnimatedAlign

Changes layout positioning.

```dart
AnimatedAlign(
  alignment: Alignment.centerRight,
  duration: const Duration(milliseconds: 400),
  child: child,
)
```

### Transform.translate

Visually translates the widget.

```dart
Transform.translate(
  offset: const Offset(50, 0),
  child: child,
)
```

Use `AnimatedAlign` when the concept is:

> "This widget should be aligned differently."

Use transforms when the concept is:

> "I need a visual translation."

---

# 16. AnimatedAlign vs AnimatedContainer

They can overlap.

`AnimatedContainer` can animate many layout properties.

`AnimatedAlign` is specifically focused on alignment.

For example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 400),
  alignment: Alignment.centerRight,
  child: child,
)
```

can accomplish a similar alignment animation.

But:

```dart
AnimatedAlign(...)
```

communicates the intent more clearly when alignment is the main thing being animated.

Senior-level principle:

> Prefer the widget whose API communicates the actual design intent.

---

# 17. widthFactor

`widthFactor` controls how the `AnimatedAlign` sizes itself relative to its child.

Example:

```dart
AnimatedAlign(
  alignment: Alignment.center,
  widthFactor: 1,
  duration: const Duration(milliseconds: 400),
  child: child,
)
```

A value of:

```dart
1
```

means the width is based on the child's width.

You can animate this value as well.

Example:

```dart
AnimatedAlign(
  alignment: alignment,
  widthFactor: expanded ? 1.0 : 0.0,
  duration: const Duration(milliseconds: 400),
  child: child,
)
```

However, this is a specialized layout technique and should not automatically be used for every expand/collapse animation.

---

# 18. heightFactor

The same concept applies vertically.

```dart
AnimatedAlign(
  heightFactor: 1,
  alignment: alignment,
  duration: const Duration(milliseconds: 400),
  child: child,
)
```

This can be useful when the widget's size should depend on its child.

---

# 19. AlignmentDirectional

For internationalized applications, consider:

```dart
AlignmentDirectional
```

instead of hard-coding left and right.

Example:

```dart
AlignmentDirectional.centerStart
```

and:

```dart
AlignmentDirectional.centerEnd
```

This is especially useful for RTL languages.

Instead of:

```dart
Alignment.centerLeft
```

you can use:

```dart
AlignmentDirectional.centerStart
```

This means:

```text
LTR → left

RTL → right
```

This is an important production-level consideration.

---

# 20. Why AlignmentDirectional Matters

Suppose your application supports:

```text
English
Arabic
Persian
```

If you write:

```dart
Alignment.centerLeft
```

you explicitly mean the physical left side.

If you write:

```dart
AlignmentDirectional.centerStart
```

you mean the logical start side.

That allows the UI to adapt to text direction.

Senior rule:

> Use directional alignment when the design concept is "start/end" rather than physically "left/right."

---

# 21. Real-World Usage #1 — Animated Toggle

A very common pattern is a custom toggle.

```text
OFF

┌────────────────────┐
│ ●                  │
└────────────────────┘

ON

┌────────────────────┐
│                  ● │
└────────────────────┘
```

`AnimatedAlign` moves the knob.

This is useful for:

* settings
* dark mode
* notifications
* privacy switches
* feature toggles

---

# 22. Real-World Usage #2 — Notification Badge

A badge can move from:

```text
top-left
```

to:

```text
top-right
```

or appear at different positions.

Useful for:

* unread notifications
* shopping cart counts
* message counts
* status indicators

---

# 23. Real-World Usage #3 — Avatar Position

An avatar can transition between:

```text
center
```

and:

```text
top-left
```

For example:

```text
Before

┌────────────────────────┐
│                        │
│         Avatar         │
│                        │
└────────────────────────┘


After

┌────────────────────────┐
│ Avatar                 │
│                        │
│                        │
└────────────────────────┘
```

This is useful for:

* profile headers
* onboarding
* authentication screens
* dashboard layouts

---

# 24. Real-World Usage #4 — Login Screen

A login form can initially be centered.

After an interaction, it can move toward the top.

```text
Before:

        Login Form


After:

   Login Form

   Email
   Password
   Button
```

This can create a more dynamic onboarding experience.

---

# 25. Real-World Usage #5 — Empty State

An empty-state illustration can move between:

```text
center
```

and:

```text
top
```

while content appears below it.

This is useful for:

* no search results
* empty shopping cart
* no messages
* no notifications
* no projects

---

# 26. Real-World Usage #6 — Chat Bubble

A chat bubble can be aligned differently depending on message ownership.

For example:

```text
                Hello
                ┌───────────┐
                │ Hi        │
                └───────────┘
```

and:

```text
┌───────────┐
│ Hello     │
└───────────┘
```

For complex chat layouts, `Row`, `Column`, and `Align` are often more appropriate, but `AnimatedAlign` can be useful for animated message transitions.

---

# 27. Real-World Usage #7 — Sliding Action Button

A floating action element can move between:

```text
bottomCenter
```

and:

```text
bottomRight
```

Useful for:

* responsive navigation
* expandable action buttons
* contextual actions
* mobile dashboards

---

# 28. Real-World Usage #8 — Expandable Menu

A menu button can transition between:

```text
center
```

and:

```text
topRight
```

while menu content changes.

For a full menu animation, `AnimatedAlign` is often combined with:

```dart
AnimatedOpacity
AnimatedContainer
AnimatedScale
```

---

# 29. Real-World Usage #9 — Selected Tab Indicator

You can use alignment-based movement for a custom indicator.

Conceptually:

```text
Home    Search    Profile

────
```

The indicator moves when the selected tab changes.

For production tab indicators, Flutter's existing tab/navigation APIs may be more appropriate, but `AnimatedAlign` is excellent for learning and custom UI components.

---

# 30. Real-World Usage #10 — Onboarding

An onboarding screen can move an illustration:

```text
center
```

to:

```text
topCenter
```

while text and buttons appear.

This can create a polished transition between onboarding states.

---

# 31. Real-World Usage #11 — Dashboard Cards

A dashboard card can change its internal alignment based on state.

For example:

```text
Normal:

[ Icon        ]

[ Title       ]


Expanded:

[             ]
[        Icon ]

[        Title]
```

`AnimatedAlign` can handle the internal positioning.

---

# 32. Real-World Usage #12 — Loading UI

A loading indicator can move between positions.

Example:

```text
[Button]
```

then:

```text
[   Loading...   ]
```

For sophisticated loading states, combine:

```text
AnimatedAlign
+
AnimatedOpacity
+
AnimatedSize
```

---

# 33. Real-World Usage #13 — Search Interface

A search icon can transition toward the search field.

For example:

```text
Before:

[ Search ]

After:

[ Search field                  ]
```

`AnimatedAlign` can help position elements during the transition.

For complex search animations, it should usually be combined with other animation widgets.

---

# 34. Real-World Usage #14 — Login / Signup Mode

A card can contain elements whose alignment changes when switching between:

```text
Login
```

and:

```text
Register
```

This can create smooth transitions without immediately rebuilding a completely different layout.

---

# 35. Real-World Usage #15 — Profile Header

An application may start with:

```text
Large centered avatar
```

and transition to:

```text
Small avatar at the start
```

as the user scrolls.

Important:

`AnimatedAlign` alone does not detect scrolling.

You would combine it with:

```dart
ScrollController
```

or another state source.

---

# 36. Combining AnimatedAlign with AnimatedContainer

This is one of the most useful combinations.

```dart
AnimatedAlign(
  alignment: alignment,
  duration: const Duration(milliseconds: 500),
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    width: expanded ? 200 : 100,
    height: expanded ? 200 : 100,
    decoration: ...,
    child: ...,
  ),
)
```

Now:

```text
Position
+
Size
+
Decoration
```

can animate together.

---

# 37. Combining AnimatedAlign with AnimatedOpacity

Example:

```dart
AnimatedAlign(
  alignment: alignment,
  duration: const Duration(milliseconds: 500),
  child: AnimatedOpacity(
    opacity: visible ? 1 : 0,
    duration: const Duration(milliseconds: 300),
    child: child,
  ),
)
```

This allows:

```text
Move
+
Fade
```

at the same time.

Useful for:

* menus
* notifications
* onboarding
* empty states
* contextual actions

---

# 38. Combining AnimatedAlign with AnimatedScale

Example:

```dart
AnimatedAlign(
  alignment: alignment,
  duration: const Duration(milliseconds: 500),
  child: AnimatedScale(
    scale: selected ? 1.1 : 1,
    duration: const Duration(milliseconds: 300),
    child: child,
  ),
)
```

Now you can create:

```text
Move
+
Scale
```

Useful for:

* selected cards
* avatars
* badges
* dashboard widgets

---

# 39. Combining Multiple Implicit Animations

A powerful pattern is:

```text
AnimatedAlign
      +
AnimatedContainer
      +
AnimatedOpacity
      +
AnimatedScale
```

Example:

```dart
AnimatedAlign(
  alignment: alignment,
  duration: const Duration(milliseconds: 500),
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    child: AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 300),
        child: child,
      ),
    ),
  ),
)
```

This is excellent for simple state-driven UI animations.

However, don't automatically stack many animation widgets.

If the animation becomes complex, move to explicit animations.

---

# 40. AnimatedAlign and State

`AnimatedAlign` does not create state for you.

Your state determines the target alignment.

Example:

```dart
bool isRight = false;
```

Then:

```dart
alignment: isRight
    ? Alignment.centerRight
    : Alignment.centerLeft,
```

When:

```dart
setState(() {
  isRight = !isRight;
});
```

Flutter automatically animates.

The important mental model is:

```text
State changes
      ↓
Target alignment changes
      ↓
AnimatedAlign detects change
      ↓
Animation starts
      ↓
Widget rebuilds during animation
      ↓
New position
```

---

# 41. No AnimationController Required

With `AnimatedAlign`, you don't need:

```dart
AnimationController
```

You don't need:

```dart
TickerProviderStateMixin
```

You don't need:

```dart
Tween<Alignment>
```

You don't need:

```dart
AnimatedBuilder
```

for a simple alignment animation.

This is why it is called an **implicit animation**.

---

# 42. What Happens Internally?

Conceptually:

```text
Your State
   │
   │ changes alignment
   ▼
AnimatedAlign
   │
   │ compares old/new properties
   ▼
Implicit animation machinery
   │
   ▼
Alignment interpolation
   │
   ▼
Animated frames
   │
   ▼
Render/layout update
   │
   ▼
Child moves
```

You don't manually control every frame.

Flutter manages the transition.

---

# 43. Performance

`AnimatedAlign` is generally appropriate for normal UI transitions.

However, alignment changes affect layout.

That means you should understand the difference between:

```text
Layout animation
```

and:

```text
Paint/transform animation
```

If you need extremely high-frequency or complex motion, consider whether a transform-based or explicit animation is more appropriate.

---

# 44. Avoid Unnecessary Rebuilds

Don't rebuild an entire large application just to change one alignment.

Prefer a small animation subtree.

Bad architecture:

```text
Huge screen
   ↓
setState()
   ↓
everything rebuilds
```

Better:

```text
Small stateful widget
   ↓
AnimatedAlign
   ↓
only relevant subtree changes
```

---

# 45. AnimatedAlign in Lists

Be careful when using animated widgets inside lists.

For example:

```dart
ListView.builder(...)
```

If every item contains multiple animations, you can increase:

* layout work
* build work
* memory usage

For large lists, keep animations localized and avoid unnecessary simultaneous animations.

---

# 46. Keys and AnimatedAlign

Keys become important when animated children are dynamic.

For example:

```dart
ValueKey(item.id)
```

can help Flutter correctly identify list items.

This is especially important when:

```text
items reorder
items are inserted
items are removed
children change
```

`AnimatedAlign` itself doesn't eliminate the need for correct widget identity.

---

# 47. Accessibility

Animations should not interfere with usability.

Consider users who prefer reduced motion.

For production applications, consider:

```dart
MediaQuery.of(context).disableAnimations
```

when appropriate for the Flutter version/API available in your project.

You can reduce or disable non-essential animations.

---

# 48. Responsive Design

Don't hard-code alignment movement based on assumptions about screen size.

Instead, consider:

```text
LayoutBuilder
MediaQuery
responsive breakpoints
```

Example:

```dart
final isSmallScreen = constraints.maxWidth < 600;
```

Then your target alignment can adapt.

---

# 49. AnimatedAlign in Responsive UI

Example concept:

```text
Mobile:

center


Tablet:

centerRight


Desktop:

topRight
```

The state determines the appropriate alignment.

This is useful for:

* dashboards
* responsive cards
* adaptive toolbars
* desktop/mobile layouts

---

# 50. RTL Considerations

For multilingual applications:

Prefer:

```dart
AlignmentDirectional.centerStart
AlignmentDirectional.centerEnd
```

when the design is based on logical direction.

Avoid unnecessarily hard-coding:

```dart
Alignment.centerLeft
Alignment.centerRight
```

if the UI must mirror for RTL.

---

# 51. Common Mistake #1 — Expecting Movement Without Space

This:

```dart
AnimatedAlign(
  alignment: Alignment.centerRight,
  duration: const Duration(milliseconds: 500),
  child: Container(
    width: 100,
    height: 100,
  ),
)
```

may not visibly move if the parent doesn't provide enough space.

Remember:

> Alignment needs available space.

---

# 52. Common Mistake #2 — Using AnimatedAlign for Everything

Not every movement should use `AnimatedAlign`.

Use:

```text
AnimatedAlign
```

when alignment is the conceptual requirement.

Use:

```text
AnimatedPositioned
```

when you need explicit Stack positioning.

Use:

```text
Transform
```

when you need visual translation.

Use:

```text
AnimationController
```

when you need precise animation control.

---

# 53. Common Mistake #3 — Ignoring Directionality

For international applications:

```dart
AlignmentDirectional.centerStart
```

is often better than:

```dart
Alignment.centerLeft
```

when the meaning is "start".

---

# 54. Common Mistake #4 — Overusing Long Durations

Avoid:

```dart
Duration(seconds: 3)
```

for normal buttons or controls.

Long animations can make applications feel slow.

Use durations appropriate to the interaction.

---

# 55. Common Mistake #5 — Using It Instead of Layout Architecture

`AnimatedAlign` should not replace proper layout widgets.

Use:

```text
Row
Column
Flex
Wrap
Stack
Expanded
Flexible
Positioned
Align
```

for layout.

Use `AnimatedAlign` when you actually need animated alignment.

---

# 56. AnimatedAlign vs Align

Normal:

```dart
Align(
  alignment: Alignment.center,
  child: child,
)
```

Animated:

```dart
AnimatedAlign(
  alignment: alignment,
  duration: const Duration(milliseconds: 300),
  child: child,
)
```

The difference is:

```text
Align
→ immediate position change

AnimatedAlign
→ animated position change
```

---

# 57. AnimatedAlign vs AnimatedPositioned

| Feature            | AnimatedAlign         | AnimatedPositioned   |
| ------------------ | --------------------- | -------------------- |
| Parent             | General layout        | `Stack`              |
| Position model     | Alignment             | Explicit edges       |
| Left/right         | Alignment             | `left` / `right`     |
| Top/bottom         | Alignment             | `top` / `bottom`     |
| Great for          | Alignment transitions | Stack-based movement |
| Implicit animation | Yes                   | Yes                  |

---

# 58. AnimatedAlign vs Transform

| Feature                     | AnimatedAlign | Transform  |
| --------------------------- | ------------- | ---------- |
| Changes layout              | Yes           | No         |
| Alignment-based             | Yes           | No         |
| Explicit offset             | No            | Yes        |
| Good for visual motion      | Sometimes     | Yes        |
| Good for layout transitions | Yes           | Usually no |

---

# 59. When Should You Use AnimatedAlign?

Use it when:

```text
The child needs to move between alignment positions.
```

Excellent examples:

* custom switches
* animated badges
* onboarding layouts
* profile headers
* empty states
* custom indicators
* contextual buttons
* responsive cards
* expandable UI
* dashboard components

---

# 60. When Should You NOT Use AnimatedAlign?

Avoid it when:

```text
You need precise x/y positioning.
```

Use:

```dart
AnimatedPositioned
```

when working inside a `Stack`.

Avoid it when:

```text
You need physics-based movement.
```

Consider:

```text
AnimationController
SpringSimulation
Physics-based animations
```

Avoid it when:

```text
You need a complicated timeline.
```

Use explicit animations.

---

# 61. Senior Mental Model

Think about `AnimatedAlign` like this:

```text
                Parent
                  │
                  ▼
             Available Space
                  │
                  ▼
             Alignment
                  │
                  ▼
             Child Position
                  │
                  ▼
             Animated Transition
```

The key question should always be:

> "Is the thing I am animating conceptually an alignment?"

If yes:

```text
AnimatedAlign
```

is often a good candidate.

---

# 62. Complete Mental Model

```text
State
 │
 ├── left
 ├── center
 ├── right
 └── custom Alignment
        │
        ▼
AnimatedAlign
        │
        ├── duration
        ├── curve
        ├── widthFactor
        └── heightFactor
        │
        ▼
Alignment interpolation
        │
        ▼
Layout
        │
        ▼
Child moves
```

---

# 63. Learning Exercises

After implementing the demo, build these yourself.

### Exercise 1

Create:

```text
Left → Center → Right
```

movement.

### Exercise 2

Create:

```text
TopLeft
→
Center
→
BottomRight
```

movement.

### Exercise 3

Create a custom toggle.

### Exercise 4

Create a notification badge that moves.

### Exercise 5

Create an onboarding screen where the illustration moves from center to top.

### Exercise 6

Create a profile avatar that moves from center to top-left.

### Exercise 7

Create an RTL-aware start/end animation.

### Exercise 8

Combine:

```text
AnimatedAlign
+
AnimatedOpacity
```

### Exercise 9

Combine:

```text
AnimatedAlign
+
AnimatedScale
```

### Exercise 10

Combine:

```text
AnimatedAlign
+
AnimatedContainer
+
AnimatedOpacity
+
AnimatedScale
```

---

# 64. Production Checklist

Before using `AnimatedAlign` in production, ask:

* Is alignment really the correct animation model?
* Does the parent provide enough space?
* Is the duration appropriate?
* Is the curve appropriate?
* Does the animation work on small screens?
* Does it work in RTL?
* Is the animated subtree small?
* Are there many simultaneous animations?
* Does the animation respect accessibility requirements?
* Would `AnimatedPositioned` be more appropriate?
* Would `Transform` be more appropriate?
* Would an explicit animation provide better control?

---

# 65. Final Summary

`AnimatedAlign` is an implicit animation widget designed to animate a child's alignment inside its available space.

The essential API is:

```dart
AnimatedAlign(
  alignment: Alignment.center,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: child,
)
```

The most important concepts are:

```text
AnimatedAlign
│
├── alignment
├── duration
├── curve
├── widthFactor
├── heightFactor
├── onEnd
└── child
```

The most important senior-level distinction is:

```text
AnimatedAlign
    ↓
alignment-based layout animation

AnimatedPositioned
    ↓
explicit Stack positioning animation

Transform.translate
    ↓
visual translation

AnimationController
    ↓
full animation control
```

Mastering these distinctions is more important than simply memorizing the widget API.

---

# 66. What You Should Be Able to Do After This Lesson

You should now be able to:

1. Explain what `AnimatedAlign` does.
2. Explain why it is an implicit animation.
3. Use all major alignment values.
4. Create custom `Alignment` values.
5. Explain alignment coordinates.
6. Choose appropriate durations.
7. Choose appropriate curves.
8. Understand parent constraints.
9. Use `widthFactor`.
10. Use `heightFactor`.
11. Understand `AlignmentDirectional`.
12. Build RTL-aware animations.
13. Build custom toggles.
14. Animate badges.
15. Animate avatars.
16. Animate onboarding layouts.
17. Animate empty states.
18. Animate dashboard components.
19. Combine `AnimatedAlign` with other implicit animations.
20. Decide when **not** to use `AnimatedAlign`.

---

# 67. Next Topic

After mastering:

```text
AnimatedContainer
AnimatedAlign
```

the next implicit animation should be:

```text
AnimatedOpacity
```

This introduces another fundamental animation concept:

```text
Visual visibility
        ↓
Opacity
        ↓
Fade in / Fade out
```

Then you can begin combining:

```text
AnimatedAlign
+
AnimatedOpacity
+
AnimatedContainer
```

to build much more realistic UI transitions.
