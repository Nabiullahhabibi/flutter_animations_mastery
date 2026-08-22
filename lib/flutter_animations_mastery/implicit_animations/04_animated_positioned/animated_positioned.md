# AnimatedPositioned — Flutter Animation Mastery

> Flutter Animation Mastery — Implicit Animations

---

## 1. Overview

`AnimatedPositioned` is an **implicit animation widget** that automatically animates changes to a child's position and size inside a `Stack`.

It is particularly useful when an element needs to move from one position to another without manually creating an `AnimationController`.

Instead of writing:

```dart
AnimationController
Animation
Tween
AnimatedBuilder
```

you can simply change properties such as:

```dart
left
right
top
bottom
width
height
```

and Flutter automatically animates between the old and new values.

Basic example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: isSelected ? 200 : 20,
  top: 100,
  child: const MyWidget(),
)
```

When `isSelected` changes, Flutter automatically interpolates the `left` value.

---

# 2. What Problem Does AnimatedPositioned Solve?

Suppose you have a widget inside a `Stack`:

```dart
Stack(
  children: [
    Positioned(
      left: 20,
      top: 100,
      child: Container(),
    ),
  ],
)
```

If you change:

```dart
left: 20
```

to:

```dart
left: 200
```

the widget immediately jumps.

There is no animation.

With `AnimatedPositioned`:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: isMoved ? 200 : 20,
  top: 100,
  child: Container(),
)
```

Flutter automatically animates:

```text
20 ───────────────────────► 200
        animation
```

This is the main purpose of `AnimatedPositioned`.

---

# 3. AnimatedPositioned Classification

`AnimatedPositioned` belongs to Flutter's implicit animation family.

The hierarchy is conceptually:

```text
Flutter Animations
│
├── Implicit Animations
│   │
│   ├── AnimatedContainer
│   ├── AnimatedOpacity
│   ├── AnimatedPositioned
│   ├── AnimatedAlign
│   ├── AnimatedPadding
│   ├── AnimatedDefaultTextStyle
│   └── TweenAnimationBuilder
│
└── Explicit Animations
    │
    ├── AnimationController
    ├── Animation
    ├── Tween
    ├── Curves
    └── AnimatedBuilder
```

`AnimatedPositioned` is therefore an **implicit animation**.

---

# 4. Basic Syntax

The basic API looks like this:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  left: 20,
  top: 50,
  right: null,
  bottom: null,
  width: 100,
  height: 100,
  child: Container(),
)
```

The most important properties are:

```dart
duration
curve
left
right
top
bottom
width
height
child
```

---

# 5. The Most Important Concept

`AnimatedPositioned` only makes sense when its child is inside a `Stack`.

Example:

```dart
Stack(
  children: [
    AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: 20,
      top: 100,
      child: Container(
        width: 100,
        height: 100,
      ),
    ),
  ],
)
```

Think of the relationship as:

```text
Stack
 │
 └── AnimatedPositioned
       │
       └── Child
```

The `Stack` provides the coordinate space.

---

# 6. Understanding Positioned

Before understanding `AnimatedPositioned`, you should understand `Positioned`.

Example:

```dart
Stack(
  children: [
    Positioned(
      left: 20,
      top: 50,
      child: Container(
        width: 100,
        height: 100,
      ),
    ),
  ],
)
```

This means:

```text
Stack
┌──────────────────────────────┐
│                              │
│   ┌──────────┐               │
│   │          │               │
│   │  Widget  │               │
│   │          │               │
│   └──────────┘               │
│                              │
└──────────────────────────────┘
    ↑
    left = 20
```

`Positioned` controls the child's position relative to the `Stack`.

---

# 7. Positioned vs AnimatedPositioned

The difference is simple.

## Positioned

```dart
Positioned(
  left: isMoved ? 200 : 20,
  child: widget,
)
```

The widget jumps.

```text
20 ────────────────► 200
       JUMP
```

## AnimatedPositioned

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: isMoved ? 200 : 20,
  child: widget,
)
```

The widget animates.

```text
20 → 40 → 70 → 100 → 140 → 170 → 200
```

---

# 8. How AnimatedPositioned Works

Suppose:

```dart
left: 20
```

changes to:

```dart
left: 220
```

Flutter internally interpolates between these values.

Conceptually:

```text
Start
left = 20

      ↓

left = 60

      ↓

left = 100

      ↓

left = 140

      ↓

left = 180

      ↓

End
left = 220
```

You don't manually calculate these values.

Flutter does it for you.

---

# 9. Duration

`duration` controls how long the animation takes.

Example:

```dart
duration: const Duration(milliseconds: 500)
```

Means:

```text
500 milliseconds
=
0.5 seconds
```

Fast animation:

```dart
duration: const Duration(milliseconds: 200)
```

Medium animation:

```dart
duration: const Duration(milliseconds: 400)
```

Slow animation:

```dart
duration: const Duration(milliseconds: 800)
```

---

# 10. Choosing Duration

Typical UI animations might use approximately:

```text
150–250 ms
    ↓
small interaction

250–400 ms
    ↓
normal UI transition

400–600 ms
    ↓
larger movement

600ms+
    ↓
special / decorative animation
```

Do not blindly use long animations.

Animations should communicate something.

---

# 11. Curves

The `curve` determines how the animation progresses over time.

Example:

```dart
curve: Curves.easeInOut
```

Without a curve, movement may feel too mechanical.

Common curves:

```dart
Curves.linear
Curves.ease
Curves.easeIn
Curves.easeOut
Curves.easeInOut
Curves.fastOutSlowIn
Curves.decelerate
```

For UI movement, these are commonly useful:

```dart
Curves.easeOut
Curves.easeInOut
Curves.fastOutSlowIn
```

---

# 12. Understanding Curves

Imagine moving from:

```text
0 → 100
```

With `linear`:

```text
0 ── 20 ── 40 ── 60 ── 80 ── 100
```

The speed is approximately constant.

With `easeOut`:

```text
FAST ────────────────► SLOW
```

The widget moves quickly initially and slows near the destination.

This often feels natural for UI elements.

---

# 13. Position Properties

`AnimatedPositioned` supports:

```dart
left
right
top
bottom
```

These determine the position.

For example:

```dart
left: 20,
top: 50,
```

means:

```text
20 px from left
50 px from top
```

---

# 14. Width and Height

`AnimatedPositioned` can also animate:

```dart
width
height
```

Example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: 20,
  top: 100,
  width: expanded ? 300 : 100,
  height: expanded ? 300 : 100,
  child: ...
)
```

Now the widget can both:

```text
MOVE
+
RESIZE
```

This is extremely useful for interactive cards and expandable components.

---

# 15. Position + Size Animation

For example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: expanded ? 20 : 100,
  top: expanded ? 50 : 150,
  width: expanded ? 300 : 100,
  height: expanded ? 400 : 100,
  child: ...
)
```

The widget can transition from:

```text
small
   ↓
large
```

while also changing position.

---

# 16. Left and Right

You can position a widget using:

```dart
left
```

or:

```dart
right
```

For example:

```dart
right: 20,
```

means:

```text
Stack right edge
        │
        ▼
┌────────────────────────────┐
│                    Widget  │
│                       ↑    │
│                    20 px   │
└────────────────────────────┘
```

This is especially useful for:

* floating buttons
* badges
* notifications
* side panels

---

# 17. Top and Bottom

Similarly:

```dart
top: 20,
```

places the widget 20 pixels from the top.

```dart
bottom: 20,
```

places it 20 pixels from the bottom.

This is useful for:

* bottom sheets
* floating controls
* snackbars
* media controls
* overlays

---

# 18. Constraint Rules

A very important senior-level concept is that `Positioned` and `AnimatedPositioned` participate in the `Stack` layout system.

You should understand these combinations:

```text
left + top
left + bottom
right + top
right + bottom
left + right
top + bottom
```

For example:

```dart
left: 0,
right: 0,
```

allows the widget to stretch horizontally according to the available width.

Similarly:

```dart
top: 0,
bottom: 0,
```

allows vertical stretching.

---

# 19. Animating Width Through Constraints

Consider:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 400),
  left: 20,
  right: expanded ? 20 : 200,
  top: 100,
  child: ...
)
```

Changing `right` changes the available width.

This can produce a very useful expanding/collapsing effect.

---

# 20. Important: Not Everything Needs AnimatedPositioned

A common beginner mistake is using `AnimatedPositioned` for every movement.

For example, if you only need alignment:

```dart
AnimatedAlign
```

may be better.

If you need opacity:

```dart
AnimatedOpacity
```

may be better.

If you need general visual property changes:

```dart
AnimatedContainer
```

may be better.

Choose the widget based on the actual property being animated.

---

# 21. AnimatedPositioned vs AnimatedAlign

Use:

```dart
AnimatedAlign
```

when the concept is:

> Move this widget from one alignment to another.

Example:

```dart
AnimatedAlign(
  alignment: isLeft
      ? Alignment.centerLeft
      : Alignment.centerRight,
  duration: const Duration(milliseconds: 400),
  child: widget,
)
```

Use:

```dart
AnimatedPositioned
```

when the concept is:

> Position this widget using Stack coordinates.

---

# 22. AnimatedPositioned vs Transform

Another important distinction:

```dart
Transform.translate
```

changes the visual transformation of a widget.

`AnimatedPositioned` changes its position through the `Stack` layout system.

Conceptually:

```text
AnimatedPositioned
        ↓
Layout position
```

while:

```text
Transform.translate
        ↓
Visual transformation
```

This distinction becomes very important in advanced UI engineering.

---

# 23. AnimatedPositioned vs SlideTransition

`SlideTransition` is an explicit-animation transition widget.

It is useful when you already have an animation:

```dart
Animation<Offset>
```

Example:

```dart
SlideTransition(
  position: animation,
  child: widget,
)
```

Use `AnimatedPositioned` when you want a simpler state-driven movement.

Use `SlideTransition` when you need more control over the animation lifecycle.

---

# 24. Implicit Animation Mental Model

Think about `AnimatedPositioned` like this:

```text
State changes
     ↓
Properties change
     ↓
AnimatedPositioned detects change
     ↓
Flutter creates transition
     ↓
Old position → New position
     ↓
Widget rebuilds during animation
```

You describe:

```text
WHERE IT IS
```

and:

```text
WHERE IT SHOULD GO
```

Flutter handles the transition.

---

# 25. State Drives the Animation

A common pattern is:

```dart
bool isOpen = false;
```

Then:

```dart
AnimatedPositioned(
  left: isOpen ? 200 : 20,
  duration: const Duration(milliseconds: 400),
  child: widget,
)
```

When state changes:

```dart
setState(() {
  isOpen = true;
});
```

the animation automatically starts.

This is one of the most important concepts in implicit animations.

---

# 26. No AnimationController Required

You do NOT need:

```dart
AnimationController
```

You do NOT need:

```dart
TickerProviderStateMixin
```

You do NOT need:

```dart
Tween<double>
```

You do NOT need:

```dart
AnimatedBuilder
```

for basic `AnimatedPositioned` usage.

Example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 400),
  left: isOpen ? 200 : 20,
  child: widget,
)
```

That's enough.

---

# 27. Real-World Usage #1 — Sliding Side Panel

One of the most useful applications is a custom side panel.

Closed:

```text
┌──────────────────────────────┐
│                              │
│                              │
│                              │
└──────────────────────────────┘
```

Open:

```text
┌──────────────┬───────────────┐
│              │               │
│   SIDE       │   CONTENT     │
│   PANEL      │               │
│              │               │
└──────────────┴───────────────┘
```

You can animate:

```dart
left: isOpen ? 0 : -300
```

This is useful for:

* custom navigation drawers
* filter panels
* settings panels
* dashboard sidebars

---

# 28. Real-World Usage #2 — Floating Action Button Movement

Imagine a floating button that moves when another control opens.

Closed:

```text
                   ●
```

Open:

```text
                   ●
                   │
                   ●
                   │
                   ●
```

Each button can have a different `bottom` or `right` value.

Example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 300),
  bottom: isOpen ? 140 : 20,
  right: 20,
  child: actionButton,
)
```

Useful for:

* expandable FABs
* quick actions
* social actions
* contextual controls

---

# 29. Real-World Usage #3 — Expandable Card

A small card can become a larger card.

Collapsed:

```text
┌──────────────┐
│ Product      │
│ $20          │
└──────────────┘
```

Expanded:

```text
┌──────────────────────────────┐
│ Product                      │
│                              │
│ Description                  │
│                              │
│ Specifications               │
│                              │
│          BUY NOW             │
└──────────────────────────────┘
```

You can animate:

```dart
width
height
left
top
```

simultaneously.

This is useful for:

* product cards
* profile cards
* dashboard cards
* media cards
* information panels

---

# 30. Real-World Usage #4 — Notification Badge

Suppose a notification badge should move between locations.

```text
Normal:

🔔

Expanded:

🔔  ● 99
```

`AnimatedPositioned` can move the badge.

Useful for:

* notification counters
* cart badges
* unread indicators
* status indicators

---

# 31. Real-World Usage #5 — Image Gallery Selection

Imagine a horizontal image gallery.

When an image is selected:

```text
[ image ][ image ][ image ][ image ]
             ↑
          selected
```

The selected image can move or expand.

Example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 350),
  left: selected ? 100 : 20,
  width: selected ? 250 : 100,
  height: selected ? 250 : 100,
  child: image,
)
```

Useful for:

* photo galleries
* product image selectors
* onboarding screens
* portfolio interfaces

---

# 32. Real-World Usage #6 — Custom Bottom Sheet

You can create a simple bottom sheet using:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 400),
  left: 0,
  right: 0,
  bottom: isOpen ? 0 : -400,
  child: sheet,
)
```

Closed:

```text
┌──────────────────────┐
│                      │
│      CONTENT         │
│                      │
└──────────────────────┘
             ↑
        hidden sheet
```

Open:

```text
┌──────────────────────┐
│      CONTENT         │
├──────────────────────┤
│                      │
│    BOTTOM SHEET      │
│                      │
└──────────────────────┘
```

Useful for:

* custom action sheets
* filters
* product details
* media controls
* custom menus

For production applications, however, Flutter's built-in bottom-sheet APIs may be preferable when their behavior matches your requirements.

---

# 33. Real-World Usage #7 — Custom Snackbar

A snackbar-like component can enter from the bottom.

Hidden:

```dart
bottom: -100
```

Visible:

```dart
bottom: 20
```

Example:

```dart
AnimatedPositioned(
  duration: const Duration(milliseconds: 350),
  left: 20,
  right: 20,
  bottom: showMessage ? 20 : -100,
  child: message,
)
```

Useful when creating a custom notification system.

---

# 34. Real-World Usage #8 — Login Form Animation

You can position fields dynamically during transitions.

For example:

```text
Initial:

       LOGO

     Email
     Password

     Login
```

Then after an interaction:

```text
LOGO → moves upward

FORM → moves upward
```

Multiple `AnimatedPositioned` widgets can create coordinated UI movement.

---

# 35. Real-World Usage #9 — Onboarding Screens

Onboarding interfaces often contain:

```text
image
title
description
button
```

You can animate each element into different positions.

For example:

```text
Image
  ↓
Title
  ↓
Description
  ↓
Button
```

Each widget can have a different delay strategy when combined with more advanced animation techniques.

For simple state transitions, multiple implicit animations can work well.

---

# 36. Real-World Usage #10 — Game UI

`AnimatedPositioned` can be useful for simple game interface elements.

Examples:

* score badges
* health indicators
* floating messages
* power-up indicators
* menu panels
* pause overlays

However, it should not automatically be your choice for high-frequency game-object movement.

For game-loop-driven movement, a custom rendering/game framework or explicit animation architecture is usually more appropriate.

---

# 37. Real-World Usage #11 — Tutorial / Coach Marks

Suppose you want to highlight an element.

You can animate a highlight or information box:

```text
             ┌──────────────┐
             │  Tap here    │
             └──────┬───────┘
                    ↓
                 [Button]
```

`AnimatedPositioned` can move the instruction box between targets.

Useful for:

* tutorials
* walkthroughs
* feature discovery
* onboarding guides

---

# 38. Real-World Usage #12 — Context Menu

A contextual menu can appear near an item.

Closed:

```text
Item
```

Open:

```text
Item
 └── Edit
 └── Delete
 └── Share
```

You can animate the menu from:

```dart
top: originalPosition
```

to:

```dart
top: menuPosition
```

---

# 39. Real-World Usage #13 — Search Interface

A search field can expand or move when activated.

Initial:

```text
[ 🔍 Search ]
```

Active:

```text
[ ← ][ Search anything................ ]
```

`AnimatedPositioned` can help reposition surrounding elements while another widget expands.

---

# 40. Real-World Usage #14 — Media Player Controls

A media player might contain:

```text
video
play button
volume
progress
```

Controls can move into different positions when the player changes state.

For example:

```text
normal
    ↓
fullscreen
```

The controls can be repositioned accordingly.

---

# 41. Real-World Usage #15 — Dashboard Widgets

Dashboard cards can move between positions.

For example:

```text
┌───────┐ ┌───────┐
│ Card1 │ │ Card2 │
└───────┘ └───────┘
```

After selection:

```text
┌───────────────┐
│     Card1     │
│               │
└───────────────┘
┌───────┐
│ Card2 │
└───────┘
```

For more complex reordering layouts, however, consider `AnimatedSwitcher`, `AnimatedList`, `ReorderableListView`, or dedicated layout/animation solutions.

---

# 42. Real-World Usage #16 — Cart Animation

A product UI can visually move a product indicator toward a cart.

Conceptually:

```text
Product
   ●
    \
     \
      \
       🛒 Cart
```

For a simple UI demonstration, `AnimatedPositioned` can animate an element from one location to another.

For a sophisticated "add to cart" flight animation, explicit animations, overlays, and coordinate conversion may be more appropriate.

---

# 43. Real-World Usage #17 — Custom Navigation Animation

A custom navigation panel can slide between states.

For example:

```text
Page A
  ↓
Panel opens
  ↓
Page B
```

`AnimatedPositioned` can move an overlay or navigation container.

---

# 44. Real-World Usage #18 — Profile Header

A profile page can transition between:

```text
expanded header
```

and:

```text
collapsed header
```

Elements such as:

```text
avatar
name
buttons
cover image
```

can change position.

For complex collapsing app bars, however, Flutter's sliver system is usually a better architectural choice.

---

# 45. Real-World Usage #19 — Drag-and-Drop Interfaces

`AnimatedPositioned` can animate an object to a new location after a drag.

Example:

```text
Before:

[Object]                 [Target]


After:

                         [Object]
                         [Target]
```

The drag itself may be handled by:

```dart
GestureDetector
```

or:

```dart
Draggable
DragTarget
```

while `AnimatedPositioned` can animate the final state.

---

# 46. Real-World Usage #20 — Toggle Switches

A custom switch can move its thumb.

```text
OFF

┌────────────┐
│ ●          │
└────────────┘
```

ON:

```text
┌────────────┐
│          ● │
└────────────┘
```

For a custom switch, `AnimatedPositioned` can be used inside a `Stack`.

Flutter's built-in `Switch` should normally be preferred unless you need custom behavior/design.

---

# 47. Real-World Usage #21 — Segmented Controls

A sliding selection indicator can move between segments.

```text
┌───────┬───────┬───────┐
│  One  │  Two  │ Three │
└───────┴───────┴───────┘
    ▲
 indicator
```

When selection changes:

```text
       ┌───────┐
       │  Two  │
       └───────┘
```

The indicator can be animated with `AnimatedPositioned`.

This is an excellent practical use case.

---

# 48. Real-World Usage #22 — Custom Tab Indicator

A tab indicator can move between tabs.

```text
Home   Search   Profile
────
```

Then:

```text
Home   Search   Profile
              ─────────
```

A `Stack` + `AnimatedPositioned` combination can create a custom indicator.

For more flexible tab behavior, Flutter's `TabBar` is often preferable.

---

# 49. Real-World Usage #23 — Stepper / Progress Indicator

A progress indicator can move a marker between steps.

```text
●──────●──────●
1      2      3
```

When step changes:

```text
──────●───────
      ↑
    marker
```

`AnimatedPositioned` can animate the marker.

---

# 50. Real-World Usage #24 — Map Markers / Pins

A UI map-like interface can animate a marker between known locations.

```text
Old position
     ↓
     📍
```

to:

```text
                 📍
                 ↑
             new position
```

For real geographic maps, use the animation capabilities provided by the map library when appropriate.

---

# 51. Real-World Usage #25 — Custom Chat UI

A chat interface can use positioned elements for:

* typing indicators
* reaction menus
* attachment menus
* reply previews
* floating action buttons

Example:

```text
Message
   └── reactions
```

The reaction menu can move into position using `AnimatedPositioned`.

---

# 52. The Demo Architecture

Our demo application uses:

```text
MaterialApp
    ↓
AnimatedPositionedDemo
    ↓
Stack
    ↓
AnimatedPositioned
    ↓
Interactive controls
```

The demo demonstrates:

1. Basic horizontal movement
2. Vertical movement
3. Diagonal movement
4. Position + size animation
5. Sliding panel
6. Floating action button
7. Segmented indicator
8. Expandable card
9. Bottom panel
10. Notification badge
11. Multiple positioned widgets
12. Different curves
13. Different durations

---

# 53. Important Limitation

`AnimatedPositioned` works with layout.

That means the animation can cause layout work during the animation.

If you need a purely visual translation without changing layout relationships, consider:

```dart
Transform.translate
```

or:

```dart
SlideTransition
```

depending on your requirements.

---

# 54. Performance Considerations

Do not assume that implicit animations are always free.

During an `AnimatedPositioned` animation, Flutter must update layout.

If you have:

```text
large widget tree
+
many AnimatedPositioned widgets
+
frequent state changes
```

you may introduce unnecessary layout work.

For normal UI interactions this is usually fine.

For high-frequency animations, profile the application.

Use:

```text
Flutter DevTools
```

to inspect:

* frame rendering
* rasterization
* build time
* layout time
* memory
* jank

---

# 55. Avoid Animating Too Many Widgets Unnecessarily

Bad design:

```text
100 AnimatedPositioned widgets
        ↓
all animate simultaneously
        ↓
large layout workload
```

Better:

```text
Only animate the elements
that actually need movement.
```

Senior-level Flutter development is not about using more animations.

It is about using the **right animation architecture**.

---

# 56. Keys and AnimatedPositioned

Keys are not normally required for basic `AnimatedPositioned`.

However, keys become important when you have dynamic children where widget identity can change.

For example:

```dart
ValueKey(item.id)
```

can help Flutter understand that a particular widget represents a particular item.

This becomes more important when combining animations with:

```text
lists
reordering
conditional children
AnimatedSwitcher
AnimatedList
```

---

# 57. Rebuilds

Remember:

```dart
setState()
```

causes the relevant subtree to rebuild.

For example:

```dart
setState(() {
  isOpen = !isOpen;
});
```

Then:

```dart
AnimatedPositioned(
  left: isOpen ? 200 : 20,
)
```

receives a new value.

Flutter then performs the implicit animation.

---

# 58. Interrupting an Animation

One of the powerful characteristics of implicit animations is that state can change while the animation is running.

Imagine:

```text
Position A
   ↓
animation starts
   ↓
Position B
```

But before reaching B:

```text
user taps again
```

and the new target becomes:

```text
Position C
```

The animation can transition toward the new target.

This makes implicit animations convenient for interactive interfaces.

---

# 59. AnimatedPositioned and User Interaction

A common architecture is:

```text
User interaction
       ↓
State changes
       ↓
AnimatedPositioned properties change
       ↓
Animation
```

For example:

```dart
onTap: () {
  setState(() {
    isOpen = !isOpen;
  });
}
```

Then:

```dart
AnimatedPositioned(
  left: isOpen ? 200 : 20,
)
```

This is a clean declarative architecture.

---

# 60. Declarative Animation

Flutter is declarative.

You don't usually tell Flutter:

```text
move 5 pixels
move 5 pixels
move 5 pixels
move 5 pixels
```

Instead you describe:

```text
When closed:
left = 20

When open:
left = 200
```

Flutter handles the transition.

This is one of the most important concepts to understand.

---

# 61. When Should You Use AnimatedPositioned?

Use it when:

* the child is inside a `Stack`
* its position needs to change
* its size may also change
* the animation is state-driven
* you don't need manual animation lifecycle control
* you want a simple declarative implementation

Excellent examples:

```text
custom drawers
expandable cards
floating buttons
badges
custom tab indicators
segmented controls
bottom panels
overlays
tutorial callouts
custom switches
simple marker movement
```

---

# 62. When Should You NOT Use It?

Avoid it when:

* the widget isn't conceptually positioned in a `Stack`
* you only need alignment
* you only need opacity
* you need explicit animation control
* you need physics-based movement
* you need complex choreography
* you need high-frequency game-like movement
* another specialized Flutter widget solves the problem better

---

# 63. AnimatedPositioned vs AnimatedContainer

### AnimatedContainer

Use for:

```text
color
padding
margin
decoration
borderRadius
width
height
```

### AnimatedPositioned

Use for:

```text
left
right
top
bottom
width
height
```

Think:

```text
AnimatedContainer
      ↓
Visual/container properties

AnimatedPositioned
      ↓
Stack positioning
```

---

# 64. AnimatedPositioned vs AnimatedAlign

```text
Need alignment?
      ↓
AnimatedAlign
```

```text
Need Stack coordinates?
      ↓
AnimatedPositioned
```

---

# 65. AnimatedPositioned vs Transform.translate

```text
Need layout positioning?
      ↓
AnimatedPositioned
```

```text
Need visual translation?
      ↓
Transform.translate
```

---

# 66. AnimatedPositioned vs SlideTransition

```text
Simple state-driven movement?
      ↓
AnimatedPositioned
```

```text
Need explicit animation control?
      ↓
SlideTransition
```

---

# 67. Senior-Level Decision Tree

Use this mental model:

```text
Does the widget need animation?
            │
            ▼
          Yes
            │
            ▼
Is it positioned inside a Stack?
        │           │
       No          Yes
        │           │
        ▼           ▼
Other animation   Does movement use
                  Stack coordinates?
                       │
                 ┌─────┴─────┐
                Yes          No
                 │            │
                 ▼            ▼
        AnimatedPositioned AnimatedAlign /
                            Transform /
                            SlideTransition
```

---

# 68. Common Mistakes

## Mistake 1 — Using it outside Stack

Incorrect:

```dart
Column(
  children: [
    AnimatedPositioned(
      ...
    ),
  ],
)
```

Correct:

```dart
Stack(
  children: [
    AnimatedPositioned(
      ...
    ),
  ],
)
```

---

## Mistake 2 — Using huge durations

Avoid:

```dart
Duration(seconds: 5)
```

for a normal button interaction.

It usually feels slow and frustrating.

---

## Mistake 3 — Using linear everywhere

```dart
curve: Curves.linear
```

is sometimes correct, but many UI interactions feel better with an easing curve.

---

## Mistake 4 — Animating everything

Do not animate every property simply because you can.

Animation should communicate:

```text
state
relationship
hierarchy
direction
continuity
```

---

# 69. Accessibility

Animations should also respect reduced-motion preferences when appropriate.

For production applications, consider whether users may have motion sensitivity.

A senior Flutter developer should think about:

```text
Animation
+
Accessibility
+
Performance
+
UX
```

not just whether the animation looks cool.

---

# 70. Production Architecture

A good architecture is:

```text
UI event
   ↓
State
   ↓
AnimatedPositioned
   ↓
Visual transition
```

Avoid putting complicated business logic directly inside:

```dart
AnimatedPositioned
```

Instead:

```dart
final isPanelOpen = state.isPanelOpen;
```

then:

```dart
AnimatedPositioned(
  left: isPanelOpen ? 0 : -300,
  ...
)
```

Keep animation configuration close to the UI while keeping business state elsewhere.

---

# 71. Testing

You can test the state transition.

For example:

```text
initial state
    ↓
panel closed
    ↓
tap button
    ↓
panel opens
```

Widget tests can verify:

* widget exists
* state changes
* target properties are applied
* interaction works

For exact animation timing, use Flutter's test clock and `pump`/`pumpAndSettle` carefully.

---

# 72. Senior Mental Model

Do not think:

> AnimatedPositioned moves a widget.

Think:

> AnimatedPositioned interpolates changes to Stack-based positioning and size properties as part of Flutter's implicit animation system.

That distinction matters.

The first explanation is beginner-level.

The second is the senior-level mental model.

---

# 73. Final Summary

`AnimatedPositioned` is an implicit animation widget designed for animating a child's position and size inside a `Stack`.

Its core properties are:

```dart
left
right
top
bottom
width
height
duration
curve
child
```

The basic pattern is:

```dart
Stack(
  children: [
    AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      left: isOpen ? 200 : 20,
      top: 100,
      child: widget,
    ),
  ],
)
```

The architecture is:

```text
State changes
      ↓
Position/size changes
      ↓
AnimatedPositioned
      ↓
Flutter interpolates values
      ↓
Animated layout
```

The most important real-world applications include:

```text
✓ Sliding panels
✓ Custom drawers
✓ Expandable cards
✓ Floating action buttons
✓ Notification badges
✓ Bottom panels
✓ Custom snackbars
✓ Tab indicators
✓ Segmented controls
✓ Toggle controls
✓ Tutorial callouts
✓ Context menus
✓ Dashboard transitions
✓ Profile transitions
✓ Media controls
✓ Simple drag/drop settling
✓ Onboarding UI
✓ Custom overlays
```

The key rule is:

> **Use AnimatedPositioned when a state-driven UI element needs to change its Stack-based position or size and you don't need manual animation control.**

For more complex animation systems, move to:

```text
AnimationController
Tween
Curves
AnimatedBuilder
SlideTransition
Physics
Gesture animations
```

---

# 74. What You Should Master Before Moving On

Before moving to the next animation, you should be able to explain:

* What `AnimatedPositioned` is
* Why it requires a `Stack`
* Difference between `Positioned` and `AnimatedPositioned`
* How `left`, `right`, `top`, and `bottom` work
* How `width` and `height` can be animated
* How `duration` works
* How `curve` works
* Why no `AnimationController` is required
* How state drives an implicit animation
* Difference between `AnimatedPositioned` and `AnimatedAlign`
* Difference between `AnimatedPositioned` and `Transform`
* Difference between `AnimatedPositioned` and `SlideTransition`
* When to use it in production
* When not to use it
* Performance implications
* How to design reusable components around it

Once these concepts are clear, you are ready for the next animation topic.
