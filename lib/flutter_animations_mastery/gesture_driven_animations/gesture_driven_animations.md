# Gesture-driven Animations in Flutter

Gesture-driven animation means that a user's gesture directly controls an animation.

Instead of an animation simply running from:

start → animation → end

the user becomes part of the animation:

gesture → animation progress → release → physics/animation continues

Examples include:

- Dragging a card
- Swiping a card away
- Flinging an object
- Pulling a bottom sheet
- Interactive page transitions
- Drag-to-dismiss
- Swipe-to-delete
- Interactive navigation
- Reordering items
- Gesture-controlled transformations

---

# 1. Introduction

Flutter provides two important systems that work together:

1. Gesture detection
2. Animation

Gesture detection tells us what the user is doing.

Animation controls how the UI responds.

Common gesture widgets/classes include:

- GestureDetector
- InkWell
- Draggable
- Dismissible
- DragUpdateDetails
- DragEndDetails
- Velocity

Animation tools include:

- AnimationController
- Animation
- Tween
- Curves
- Physics simulations

The important idea is:

Gesture = input

AnimationController = animation state

Widget = visual result

A common architecture is:

User gesture
    ↓
GestureDetector
    ↓
Update animation value
    ↓
AnimationController
    ↓
Widget rebuild
    ↓
Visual animation

---

# 2. Drag

## What is Drag?

A drag occurs when the user presses on an object and moves their finger while keeping contact with the screen.

Example:

    ┌───────────────┐
    │     CARD      │
    └───────────────┘
          ↓
       Drag →
          ↓
    ┌───────────────┐
    │       CARD    │
    └───────────────┘

Dragging is usually a direct interaction.

If the user's finger moves 20 pixels, the object should usually move approximately 20 pixels.

---

# 2.1 Drag with GestureDetector

The most common approach is:

```dart
GestureDetector(
  onPanUpdate: (details) {
    position += details.delta;
  },
  child: widget,
)