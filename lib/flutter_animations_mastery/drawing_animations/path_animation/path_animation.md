# Path Animation

Path Animation is the technique of moving an object along a custom `Path` over time.

It combines:

```text
Path
 +
Canvas
 +
CustomPainter
 +
AnimationController
 +
Animation
```

This is useful for advanced UI animations where an object needs to follow a specific route instead of moving only horizontally or vertically.

---

## 1. What is Path Animation?

A normal animation might move an object like this:

```text
A ───────────────────────► B
```

A path animation allows the object to follow a custom route:

```text
A
 \
  \
   ╭──────╮
          \
           \
            B
```

The path can contain:

* Straight lines
* Curves
* Arcs
* Multiple segments
* Complex custom shapes

The object moves along that path based on animation progress.

---

## 2. Basic Architecture

The basic architecture is:

```text
AnimationController
        │
        ▼
    progress
    0.0 → 1.0
        │
        ▼
       Path
        │
        ▼
   PathMetrics
        │
        ▼
getTangentForOffset()
        │
        ▼
    Position
        │
        ▼
      Canvas
        │
        ▼
  Draw animated object
```

The important idea is:

```text
Animation value
       ↓
Distance along Path
       ↓
Position on Path
       ↓
Draw object
```

---

## 3. What is Path?

`Path` represents a sequence of drawing commands.

For example:

```dart
final path = Path();

path.moveTo(20, 100);
path.lineTo(100, 20);
path.lineTo(200, 100);
```

This creates a path containing connected lines.

You can then draw it:

```dart
canvas.drawPath(
  path,
  paint,
);
```

---

## 4. Creating a Path

A basic path:

```dart
final path = Path();
```

Then add commands.

For example:

```dart
path.moveTo(50, 100);
path.lineTo(150, 50);
path.lineTo(250, 100);
```

The path now contains:

```text
50,100
   \
    \
     150,50
          \
           \
            250,100
```

---

## 5. moveTo()

`moveTo()` moves the current position without drawing a line.

```dart
path.moveTo(100, 100);
```

Think of it as:

```text
"Start drawing from here."
```

---

## 6. lineTo()

`lineTo()` creates a straight line from the current position to the specified position.

```dart
path.moveTo(50, 100);
path.lineTo(200, 100);
```

Result:

```text
50,100 ───────────────── 200,100
```

---

## 7. quadraticBezierTo()

Creates a quadratic Bézier curve.

```dart
path.moveTo(50, 200);

path.quadraticBezierTo(
  150,
  50,
  250,
  200,
);
```

The parameters are:

```text
controlPointX
controlPointY
endPointX
endPointY
```

The control point influences the shape of the curve.

---

## 8. cubicTo()

Creates a cubic Bézier curve.

```dart
path.moveTo(40, 200);

path.cubicTo(
  100,
  50,
  200,
  350,
  300,
  200,
);
```

A cubic Bézier curve uses:

```text
Start Point
Control Point 1
Control Point 2
End Point
```

This gives you more control than `quadraticBezierTo()`.

---

## 9. arcTo()

You can also create arcs.

Example:

```dart
path.arcTo(
  Rect.fromCircle(
    center: const Offset(150, 150),
    radius: 100,
  ),
  0,
  3.14,
  false,
);
```

Arcs are useful for:

* Circular motion
* Circular progress
* Gauges
* Curved transitions

---

## 10. addOval()

You can add an oval to a path.

```dart
path.addOval(
  const Rect.fromLTWH(
    50,
    50,
    200,
    100,
  ),
);
```

---

## 11. addRect()

You can add a rectangle.

```dart
path.addRect(
  const Rect.fromLTWH(
    50,
    50,
    200,
    100,
  ),
);
```

This becomes part of the path.

---

## 12. addRRect()

You can add a rounded rectangle.

```dart
path.addRRect(
  RRect.fromRectAndRadius(
    const Rect.fromLTWH(
      50,
      50,
      200,
      100,
    ),
    const Radius.circular(20),
  ),
);
```

---

## 13. close()

`close()` connects the current point back to the starting point.

Example:

```dart
path.moveTo(50, 50);
path.lineTo(200, 50);
path.lineTo(100, 200);
path.close();
```

This creates a triangle.

Without:

```dart
path.close();
```

the final edge would not automatically connect to the starting point.

---

# 14. Path Animation Concept

The main concept is to convert animation progress into a distance along the path.

Suppose the path length is:

```text
1000 pixels
```

Animation progress:

```text
0.0
```

means:

```text
0 pixels
```

Progress:

```text
0.5
```

means:

```text
500 pixels
```

Progress:

```text
1.0
```

means:

```text
1000 pixels
```

The formula is:

```dart
final distance = pathLength * progress;
```

---

# 15. AnimationController

Create an animation controller:

```dart
late final AnimationController controller;
```

Initialize it:

```dart
controller = AnimationController(
  vsync: this,
  duration: const Duration(seconds: 4),
)..repeat();
```

The controller continuously produces values between:

```text
0.0 → 1.0
```

---

# 16. Compute Path Metrics

To work with a path's length and position, use:

```dart
final metrics = path.computeMetrics();
```

This returns information about the path.

You can convert it to a list:

```dart
final metrics = path.computeMetrics().toList();
```

Then access a metric:

```dart
final metric = metrics.first;
```

---

# 17. PathMetric

`PathMetric` provides information about a path segment.

One important property is:

```dart
metric.length
```

This gives the length of the path.

Example:

```dart
final length = metric.length;
```

Now you can calculate a position along that path.

---

# 18. getTangentForOffset()

This is one of the most important APIs for path animation.

```dart
final tangent = metric.getTangentForOffset(
  distance,
);
```

It gives you a `Tangent` at a particular distance along the path.

A tangent contains important information such as:

```text
position
angle
```

---

# 19. Getting the Position

You can get the position:

```dart
final position = tangent.position;
```

Then draw an object there:

```dart
canvas.drawCircle(
  position,
  15,
  paint,
);
```

This is the core of path animation.

---

# 20. Complete Path Animation Logic

The essential logic is:

```dart
final metrics = path.computeMetrics().toList();

if (metrics.isEmpty) {
  return;
}

final metric = metrics.first;

final distance = metric.length * progress;

final tangent = metric.getTangentForOffset(
  distance,
);

if (tangent == null) {
  return;
}

final position = tangent.position;
```

Then:

```dart
canvas.drawCircle(
  position,
  15,
  paint,
);
```

The object now follows the path.

---

# 21. Understanding Tangent

A tangent contains:

```dart
tangent.position
tangent.angle
```

### position

Where the object should be drawn.

### angle

The direction of the path at that point.

This means you can make the animated object rotate according to the path.

---

# 22. Rotating the Object Along the Path

Get the angle:

```dart
final angle = tangent.angle;
```

Then:

```dart
canvas.save();

canvas.translate(
  position.dx,
  position.dy,
);

canvas.rotate(angle);

canvas.drawRect(
  const Rect.fromLTWH(
    -20,
    -10,
    40,
    20,
  ),
  paint,
);

canvas.restore();
```

Now the rectangle follows the path and rotates according to its direction.

---

# 23. Path Animation with AnimatedBuilder

A clean approach is:

```dart
AnimatedBuilder(
  animation: controller,
  builder: (context, child) {
    return CustomPaint(
      painter: PathPainter(
        progress: controller.value,
      ),
    );
  },
)
```

The flow is:

```text
AnimationController
        ↓
controller.value
        ↓
progress
        ↓
PathPainter
        ↓
PathMetric
        ↓
Position
        ↓
Canvas
```

---

# 24. Drawing the Path

It is often useful to draw the path itself while developing.

Example:

```dart
final pathPaint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.stroke
  ..strokeWidth = 3;

canvas.drawPath(
  path,
  pathPaint,
);
```

This makes debugging much easier.

In a production animation, you can remove or hide the path if it is only being displayed for debugging.

---

# 25. Example Path

The demo uses a cubic Bézier curve:

```dart
final path = Path();

path.moveTo(
  40,
  size.height / 2,
);

path.cubicTo(
  size.width * 0.25,
  50,
  size.width * 0.75,
  size.height - 50,
  size.width - 40,
  size.height / 2,
);
```

Conceptually:

```text
Start
  \
   \
    ╭────────╮
             \
              \
               End
```

The animated object moves along this path.

---

# 26. Path Animation vs Normal Animation

Normal animation:

```dart
x = animation.value * width;
```

The object usually moves in a straight line.

Path animation:

```dart
distance = path.length * animation.value;
```

Then the distance is converted to a position on the path.

The object follows the custom route.

---

# 27. Use Cases

Path animation is useful for:

### UI animations

* Objects following curved routes
* Custom transitions
* Animated indicators
* Decorative animations

### Games

* Character movement
* Enemy movement
* Projectile paths
* Vehicle movement

### Data visualization

* Animated chart lines
* Graph traversal
* Route visualization

### Custom loading animations

* Circular loaders
* Curved loaders
* Orbit animations

### Maps

* Vehicle movement
* Route animation
* Location transitions

---

# 28. Multiple Path Segments

A path can contain multiple segments:

```dart
path.moveTo(20, 200);

path.lineTo(100, 100);

path.quadraticBezierTo(
  150,
  50,
  200,
  100,
);

path.lineTo(300, 200);
```

Visually:

```text
Start
  \
   \
    Curve
       \
        \
         End
```

`computeMetrics()` handles the path segments.

For simple paths, using:

```dart
metrics.first
```

is enough.

For complex paths containing multiple contours, you may need to process all `PathMetric` objects intentionally.

---

# 29. Multiple Path Metrics

A path can contain multiple independent contours.

For example:

```dart
path.addCircle(
  const Offset(100, 100),
  50,
);

path.addCircle(
  const Offset(250, 100),
  50,
);
```

Now:

```dart
final metrics = path.computeMetrics();
```

can contain multiple metrics.

You should not blindly assume:

```dart
metrics.first
```

represents the entire path in every situation.

For complex animations, handle each metric intentionally.

---

# 30. Direction of the Path

The direction in which you construct the path matters.

For example:

```dart
path.moveTo(0, 100);
path.lineTo(300, 100);
```

moves:

```text
Left → Right
```

But:

```dart
path.moveTo(300, 100);
path.lineTo(0, 100);
```

moves:

```text
Right → Left
```

This also affects the tangent angle.

---

# 31. Reverse Path Animation

To animate backward, you can reverse the progress:

```dart
final reversedProgress = 1 - progress;
```

Then:

```dart
final distance =
    metric.length * reversedProgress;
```

The object will move from the end toward the beginning.

---

# 32. Ping-Pong Animation

You can make an object move forward and backward:

```dart
controller.repeat(
  reverse: true,
);
```

Then the animation becomes:

```text
0.0 → 1.0 → 0.0 → 1.0
```

The object follows the path forward and then backward.

---

# 33. Curves and Path Animation

You can combine an animation with a Flutter `Curve`.

For example:

```dart
final animation = CurvedAnimation(
  parent: controller,
  curve: Curves.easeInOut,
);
```

Then:

```dart
final distance =
    metric.length * animation.value;
```

Now the object does not move with linear progress.

It accelerates and decelerates according to the curve.

---

# 34. Constant Speed vs Eased Speed

This is an important concept.

With:

```dart
controller.value
```

the animation progress changes linearly:

```text
0%
25%
50%
75%
100%
```

With:

```dart
Curves.easeInOut
```

the progress changes non-linearly.

This changes the perceived movement speed.

For most UI animations, using a curve is sufficient.

---

# 35. Path Animation and Rotation

You can animate both:

```text
Position
+
Rotation
```

using the tangent:

```dart
final position = tangent.position;
final angle = tangent.angle;
```

Then:

```dart
canvas.save();

canvas.translate(
  position.dx,
  position.dy,
);

canvas.rotate(angle);

canvas.drawRect(
  const Rect.fromLTWH(
    -20,
    -10,
    40,
    20,
  ),
  paint,
);

canvas.restore();
```

This is useful for:

* Cars
* Arrows
* Planes
* Characters
* Particles
* Vehicles

---

# 36. Common Mistakes

## Mistake 1 — Forgetting to dispose the controller

Always dispose:

```dart
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

---

## Mistake 2 — Not checking for an empty metric list

Avoid assuming:

```dart
metrics.first
```

always exists.

For example:

```dart
final metrics = path.computeMetrics().toList();

if (metrics.isEmpty) {
  return;
}
```

---

## Mistake 3 — Not checking for null tangent

`getTangentForOffset()` can return null.

Use:

```dart
final tangent = metric.getTangentForOffset(
  distance,
);

if (tangent == null) {
  return;
}
```

---

## Mistake 4 — Forgetting save/restore

When translating and rotating:

```dart
canvas.save();

canvas.translate(...);
canvas.rotate(...);

canvas.drawSomething();

canvas.restore();
```

This prevents transformations from affecting later drawings.

---

## Mistake 5 — Hardcoding the path size

Avoid building paths that only work on one screen size.

Prefer:

```dart
size.width
size.height
```

to make the path responsive.

---

# 37. Performance

Path animation requires work every frame.

For example:

```text
Animation
   ↓
Calculate progress
   ↓
Calculate path distance
   ↓
Calculate tangent
   ↓
Draw object
```

For simple animations this is normally fine.

For complex animations, profile the application.

---

# 38. Cache What Does Not Change

If the path itself does not change, avoid unnecessarily recreating expensive path geometry.

For example, if appropriate, create or cache the path outside the per-frame calculation.

However, if the path depends on:

```text
size
animation state
user input
```

then it may need to be recalculated.

The important principle is:

```text
Static work → calculate once when possible

Dynamic work → calculate every frame
```

---

# 39. Repaint Only When Needed

The painter should correctly implement:

```dart
@override
bool shouldRepaint(
  covariant PathAnimationPainter oldDelegate,
) {
  return oldDelegate.progress != progress;
}
```

Because the animation changes `progress`, the painter needs to repaint.

If nothing relevant changed, avoid unnecessary repainting.

---

# 40. RepaintBoundary

For complex screens, you may consider:

```dart
RepaintBoundary(
  child: CustomPaint(
    painter: PathPainter(),
  ),
)
```

This can isolate repainting.

But do not add `RepaintBoundary` everywhere automatically.

Use Flutter DevTools and actual performance measurements to decide whether it is beneficial.

---

# 41. Path Animation Mental Model

Remember:

```text
              AnimationController
                       │
                       ▼
                    progress
                    0.0 → 1.0
                       │
                       ▼
                 Path total length
                       │
                       ▼
              distance = length × progress
                       │
                       ▼
                 PathMetric
                       │
                       ▼
          getTangentForOffset(distance)
                       │
              ┌────────┴────────┐
              ▼                 ▼
          position            angle
              │                 │
              └────────┬────────┘
                       ▼
                     Canvas
                       │
                       ▼
              Draw animated object
```

This is the most important concept in Path Animation.

---

# 42. Path Animation vs Hero Animation

These are completely different concepts.

### Hero

Moves a widget between routes:

```text
Screen A
   ↓
Hero
   ↓
Screen B
```

### Path Animation

Moves a drawing or object along a custom geometric path:

```text
Start
  \
   Curve
      \
       End
```

Do not confuse them.

---

# 43. Path Animation vs Transform Animation

Transform animation might use:

```dart
Transform.translate()
Transform.rotate()
Transform.scale()
```

Path animation uses:

```dart
Path
PathMetric
Tangent
```

Path animation is better when movement needs to follow a custom route.

---

# 44. Senior-Level Understanding

At a senior level, understand that Path Animation is not a special animation widget.

It is a combination of:

```text
Geometry
+
Animation
+
Rendering
```

The animation produces a normalized progress value:

```text
0.0 → 1.0
```

Geometry converts that progress into a distance:

```text
distance = pathLength × progress
```

Path metrics convert the distance into spatial information:

```text
distance
   ↓
Tangent
   ↓
position + angle
```

Canvas then renders the object at that position.

---

# 45. Important APIs

## Path

```dart
Path()
```

Important methods:

```dart
moveTo()
lineTo()
quadraticBezierTo()
cubicTo()
arcTo()
addOval()
addRect()
addRRect()
close()
```

## PathMetric

```dart
path.computeMetrics()
```

Important properties and methods:

```dart
metric.length
metric.getTangentForOffset()
```

## Tangent

```dart
tangent.position
tangent.angle
```

## Animation

```dart
AnimationController
Animation
CurvedAnimation
AnimatedBuilder
```

---

# 46. What This Demo Demonstrates

The accompanying `path_animation_demo.dart` demonstrates:

* `Path`
* `moveTo()`
* `cubicTo()`
* `Canvas`
* `CustomPainter`
* `CustomPaint`
* `AnimationController`
* `AnimatedBuilder`
* Animation progress
* `computeMetrics()`
* `PathMetric`
* `getTangentForOffset()`
* Path position
* Tangent angle
* Animated object movement
* Basic direction visualization
* `shouldRepaint()`

---

# 47. Final Takeaway

Path Animation allows an object to move along a custom geometric path.

The core formula is:

```dart
final distance = metric.length * progress;
```

Then:

```dart
final tangent = metric.getTangentForOffset(
  distance,
);
```

And finally:

```dart
final position = tangent.position;
```

The complete mental model is:

```text
AnimationController
        ↓
     progress
        ↓
      Path
        ↓
   PathMetric
        ↓
     distance
        ↓
     Tangent
        ↓
 position + angle
        ↓
      Canvas
        ↓
 Animated Object
```

Once you understand this flow, you can build more advanced animations such as:

```text
Object following a curve
Car following a road
Arrow following a route
Plane following a flight path
Particle following a path
Custom loading animation
Animated chart drawing
Orbit animations
```

---

# 48. Folder Structure

```text
drawing_animations/
│
├── custom_painter/
│   ├── custom_painter_demo.dart
│   └── README.md
│
├── canvas/
│   ├── canvas_demo.dart
│   └── README.md
│
└── path_animation/
    ├── path_animation_demo.dart
    └── README.md
```

Path Animation builds directly on the previous topics:

```text
CustomPainter
      ↓
Canvas
      ↓
Path
      ↓
PathMetric
      ↓
AnimationController
      ↓
Path Animation
```
