# TweenAnimationBuilder

## Flutter Animation Mastery — Implicit Animations

`TweenAnimationBuilder<T>` is one of Flutter's most powerful **implicit animation widgets**.

It allows you to animate almost any value represented by a `Tween<T>` without manually creating:

* `AnimationController`
* `Animation`
* `CurvedAnimation`
* `TickerProvider`
* `dispose()`
* manual `forward()`
* manual listener management

Instead, Flutter manages the animation lifecycle for you.

The basic idea is:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    begin: 0,
    end: 1,
  ),
  duration: const Duration(milliseconds: 500),
  curve: Curves.easeInOut,
  builder: (context, value, child) {
    return ...;
  },
);
```

The important concept is:

> **You provide a Tween describing the value change, and Flutter animates the value for you.**

---

# 1. What is TweenAnimationBuilder?

`TweenAnimationBuilder<T>` is an implicit animation widget that animates between values defined by a `Tween<T>`.

For example:

```dart
Tween<double>(
  begin: 0,
  end: 300,
)
```

means:

```text
0 ────────────────────────> 300
```

Flutter generates the intermediate values:

```text
0
25
50
75
100
125
...
275
300
```

Your `builder` receives the current animated value.

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    begin: 0,
    end: 300,
  ),
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    return Container(
      width: value,
    );
  },
);
```

The `value` changes during the animation.

---

# 2. The Core Mental Model

Think of `TweenAnimationBuilder` as:

```text
          Tween
            │
            │
            ▼
    ┌──────────────────┐
    │ Animation Engine │
    └──────────────────┘
            │
            │ current value
            ▼
        builder()
            │
            ▼
           UI
```

You define:

```text
START VALUE
     ↓
TWEEN
     ↓
END VALUE
```

Flutter handles:

```text
AnimationController
Ticker
Interpolation
Curve
Animation lifecycle
Rebuilds
```

---

# 3. Basic Example

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    begin: 0,
    end: 200,
  ),
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    return Container(
      width: value,
      height: 100,
      color: Colors.blue,
    );
  },
);
```

The container starts around:

```text
width = 0
```

and animates toward:

```text
width = 200
```

---

# 4. Why is it called TweenAnimationBuilder?

The name tells you exactly what it does.

```text
Tween
  +
Animation
  +
Builder
```

### Tween

Defines how a value changes.

```dart
Tween<double>(
  begin: 0,
  end: 100,
)
```

### Animation

Flutter animates between the values.

### Builder

You receive the current animated value:

```dart
builder: (context, value, child) {
}
```

and use it to build your UI.

---

# 5. The Generic Type `<T>`

`TweenAnimationBuilder` is generic.

```dart
TweenAnimationBuilder<T>
```

The type `T` represents the type being animated.

Examples:

```dart
Tween<double>
```

```dart
ColorTween
```

```dart
SizeTween
```

```dart
RectTween
```

```dart
EdgeInsetsTween
```

```dart
AlignmentTween
```

The builder receives that same type.

For example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    begin: 0,
    end: 100,
  ),
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    // value is double
  },
);
```

---

# 6. Tween

A `Tween` describes interpolation between two values.

```dart
Tween<double>(
  begin: 0,
  end: 100,
)
```

Conceptually:

```text
begin ────────────────> end
  0                       100
```

Flutter calculates the intermediate values.

---

# 7. What Does "Tween" Actually Mean?

Tween means:

> Between.

It defines a value transition.

For example:

```dart
Tween<double>(
  begin: 100,
  end: 300,
)
```

Flutter can calculate:

```text
100
120
140
160
180
200
220
240
260
280
300
```

These are interpolated values.

---

# 8. Tween is Not the Animation

This distinction is extremely important.

A `Tween` does NOT control time.

It describes:

```text
WHAT changes?
```

The animation system controls:

```text
WHEN and HOW FAST it changes.
```

Think:

```text
Tween
↓
What?

AnimationController
↓
When?

Curve
↓
How?
```

With `TweenAnimationBuilder`, Flutter manages the timing internally.

---

# 9. Duration

`duration` controls how long the animation takes.

```dart
duration: const Duration(milliseconds: 500),
```

Examples:

```dart
const Duration(milliseconds: 200)
```

Very fast.

```dart
const Duration(milliseconds: 500)
```

Common UI animation duration.

```dart
const Duration(milliseconds: 800)
```

More noticeable.

```dart
const Duration(seconds: 2)
```

Slow.

---

# 10. Curve

You can control the animation's motion using:

```dart
curve: Curves.easeInOut,
```

For example:

```dart
curve: Curves.linear
```

```dart
curve: Curves.easeIn
```

```dart
curve: Curves.easeOut
```

```dart
curve: Curves.easeInOut
```

```dart
curve: Curves.elasticOut
```

```dart
curve: Curves.bounceOut
```

The curve controls the **rate of change over time**.

---

# 11. Linear vs Curved Animation

Linear:

```text
value
│
│        /
│      /
│    /
│  /
│/
└──────────── time
```

The value changes at approximately the same rate.

Ease-in:

```text
Starts slowly
        ↓
     gradually faster
```

Ease-out:

```text
Starts quickly
        ↓
     gradually slower
```

Ease-in-out:

```text
Slow
 ↓
Fast
 ↓
Slow
```

---

# 12. Builder

The most important part is:

```dart
builder: (context, value, child) {
  return ...;
}
```

The parameters are:

```text
context
value
child
```

### context

Normal Flutter `BuildContext`.

### value

Current animated value.

### child

Optional static child that can be optimized.

---

# 13. The Animated Value

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    begin: 0,
    end: 300,
  ),
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    print(value);

    return Container(
      width: value,
    );
  },
);
```

During the animation:

```text
0
18.4
36.9
52.1
...
278.4
300
```

The builder receives those values.

---

# 14. The Most Important Concept

The animation is driven by the changing `tween`.

Suppose the current widget has:

```dart
Tween<double>(
  begin: 0,
  end: 100,
)
```

Later it receives:

```dart
Tween<double>(
  begin: 0,
  end: 300,
)
```

Flutter detects the changed tween and animates toward the new target.

Conceptually:

```text
Previous target
      ↓
     100
      │
      │
      ▼
Current target
      300
```

The important point is:

> In `TweenAnimationBuilder`, changing the tween's target is what causes the implicit animation.

---

# 15. State Changes Trigger Animation

A common pattern is:

```dart
double target = 100;
```

Then:

```dart
setState(() {
  target = 300;
});
```

And:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: target,
  ),
  duration: const Duration(milliseconds: 500),
  builder: (context, value, child) {
    return Container(
      width: value,
    );
  },
);
```

When:

```text
target = 100
```

the UI animates toward 100.

When:

```text
target = 300
```

the UI animates toward 300.

---

# 16. Important Tween Rule

When using a changing target, the important value is generally the `end` value.

For example:

```dart
Tween<double>(
  end: target,
)
```

This is preferable to manually resetting:

```dart
begin
```

on every rebuild.

Flutter manages the transition from the previous animated state toward the new target.

---

# 17. Do Not Think of It Like This

Avoid thinking:

```dart
Tween<double>(
  begin: currentValue,
  end: targetValue,
)
```

where you manually track `currentValue`.

Instead, normally think:

```dart
Tween<double>(
  end: targetValue,
)
```

and allow `TweenAnimationBuilder` to manage the animation state.

---

# 18. TweenAnimationBuilder vs AnimatedContainer

You can sometimes accomplish the same UI with:

```dart
AnimatedContainer
```

Example:

```dart
AnimatedContainer(
  width: width,
  height: height,
  duration: const Duration(milliseconds: 500),
);
```

But `AnimatedContainer` only exposes specific properties.

`TweenAnimationBuilder` is more general.

---

# 19. AnimatedContainer

Good for:

```text
width
height
padding
margin
alignment
color
decoration
borderRadius
constraints
transform
```

Example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 500),
  width: width,
  height: height,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  ),
);
```

---

# 20. TweenAnimationBuilder

Can animate many kinds of values.

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: scale,
  ),
  duration: const Duration(milliseconds: 500),
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
);
```

This is much more flexible.

---

# 21. Real-World Use Case: Scale Animation

Very common for:

* buttons
* cards
* selected items
* favorite icons
* product cards
* onboarding
* emphasis states

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: isSelected ? 1.1 : 1.0,
  ),
  duration: const Duration(milliseconds: 250),
  builder: (context, scale, child) {
    return Transform.scale(
      scale: scale,
      child: child,
    );
  },
);
```

---

# 22. Real-World Use Case: Rotation

Useful for:

* expandable arrows
* menu icons
* refresh indicators
* settings controls
* dropdown indicators

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: isExpanded ? 0.5 : 0,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, angle, child) {
    return Transform.rotate(
      angle: angle,
      child: child,
    );
  },
);
```

---

# 23. Real-World Use Case: Progress Indicator

You can animate a numeric progress value.

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: progress,
  ),
  duration: const Duration(milliseconds: 800),
  builder: (context, value, child) {
    return LinearProgressIndicator(
      value: value,
    );
  },
);
```

Useful for:

* downloads
* uploads
* profile completion
* onboarding progress
* skill progress
* statistics

---

# 24. Real-World Use Case: Animated Number

You can animate numbers.

For example:

```text
$0
$10
$20
$30
...
$500
```

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: totalPrice,
  ),
  duration: const Duration(milliseconds: 700),
  builder: (context, value, child) {
    return Text(
      '\$${value.toStringAsFixed(0)}',
    );
  },
);
```

Useful for:

* dashboards
* financial applications
* shopping carts
* analytics
* statistics
* counters

---

# 25. Real-World Use Case: Opacity

You can create fade effects.

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: visible ? 1.0 : 0.0,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, opacity, child) {
    return Opacity(
      opacity: opacity,
      child: child,
    );
  },
);
```

Useful for:

* overlays
* loading states
* empty states
* hints
* notifications
* transitions

---

# 26. Real-World Use Case: Position

You can animate a numeric offset.

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: expanded ? 100 : 0,
  ),
  duration: const Duration(milliseconds: 500),
  builder: (context, value, child) {
    return Transform.translate(
      offset: Offset(value, 0),
      child: child,
    );
  },
);
```

Useful for:

* sliding panels
* drawers
* cards
* onboarding
* custom transitions

---

# 27. Real-World Use Case: Color

Use `ColorTween`.

```dart
TweenAnimationBuilder<Color?>(
  tween: ColorTween(
    end: isActive ? Colors.blue : Colors.grey,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, color, child) {
    return Container(
      color: color,
    );
  },
);
```

Useful for:

* selected states
* validation
* theme-like transitions
* status indicators
* buttons
* cards

---

# 28. Real-World Use Case: Border Radius

Use `BorderRadiusTween`.

```dart
TweenAnimationBuilder<BorderRadius>(
  tween: BorderRadiusTween(
    end: BorderRadius.circular(
      isRounded ? 40 : 8,
    ),
  ),
  duration: const Duration(milliseconds: 400),
  builder: (context, radius, child) {
    return ClipRRect(
      borderRadius: radius,
      child: child,
    );
  },
);
```

Useful for:

* cards
* image containers
* bottom sheets
* morphing buttons
* selected components

---

# 29. Real-World Use Case: Padding

Use `EdgeInsetsTween`.

```dart
TweenAnimationBuilder<EdgeInsets>(
  tween: EdgeInsetsTween(
    end: isExpanded
        ? const EdgeInsets.all(32)
        : const EdgeInsets.all(12),
  ),
  duration: const Duration(milliseconds: 400),
  builder: (context, padding, child) {
    return Padding(
      padding: padding,
      child: child,
    );
  },
);
```

Useful for:

* expandable cards
* navigation items
* menus
* responsive components
* interactive buttons

---

# 30. Real-World Use Case: Alignment

Use `AlignmentTween`.

```dart
TweenAnimationBuilder<Alignment>(
  tween: AlignmentTween(
    end: isRight
        ? Alignment.centerRight
        : Alignment.centerLeft,
  ),
  duration: const Duration(milliseconds: 500),
  builder: (context, alignment, child) {
    return Align(
      alignment: alignment,
      child: child,
    );
  },
);
```

Useful for:

* toggles
* sliding selectors
* segmented controls
* custom navigation
* cards

---

# 31. Real-World Use Case: Box Shadow

You can animate decoration values.

For example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: isSelected ? 20 : 4,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, blur, child) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: blur,
          ),
        ],
      ),
      child: child,
    );
  },
);
```

Useful for:

* focused cards
* selected products
* buttons
* hover effects
* desktop UI

---

# 32. Real-World Use Case: Card Expansion

A very common UI pattern.

Closed:

```text
┌──────────────┐
│ Product      │
└──────────────┘
```

Expanded:

```text
┌──────────────┐
│ Product      │
│              │
│ Description  │
│              │
│ Buy Now      │
└──────────────┘
```

You can animate:

```text
height
padding
radius
color
scale
```

with multiple `TweenAnimationBuilder`s.

---

# 33. Real-World Use Case: Interactive Product Card

A product card can animate:

```text
scale
elevation
image size
border radius
color
```

For example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: selected ? 1.03 : 1,
  ),
  duration: const Duration(milliseconds: 250),
  builder: (context, scale, child) {
    return Transform.scale(
      scale: scale,
      child: child,
    );
  },
);
```

---

# 34. Real-World Use Case: Like/Favorite Button

When a user taps a heart:

```text
♡
 ↓
♥
```

You can animate:

```text
scale
color
rotation
```

Example concept:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: liked ? 1.3 : 1,
  ),
  duration: const Duration(milliseconds: 200),
  curve: Curves.elasticOut,
  builder: (context, scale, child) {
    return Transform.scale(
      scale: scale,
      child: child,
    );
  },
);
```

---

# 35. Real-World Use Case: Notification Badge

When a notification count changes:

```text
3
 ↓
4
```

You can animate:

```text
scale
opacity
position
```

This creates a much more polished UI.

---

# 36. Real-World Use Case: Shopping Cart

When an item is added:

```text
Cart: 2
   ↓
Cart: 3
```

The number can animate using:

```dart
TweenAnimationBuilder<double>
```

You can also animate the cart icon's:

```text
scale
rotation
```

---

# 37. Real-World Use Case: Dashboard Statistics

For:

```text
Revenue
Users
Orders
Downloads
Views
```

Instead of:

```text
0
500
```

instantly changing, animate:

```text
0
50
100
150
...
500
```

This makes dashboards feel much more dynamic.

---

# 38. Real-World Use Case: Rating Stars

You can animate:

```text
size
opacity
scale
color
```

when the user selects a rating.

For example:

```text
☆ ☆ ☆ ☆ ☆
      ↓
★ ★ ★ ★ ☆
```

Each star can have its own animation.

---

# 39. Real-World Use Case: Progress Completion

For:

```text
Profile completion: 72%
```

animate:

```text
0% → 72%
```

This is excellent for:

* onboarding
* profile completion
* learning apps
* fitness apps
* task management

---

# 40. Real-World Use Case: Loading Skeleton

You can animate:

```text
opacity
brightness
position
```

for simple loading effects.

For complex shimmer effects, however, a dedicated shader/custom painter solution may be more appropriate.

---

# 41. Real-World Use Case: Hover Effects

On desktop/web:

```text
mouse enters
    ↓
scale up
    ↓
shadow increases
```

For example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: hovered ? 1.03 : 1,
  ),
  duration: const Duration(milliseconds: 200),
  builder: (context, scale, child) {
    return Transform.scale(
      scale: scale,
      child: child,
    );
  },
);
```

---

# 42. Real-World Use Case: Selection Indicator

For a selected navigation item:

```text
Home
Search
Profile
```

You can animate:

```text
width
color
position
scale
```

This is useful for custom navigation bars.

---

# 43. Real-World Use Case: Toggle UI

You can animate:

```text
position
color
size
```

For example:

```text
OFF [●────]
ON  [────●]
```

A `TweenAnimationBuilder` can control the knob's position.

---

# 44. Real-World Use Case: Custom Switch

Instead of using:

```dart
Switch()
```

you can build a custom switch with:

```text
AlignmentTween
ColorTween
Tween<double>
```

This gives you complete control over the animation.

---

# 45. Real-World Use Case: Bottom Sheet-Like UI

You can animate a panel from:

```text
bottom: -300
```

to:

```text
bottom: 0
```

For simple state-driven transitions, this can be implemented using a numeric tween and `Transform.translate`.

For gesture-driven bottom sheets, however, a controller-based solution may be more appropriate.

---

# 46. Real-World Use Case: Image Zoom

You can animate:

```dart
Tween<double>(
  end: zoomed ? 1.5 : 1,
)
```

and use:

```dart
Transform.scale()
```

Useful for:

* product images
* galleries
* image previews
* onboarding

For pinch-to-zoom, use gesture/interactive animation instead of relying only on `TweenAnimationBuilder`.

---

# 47. Real-World Use Case: Expandable Icon

Example:

```text
+
 ↓
×
```

You can animate rotation:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: expanded ? 0.785 : 0,
  ),
  duration: const Duration(milliseconds: 250),
  builder: (context, angle, child) {
    return Transform.rotate(
      angle: angle,
      child: child,
    );
  },
);
```

---

# 48. Real-World Use Case: Animated Divider

You can animate:

```text
width
opacity
thickness
```

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: selected ? 120 : 40,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, width, child) {
    return SizedBox(
      width: width,
      child: const Divider(),
    );
  },
);
```

---

# 49. Real-World Use Case: Animated Text Size

You can animate font size:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: selected ? 24 : 16,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, size, child) {
    return Text(
      'Flutter',
      style: TextStyle(
        fontSize: size,
      ),
    );
  },
);
```

Useful for:

* selected tabs
* headings
* expandable content
* focus states

Be careful with text layout because changing font size can cause layout changes.

---

# 50. Real-World Use Case: Animated Icon Size

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: selected ? 32 : 24,
  ),
  duration: const Duration(milliseconds: 250),
  builder: (context, size, child) {
    return Icon(
      Icons.favorite,
      size: size,
    );
  },
);
```

Useful for:

* selected navigation
* favorites
* reactions
* toolbars

---

# 51. Real-World Use Case: Animated Spacing

You can animate gaps between widgets.

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: expanded ? 24 : 8,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, spacing, child) {
    return Column(
      children: [
        firstWidget,
        SizedBox(height: spacing),
        secondWidget,
      ],
    );
  },
);
```

Useful for:

* expandable sections
* menus
* settings
* forms

---

# 52. Real-World Use Case: Login Form

A login form can animate:

```text
spacing
opacity
position
scale
button width
```

For example:

```text
Login
 ↓
Loading
 ↓
Success
```

`TweenAnimationBuilder` can handle many small state-driven visual changes.

---

# 53. Real-World Use Case: Error State

When validation fails, you can animate:

```text
color
padding
height
opacity
```

For example:

```text
Email
[____________]

        ↓

Email
[____________]
Invalid email
```

The error container can animate its height or opacity.

---

# 54. Real-World Use Case: Success State

After an operation:

```text
Saving...
   ↓
✓ Saved
```

You can animate:

```text
scale
opacity
color
```

This is especially useful for small feedback components.

---

# 55. Real-World Use Case: Onboarding

You can animate:

```text
image scale
text opacity
button width
indicator width
content position
```

For state-driven onboarding transitions, `TweenAnimationBuilder` can be a lightweight solution.

---

# 56. Real-World Use Case: Profile Header

You can animate:

```text
avatar size
padding
alignment
text size
```

For example:

```text
Expanded profile
      ↓
Compact profile
```

This is useful when creating custom profile screens.

---

# 57. Real-World Use Case: Custom Progress Ring

You can animate a numeric value:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: progress,
  ),
  duration: const Duration(milliseconds: 800),
  builder: (context, value, child) {
    return CustomPaint(
      painter: ProgressPainter(value),
    );
  },
);
```

This is an important advanced pattern:

```text
TweenAnimationBuilder
        ↓
animated value
        ↓
CustomPainter
```

You can therefore combine implicit animation with custom rendering.

---

# 58. Real-World Use Case: CustomPainter

`TweenAnimationBuilder` does not require its value to be used directly by a normal widget.

You can pass the animated value to:

```dart
CustomPainter
```

For example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: progress,
  ),
  duration: const Duration(seconds: 1),
  builder: (context, value, child) {
    return CustomPaint(
      painter: MyPainter(value),
    );
  },
);
```

This is extremely useful for custom UI.

---

# 59. Real-World Use Case: Chart Animation

You can animate:

```text
bar height
line progress
circle size
chart values
```

For example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: sales,
  ),
  duration: const Duration(milliseconds: 800),
  builder: (context, value, child) {
    return Container(
      height: value,
    );
  },
);
```

For sophisticated chart libraries, dedicated animation systems may be more appropriate.

---

# 60. Real-World Use Case: Image Overlay

You can animate an image overlay:

```text
opacity
scale
position
```

Useful for:

* image galleries
* product cards
* photo viewers
* media applications

---

# 61. Real-World Use Case: Floating Action Button

You can animate:

```text
scale
position
width
```

For example:

```text
●
 ↓
[ + Create ]
```

A compact FAB can morph into an extended action.

---

# 62. Real-World Use Case: Expandable FAB Menu

A floating action button can reveal actions:

```text
       ●
       ●
       ●
       ●
       ↓
       +
```

Each action can use a tween for:

```text
opacity
scale
translation
```

For complex coordinated animations, an explicit animation system may eventually be cleaner.

---

# 63. Real-World Use Case: Animated Search Bar

You can animate:

```text
width
padding
border radius
opacity
```

Example:

```text
[ 🔍 ]
```

becomes:

```text
[ 🔍 Search products... ]
```

`TweenAnimationBuilder` works very well for simple state-driven search UI.

---

# 64. Real-World Use Case: Animated Chip

A chip can animate:

```text
width
padding
color
radius
scale
```

Useful for:

* filters
* tags
* categories
* selected options

---

# 65. Real-World Use Case: Animated Tab Indicator

You can animate:

```text
width
position
color
```

This is a common custom UI pattern.

---

# 66. Real-World Use Case: Empty State

When data changes:

```text
Loading
   ↓
Empty
```

you can animate the empty-state illustration and text using:

```text
opacity
scale
position
```

---

# 67. Real-World Use Case: State Transition Feedback

Any UI that has:

```text
state A
   ↓
state B
```

can potentially use `TweenAnimationBuilder`.

Examples:

```text
inactive → active
collapsed → expanded
small → large
hidden → visible
normal → selected
loading → completed
error → success
```

---

# 68. Tween Types You Should Know

Common tween classes include:

```dart
Tween<double>
```

```dart
ColorTween
```

```dart
SizeTween
```

```dart
RectTween
```

```dart
AlignmentTween
```

```dart
EdgeInsetsTween
```

```dart
BorderRadiusTween
```

```dart
DecorationTween
```

```dart
Matrix4Tween
```

```dart
IntTween
```

---

# 69. Double Tween

The most common.

```dart
Tween<double>(
  end: 200,
)
```

Use for:

```text
width
height
opacity
scale
rotation
position
font size
progress
numbers
```

---

# 70. ColorTween

```dart
ColorTween(
  end: Colors.blue,
)
```

Use for:

```text
background
foreground
icons
borders
status
selection
```

---

# 71. IntTween

Useful when the displayed value should be an integer.

```dart
IntTween(
  end: 100,
)
```

Example:

```dart
TweenAnimationBuilder<int>(
  tween: IntTween(
    end: count,
  ),
  duration: const Duration(milliseconds: 500),
  builder: (context, value, child) {
    return Text('$value');
  },
);
```

---

# 72. EdgeInsetsTween

```dart
EdgeInsetsTween(
  end: const EdgeInsets.all(24),
)
```

Useful for animated padding and margins.

---

# 73. AlignmentTween

```dart
AlignmentTween(
  end: Alignment.centerRight,
)
```

Useful for moving widgets inside a parent.

---

# 74. BorderRadiusTween

```dart
BorderRadiusTween(
  end: BorderRadius.circular(30),
)
```

Useful for morphing UI components.

---

# 75. SizeTween

```dart
SizeTween(
  end: const Size(300, 200),
)
```

Useful for animated dimensions.

---

# 76. RectTween

Useful when working with rectangles and advanced positioning/transitions.

```dart
RectTween(
  end: Rect.fromLTWH(
    0,
    0,
    200,
    200,
  ),
)
```

---

# 77. Multiple Properties

One `TweenAnimationBuilder` only produces one animated value.

However, you can combine multiple builders.

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: scale,
  ),
  duration: const Duration(milliseconds: 300),
  builder: (context, scale, child) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        end: color,
      ),
      duration: const Duration(milliseconds: 300),
      builder: (context, color, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            color: color,
          ),
        );
      },
    );
  },
);
```

This works, but excessive nesting can become difficult to maintain.

---

# 78. Better Architecture for Multiple Properties

If many properties need to animate together, consider:

```text
AnimationController
+
Multiple Tweens
```

or:

```text
AnimatedContainer
```

or a custom explicit animation.

The right tool depends on the complexity.

---

# 79. The `child` Parameter

The builder has:

```dart
builder: (context, value, child) {
  return ...
}
```

The `child` can be used for widgets that do not depend on the animated value.

Example:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: scale,
  ),
  duration: const Duration(milliseconds: 300),
  child: const Icon(
    Icons.favorite,
    size: 40,
  ),
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
);
```

---

# 80. Why Use `child`?

The builder rebuilds as the animation progresses.

If some widget does not depend on the animated value, rebuilding it is unnecessary.

Instead:

```dart
child: expensiveWidget
```

and:

```dart
builder: (context, value, child) {
  return Transform.scale(
    scale: value,
    child: child,
  );
}
```

Flutter can reuse the child.

---

# 81. Performance Principle

Think:

```text
Animated value
      ↓
Only rebuild what needs the value
```

Avoid putting a huge widget tree inside the builder if only one small part needs animation.

---

# 82. Example of Bad Structure

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: scale,
  ),
  duration: const Duration(milliseconds: 500),
  builder: (context, value, child) {
    return HugeApplicationWidgetTree(
      scale: value,
    );
  },
);
```

This can cause unnecessary rebuilding.

---

# 83. Better Structure

Extract static content:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: scale,
  ),
  duration: const Duration(milliseconds: 500),
  child: const ExpensiveWidget(),
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
);
```

---

# 84. Implicit Animation vs Explicit Animation

`TweenAnimationBuilder`:

```text
State changes
     ↓
Flutter animates
     ↓
Done
```

Explicit animation:

```text
Controller
    ↓
forward()
    ↓
Animation value
    ↓
Builder/listener
    ↓
UI
```

---

# 85. When TweenAnimationBuilder Is Better

Use it when:

* animation starts because state changes
* you don't need manual control
* you don't need pause/resume
* you don't need reverse commands
* you don't need animation status callbacks
* you don't need complex synchronization
* you need a custom value animation

---

# 86. When AnimationController Is Better

Use `AnimationController` when you need:

```text
forward()
reverse()
repeat()
stop()
reset()
fling()
velocity
status
manual timing
gesture control
multiple coordinated animations
```

---

# 87. TweenAnimationBuilder and User Interaction

It works well for state-driven interaction.

Example:

```text
tap
 ↓
setState
 ↓
target changes
 ↓
TweenAnimationBuilder animates
```

This is one of its strongest use cases.

---

# 88. TweenAnimationBuilder and Gestures

For simple gestures:

```text
onTap
onHover
onLongPress
```

it can be excellent.

For continuous drag gestures:

```text
drag position
velocity
physics
```

an explicit controller or physics-based animation is usually more appropriate.

---

# 89. TweenAnimationBuilder and Physics

`TweenAnimationBuilder` is not primarily a physics animation API.

If you need:

```text
Spring
Friction
Velocity
Gravity
Fling
```

consider:

```text
AnimationController
SpringSimulation
FrictionSimulation
ClampedSimulation
```

This distinction becomes important at senior level.

---

# 90. TweenAnimationBuilder and Hero

Hero animations have their own system:

```dart
Hero(...)
```

Do not replace Hero with `TweenAnimationBuilder`.

Hero is designed for:

```text
route A
   ↓
route B
```

shared-element transitions.

`TweenAnimationBuilder` is designed for local state-driven value animation.

---

# 91. TweenAnimationBuilder and AnimatedBuilder

These are fundamentally different.

### TweenAnimationBuilder

Manages the animation lifecycle automatically.

```text
You provide Tween
        ↓
Flutter handles animation
```

### AnimatedBuilder

You provide an existing:

```dart
Animation
```

and rebuild UI from it.

```text
AnimationController
        ↓
Animation
        ↓
AnimatedBuilder
```

---

# 92. TweenAnimationBuilder and Tween

Remember:

```text
TweenAnimationBuilder
        ↓
creates/manages animation internally
```

while:

```text
Tween
```

is only interpolation logic.

---

# 93. Lifecycle

One major benefit is that you do not manually manage:

```dart
AnimationController
```

and you don't need:

```dart
TickerProviderStateMixin
```

or:

```dart
dispose()
```

for the animation controller.

Flutter handles the internal lifecycle.

---

# 94. Rebuild Behavior

When the tween's target changes, the widget animates toward the new value.

Conceptually:

```text
old target
    ↓
new target
    ↓
implicit animation
    ↓
builder rebuilds
```

This makes it ideal for state-driven UI.

---

# 95. Common Mistake: Expecting `begin` to Restart Everything

Do not think of:

```dart
begin
```

as a "restart animation from here" button.

The widget tracks its animation state and responds to tween changes.

For most state-driven use cases:

```dart
Tween<double>(
  end: target,
)
```

is the clean pattern.

---

# 96. Common Mistake: Recreating Complex Logic in Builder

Avoid:

```dart
builder: (context, value, child) {
  // expensive database operation
  // network request
  // complex calculation
  // huge widget tree
}
```

The builder can execute many times during one animation.

Keep it lightweight.

---

# 97. Common Mistake: Starting Side Effects Inside Builder

Do not do:

```dart
builder: (context, value, child) {
  saveToDatabase();
  return ...;
}
```

The builder is for building UI.

It can execute many times.

Side effects belong elsewhere.

---

# 98. Common Mistake: Calling setState Inside Builder

Avoid:

```dart
builder: (context, value, child) {
  setState(() {});
  return ...;
}
```

This can create rebuild loops and performance problems.

---

# 99. Common Mistake: Using It for Everything

Just because `TweenAnimationBuilder` can animate many things doesn't mean it should.

Choose the simplest appropriate animation tool.

```text
AnimatedContainer
    ↓
known container properties

TweenAnimationBuilder
    ↓
custom value animation

AnimationController
    ↓
advanced/manual animation
```

---

# 100. Performance Considerations

Animations run frequently.

Therefore:

* keep builders lightweight
* use `child` for static widgets
* avoid expensive calculations
* avoid unnecessary rebuilds
* avoid rebuilding huge trees
* profile complex screens
* use `RepaintBoundary` when appropriate
* avoid unnecessary nested animation builders

---

# 101. Accessibility

Animations should not create accessibility problems.

Respect reduced-motion preferences when appropriate.

Avoid animations that:

* flash excessively
* move content unpredictably
* make interaction difficult
* create unnecessary distraction

Animation should improve usability, not simply add motion.

---

# 102. Choosing Duration

A practical starting point:

```text
100–200ms
small micro-interaction

200–300ms
common interaction

300–500ms
larger component transition

500–800ms
noticeable visual transition

800ms+
usually reserved for special visual effects
```

These are guidelines, not hard rules.

---

# 103. Choosing Curves

Micro-interactions often work well with:

```dart
Curves.easeOut
```

or:

```dart
Curves.easeInOut
```

For playful interactions:

```dart
Curves.elasticOut
```

For bouncing:

```dart
Curves.bounceOut
```

For mechanical/simple transitions:

```dart
Curves.linear
```

Always choose the curve based on the UI's intended physical feeling.

---

# 104. Animation Design Principle

Good animation answers:

> What changed?

Examples:

```text
Button selected
    ↓
scale/color changes
```

```text
Card expanded
    ↓
height/padding changes
```

```text
Item added
    ↓
counter changes
```

Animation should communicate state.

---

# 105. State → Target → Animation

One of the best mental models is:

```text
Application State
       ↓
Target Value
       ↓
TweenAnimationBuilder
       ↓
Animated Value
       ↓
UI
```

Example:

```text
isSelected
     ↓
scale = 1.1
     ↓
TweenAnimationBuilder
     ↓
1.00 → 1.10
     ↓
Transform.scale
```

---

# 106. Architecture Pattern

A clean implementation often looks like:

```dart
bool isSelected = false;
```

Then:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: isSelected ? 1.1 : 1.0,
  ),
  duration: const Duration(milliseconds: 250),
  builder: (context, value, child) {
    return Transform.scale(
      scale: value,
      child: child,
    );
  },
);
```

The state controls the target.

The animation handles the transition.

---

# 107. TweenAnimationBuilder Is Not State Management

It does not replace:

```text
Provider
Riverpod
Bloc
Cubit
Redux
GetX
```

It simply reacts to state.

For example:

```text
Provider state
      ↓
isSelected
      ↓
TweenAnimationBuilder
      ↓
animation
```

---

# 108. Using It With Provider

Conceptually:

```dart
Consumer<CartProvider>(
  builder: (context, cart, child) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        end: cart.total,
      ),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Text(
          '\$${value.toStringAsFixed(0)}',
        );
      },
    );
  },
);
```

This is a good example of combining state management with UI animation.

---

# 109. Using It With Bloc

The same principle applies:

```text
Bloc State
   ↓
target value
   ↓
TweenAnimationBuilder
   ↓
animated UI
```

The animation should generally remain a presentation concern.

---

# 110. Senior-Level Rule

Do not put business logic inside the animation.

Bad:

```text
Animation
    ↓
calculate business state
    ↓
update database
```

Better:

```text
Business state
    ↓
UI target
    ↓
Animation
```

---

# 111. Real-World Decision Matrix

| Requirement                  | Recommended Tool                   |
| ---------------------------- | ---------------------------------- |
| Animate container properties | AnimatedContainer                  |
| Animate opacity              | AnimatedOpacity                    |
| Animate position             | AnimatedPositioned                 |
| Animate custom numeric value | TweenAnimationBuilder              |
| Animate color                | TweenAnimationBuilder / ColorTween |
| Animate custom painter value | TweenAnimationBuilder              |
| Manual play/reverse          | AnimationController                |
| Repeat animation             | AnimationController                |
| Gesture-driven physics       | AnimationController + Simulation   |
| Route shared element         | Hero                               |
| Complex timeline             | AnimationController                |
| Many coordinated animations  | Explicit animation                 |
| Simple state transition      | TweenAnimationBuilder              |

---

# 112. Senior Mental Model

Remember these three layers:

```text
STATE
 ↓
TARGET
 ↓
ANIMATION
```

For example:

```text
isFavorite = true
        ↓
targetScale = 1.2
        ↓
TweenAnimationBuilder
        ↓
1.0 → 1.2
```

This separation produces clean architecture.

---

# 113. The Most Important Things to Master

Before moving to the next animation topic, you should understand:

* what a Tween is
* what interpolation means
* what `TweenAnimationBuilder` does
* how the builder receives values
* how changing the target triggers animation
* how curves affect motion
* how duration affects timing
* how `child` improves performance
* when to use `TweenAnimationBuilder`
* when not to use it
* how to animate `double`
* how to animate `Color`
* how to animate `EdgeInsets`
* how to animate `Alignment`
* how to animate `BorderRadius`
* how to animate integers
* how to combine it with `CustomPainter`
* how to use it with state management
* how to recognize when `AnimationController` is necessary

---

# 114. Final Mental Picture

```text
                  APPLICATION STATE
                         │
                         ▼
                   TARGET VALUE
                         │
                         ▼
                    Tween<T>
                         │
                         ▼
             TweenAnimationBuilder
                         │
              ┌──────────┴──────────┐
              │                     │
           Duration               Curve
              │                     │
              └──────────┬──────────┘
                         ▼
                  Animated Value
                         │
                         ▼
                      Builder
                         │
                         ▼
                         UI
```

The key idea is:

> **You define the target. `TweenAnimationBuilder` handles the transition.**

---

# 115. Recommended Practice

Build these examples yourself:

1. Animated number counter
2. Favorite button
3. Scale-on-selection card
4. Animated progress bar
5. Animated progress percentage
6. Color-changing button
7. Expanding card
8. Rotating arrow
9. Animated padding
10. Animated alignment
11. Animated border radius
12. Animated search bar
13. Animated chip
14. Animated tab indicator
15. Animated notification badge
16. Animated shopping cart count
17. Animated dashboard statistic
18. Animated custom painter progress ring
19. Animated product card
20. Animated FAB

If you can build these without copying the implementation, you understand `TweenAnimationBuilder` at a practical level.

---

# 116. When to Move to the Next Topic

You are ready for the next animation topic when you can answer:

### Concept

What is a Tween?

### Architecture

Why does `TweenAnimationBuilder` not require an `AnimationController`?

### Implementation

How do you animate a `double`?

### Custom animation

How do you animate a `Color`?

### Performance

Why is the `child` parameter useful?

### Architecture

Why should business logic remain outside the builder?

### Decision making

When should you choose `TweenAnimationBuilder` instead of `AnimationController`?

### Senior level

How would you decide between:

```text
AnimatedContainer
TweenAnimationBuilder
AnimationController
```

for a real production feature?

Once you can answer these confidently, move to the next topic.

---

# Summary

`TweenAnimationBuilder` is a powerful bridge between simple implicit animations and advanced explicit animations.

It gives you:

```text
Tween
+
Duration
+
Curve
+
Builder
=
Custom Implicit Animation
```

The most important pattern is:

```dart
TweenAnimationBuilder<double>(
  tween: Tween<double>(
    end: targetValue,
  ),
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOut,
  builder: (context, value, child) {
    return ...;
  },
);
```

Use it when:

```text
State changes
     ↓
Target changes
     ↓
UI should smoothly transition
```

And move to explicit animations when you need direct control over the animation lifecycle.
