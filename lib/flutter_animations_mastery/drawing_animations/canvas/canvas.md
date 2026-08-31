# Canvas

`Canvas` is Flutter's low-level drawing API. It allows you to draw shapes, lines, paths, images, text, and other custom graphics.

Canvas is commonly used with `CustomPainter`.

---

## 1. What is Canvas?

Normally, Flutter UI is created using widgets:

```dart
Container()
Text()
Icon()
Row()
Column()
Stack()
```

But sometimes you need direct control over drawing.

For example:

* Custom charts
* Waves
* Curves
* Custom shapes
* Graphs
* Circular progress indicators
* Loading animations
* Drawing applications
* Signature pads
* Custom backgrounds
* Game graphics

For these situations, Flutter provides:

```dart
Canvas
```

Canvas gives you low-level control over drawing.

---

# 2. Canvas Relationship

The basic relationship is:

```text
CustomPaint
     │
     ▼
CustomPainter
     │
     ▼
paint()
     │
     ▼
Canvas
     │
     ├── drawCircle()
     ├── drawLine()
     ├── drawRect()
     ├── drawRRect()
     ├── drawOval()
     ├── drawArc()
     └── drawPath()
```

`CustomPainter` defines the painting logic.

`Canvas` performs the actual drawing operations.

---

# 3. Basic Canvas Example

Canvas is normally accessed inside the `paint()` method of a `CustomPainter`.

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      50,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return false;
  }
}
```

Then use it with:

```dart
CustomPaint(
  size: const Size(300, 300),
  painter: MyPainter(),
)
```

---

# 4. Canvas and Paint

Canvas defines **what** to draw.

`Paint` defines **how** it should look.

For example:

```dart
final paint = Paint()
  ..color = Colors.blue
  ..strokeWidth = 5
  ..style = PaintingStyle.stroke;
```

Then:

```dart
canvas.drawCircle(
  center,
  50,
  paint,
);
```

Think of it as:

```text
Canvas = What to draw

Paint = How it looks
```

---

# 5. Coordinate System

Canvas uses a 2D coordinate system.

```text
(0,0)
  ┌──────────────────────────────► X
  │
  │
  │
  │
  ▼
  Y
```

The top-left corner is:

```dart
Offset(0, 0)
```

Moving right increases X.

Moving down increases Y.

For example:

```dart
Offset(100, 50)
```

means approximately:

```text
100 pixels from the left
50 pixels from the top
```

---

# 6. Size

Flutter provides the available painting area through:

```dart
Size size
```

You can access:

```dart
size.width
size.height
```

For example:

```dart
final center = Offset(
  size.width / 2,
  size.height / 2,
);
```

This is better than:

```dart
Offset(150, 150)
```

when the drawing needs to adapt to different screen sizes.

---

# 7. drawCircle()

`drawCircle()` draws a circle.

```dart
canvas.drawCircle(
  center,
  radius,
  paint,
);
```

Example:

```dart
final paint = Paint()
  ..color = Colors.blue;

canvas.drawCircle(
  const Offset(100, 100),
  50,
  paint,
);
```

The parameters are:

```text
center
radius
paint
```

---

# 8. drawLine()

`drawLine()` draws a line between two points.

```dart
canvas.drawLine(
  start,
  end,
  paint,
);
```

Example:

```dart
final paint = Paint()
  ..color = Colors.red
  ..strokeWidth = 5;

canvas.drawLine(
  const Offset(20, 20),
  const Offset(200, 100),
  paint,
);
```

---

# 9. drawRect()

`drawRect()` draws a rectangle.

```dart
canvas.drawRect(
  rect,
  paint,
);
```

Example:

```dart
canvas.drawRect(
  const Rect.fromLTWH(
    50,
    50,
    150,
    100,
  ),
  paint,
);
```

`Rect.fromLTWH()` means:

```text
L = Left
T = Top
W = Width
H = Height
```

---

# 10. drawRRect()

`drawRRect()` draws a rounded rectangle.

```dart
canvas.drawRRect(
  rrect,
  paint,
);
```

Example:

```dart
canvas.drawRRect(
  RRect.fromRectAndRadius(
    const Rect.fromLTWH(
      50,
      50,
      200,
      100,
    ),
    const Radius.circular(20),
  ),
  paint,
);
```

Useful for:

* Cards
* Buttons
* Custom UI
* Rounded backgrounds

---

# 11. drawOval()

`drawOval()` draws an oval.

```dart
canvas.drawOval(
  rect,
  paint,
);
```

Example:

```dart
canvas.drawOval(
  const Rect.fromLTWH(
    50,
    50,
    200,
    100,
  ),
  paint,
);
```

---

# 12. drawArc()

`drawArc()` draws part of an ellipse or circle.

Example:

```dart
canvas.drawArc(
  const Rect.fromLTWH(
    50,
    50,
    200,
    200,
  ),
  0,
  3.14,
  false,
  paint,
);
```

The important parameters are:

```text
Rect
startAngle
sweepAngle
useCenter
Paint
```

Angles are measured in radians.

A full circle is:

```text
2π radians
```

approximately:

```text
6.283 radians
```

---

# 13. PaintingStyle

There are two main painting styles:

```dart
PaintingStyle.fill
PaintingStyle.stroke
```

## Fill

Fills the shape.

```dart
final paint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.fill;
```

## Stroke

Only draws the outline.

```dart
final paint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.stroke
  ..strokeWidth = 4;
```

---

# 14. StrokeWidth

`strokeWidth` controls the thickness of strokes.

```dart
final paint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 8;
```

A larger value produces a thicker line.

---

# 15. StrokeCap

`strokeCap` controls how the ends of lines look.

Common options:

```dart
StrokeCap.butt
StrokeCap.round
StrokeCap.square
```

Example:

```dart
final paint = Paint()
  ..strokeWidth = 8
  ..strokeCap = StrokeCap.round;
```

`StrokeCap.round` is especially useful for:

* Progress indicators
* Loading animations
* Graphs
* Custom icons
* Circular indicators

---

# 16. StrokeJoin

`strokeJoin` controls how connected lines join together.

Common options:

```dart
StrokeJoin.miter
StrokeJoin.round
StrokeJoin.bevel
```

Example:

```dart
final paint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 5
  ..strokeJoin = StrokeJoin.round;
```

This becomes more important when drawing complex paths.

---

# 17. Canvas Transformations

Canvas supports transformations.

The most important ones are:

```dart
canvas.translate()
canvas.rotate()
canvas.scale()
```

These are especially useful for animations.

---

# 18. translate()

`translate()` moves the Canvas coordinate system.

Example:

```dart
canvas.translate(100, 100);

canvas.drawCircle(
  Offset.zero,
  50,
  paint,
);
```

The circle is now drawn around the translated position.

Instead of drawing around:

```text
(0, 0)
```

it is effectively drawing around:

```text
(100, 100)
```

---

# 19. rotate()

`rotate()` rotates the Canvas.

Example:

```dart
canvas.rotate(0.5);
```

The value is in radians.

For example:

```dart
math.pi / 2
```

means:

```text
90 degrees
```

A common animation pattern is:

```dart
final angle = progress * 2 * math.pi;

canvas.save();

canvas.rotate(angle);

canvas.drawRect(
  rect,
  paint,
);

canvas.restore();
```

---

# 20. scale()

`scale()` changes the size of the Canvas coordinate system.

Example:

```dart
canvas.scale(2);
```

Everything drawn afterward becomes approximately twice as large.

You can also scale X and Y independently:

```dart
canvas.scale(
  2,
  1,
);
```

This means:

```text
X → 2x
Y → 1x
```

---

# 21. save() and restore()

Canvas has a state.

When you perform transformations such as:

```dart
canvas.translate()
canvas.rotate()
canvas.scale()
```

those transformations affect later drawing operations.

Use:

```dart
canvas.save();
```

before changing the state.

Then:

```dart
canvas.restore();
```

to return to the previous state.

Example:

```dart
canvas.save();

canvas.translate(100, 100);
canvas.rotate(0.5);

canvas.drawRect(
  const Rect.fromLTWH(
    -50,
    -50,
    100,
    100,
  ),
  paint,
);

canvas.restore();
```

The common pattern is:

```text
save
  ↓
transform
  ↓
draw
  ↓
restore
```

This is extremely important for complex Canvas drawings.

---

# 22. Drawing Multiple Shapes

A single `paint()` method can contain multiple drawing operations.

Example:

```dart
canvas.drawCircle(
  const Offset(100, 100),
  50,
  paint,
);

canvas.drawRect(
  const Rect.fromLTWH(
    50,
    200,
    100,
    80,
  ),
  paint,
);

canvas.drawLine(
  const Offset(50, 350),
  const Offset(250, 350),
  paint,
);
```

Canvas executes these operations in order.

---

# 23. Drawing Order

Drawing order matters.

Example:

```dart
canvas.drawCircle(
  center,
  100,
  backgroundPaint,
);

canvas.drawCircle(
  center,
  50,
  foregroundPaint,
);
```

The second circle is drawn on top of the first circle.

Think of Canvas as layers:

```text
First drawing
      ↓
Second drawing
      ↓
Third drawing
      ↓
Final image
```

Later drawing operations can cover earlier ones.

---

# 24. Canvas + Path

Canvas can draw a `Path`.

Example:

```dart
final path = Path();

path.moveTo(20, 100);
path.lineTo(100, 20);
path.lineTo(200, 100);

canvas.drawPath(
  path,
  paint,
);
```

A `Path` allows you to create more complex shapes.

Path is especially important for:

* Curves
* Waves
* Custom shapes
* Graphs
* SVG-like drawings
* Path animations

Path animation is covered separately in:

```text
path_animation/
```

---

# 25. Canvas + Animation

Canvas becomes much more powerful when combined with Flutter animations.

The basic architecture is:

```text
AnimationController
        │
        ▼
   Animation Value
        │
        ▼
   CustomPainter
        │
        ▼
      Canvas
        │
        ▼
   Updated Drawing
```

The animation value can control:

```text
Position
Size
Rotation
Opacity
Color
Radius
Angle
Path
```

For example:

```dart
AnimatedBuilder(
  animation: controller,
  builder: (context, child) {
    return CustomPaint(
      painter: MyPainter(
        progress: controller.value,
      ),
    );
  },
)
```

---

# 26. Example: Rotating Object

An animation value can be converted into an angle:

```dart
final angle = progress * 2 * math.pi;
```

Then:

```dart
canvas.save();

canvas.translate(
  size.width / 2,
  size.height / 2,
);

canvas.rotate(angle);

canvas.drawRect(
  const Rect.fromLTWH(
    -50,
    -50,
    100,
    100,
  ),
  paint,
);

canvas.restore();
```

The rectangle can now rotate around its center.

---

# 27. Canvas vs CustomPainter

These concepts are related, but they are not the same.

## CustomPainter

Defines the painting logic:

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  }
}
```

## Canvas

Performs the actual drawing:

```dart
canvas.drawCircle(...)
canvas.drawLine(...)
canvas.drawRect(...)
```

Think:

```text
CustomPainter
     │
     │ controls
     ▼
  Canvas
     │
     │ draws
     ▼
  Pixels
```

---

# 28. Canvas vs Widgets

Use widgets for normal application UI:

```text
Text
Button
Container
ListView
Card
AppBar
```

Use Canvas when you need custom graphics:

```text
Charts
Waves
Custom shapes
Graphs
Drawing apps
Advanced animations
```

Do not use Canvas simply because it is possible.

Use the highest-level Flutter solution that solves the problem well.

---

# 29. Performance

Canvas can be very efficient, but complex drawings can still become expensive.

Important practices:

## Avoid unnecessary repaints

Use:

```dart
shouldRepaint()
```

correctly.

For example:

```dart
@override
bool shouldRepaint(covariant MyPainter oldDelegate) {
  return oldDelegate.progress != progress;
}
```

## Avoid unnecessary work

Do not perform expensive calculations repeatedly inside `paint()` unless necessary.

## Profile before optimizing

For complex animations, use Flutter DevTools to inspect:

* Frame rendering
* UI thread work
* Raster work
* GPU/raster performance
* Memory usage

Do not optimize based only on assumptions.

---

# 30. Common Mistakes

## Mistake 1 — Forgetting save/restore

Bad:

```dart
canvas.rotate(angle);

canvas.drawCircle(
  center,
  50,
  paint,
);
```

If later drawings should not be affected by the rotation, this can cause problems.

Better:

```dart
canvas.save();

canvas.rotate(angle);

canvas.drawCircle(
  center,
  50,
  paint,
);

canvas.restore();
```

---

## Mistake 2 — Hardcoding dimensions

Avoid:

```dart
Offset(150, 150)
```

when the drawing should be responsive.

Prefer:

```dart
Offset(
  size.width / 2,
  size.height / 2,
)
```

---

## Mistake 3 — Confusing degrees and radians

Canvas rotation uses radians.

For example:

```dart
math.pi / 2
```

equals:

```text
90 degrees
```

---

## Mistake 4 — Using the wrong Paint style

For a filled shape:

```dart
PaintingStyle.fill
```

For an outline:

```dart
PaintingStyle.stroke
```

---

## Mistake 5 — Repainting everything unnecessarily

For animated Canvas drawings, make sure only the necessary painter is repainting.

---

# 31. Important Canvas APIs

### Drawing

```dart
canvas.drawCircle()
canvas.drawLine()
canvas.drawRect()
canvas.drawRRect()
canvas.drawOval()
canvas.drawArc()
canvas.drawPath()
canvas.drawPoints()
canvas.drawImage()
canvas.drawParagraph()
```

### Transformations

```dart
canvas.translate()
canvas.rotate()
canvas.scale()
```

### State

```dart
canvas.save()
canvas.restore()
```

---

# 32. Important Paint APIs

```dart
Paint()
```

Common properties:

```dart
..color
..style
..strokeWidth
..strokeCap
..strokeJoin
..shader
..blendMode
..isAntiAlias
```

Think:

```text
Canvas → drawing operations

Paint → drawing appearance
```

---

# 33. Important Supporting Classes

Canvas drawing commonly uses:

```dart
Offset
Size
Rect
RRect
Radius
Path
```

### Offset

Represents a point:

```dart
Offset(x, y)
```

### Size

Represents width and height:

```dart
Size(width, height)
```

### Rect

Represents a rectangle:

```dart
Rect.fromLTWH(
  left,
  top,
  width,
  height,
)
```

### RRect

Represents a rounded rectangle.

### Radius

Defines rounded corners.

### Path

Represents a sequence of lines and curves.

---

# 34. Mental Model

Remember Canvas like this:

```text
                    Canvas
                      │
          ┌───────────┼───────────┐
          │           │           │
          ▼           ▼           ▼
       Shapes       Lines       Paths
          │           │           │
          └───────────┼───────────┘
                      ▼
                    Paint
                      │
             ┌────────┼────────┐
             ▼        ▼        ▼
           Color    Stroke    Shader
                      │
                      ▼
                    Pixels
```

Canvas tells Flutter:

```text
"What should I draw?"
```

Paint tells Flutter:

```text
"How should I draw it?"
```

---

# 35. Senior-Level Mental Model

At a higher level:

```text
Widget Tree
     │
     ▼
CustomPaint
     │
     ▼
CustomPainter
     │
     ▼
paint(Canvas, Size)
     │
     ├── Canvas
     │      ├── Shapes
     │      ├── Paths
     │      ├── Images
     │      └── Text
     │
     └── Paint
            ├── Color
            ├── Stroke
            ├── Shader
            ├── BlendMode
            └── Rendering properties
```

For animations:

```text
AnimationController
        │
        ▼
Animation Value
        │
        ▼
CustomPainter
        │
        ▼
Canvas
        │
        ▼
New Frame
```

---

# 36. What This Demo Demonstrates

The accompanying `canvas_demo.dart` demonstrates:

* `Canvas`
* `Paint`
* `CustomPainter`
* `CustomPaint`
* `drawCircle()`
* `drawLine()`
* `drawRect()`
* `drawRRect()`
* `drawOval()`
* `Offset`
* `Rect`
* `Size`
* `PaintingStyle`
* `StrokeCap`
* Canvas coordinates
* Canvas drawing order
* Canvas transformations
* Canvas animation
* `AnimationController`
* `AnimatedBuilder`
* Basic rotation mathematics

---

# 37. Key Things to Remember

The most important concepts are:

### 1. CustomPainter

Provides the painting logic.

### 2. Canvas

Provides drawing operations.

### 3. Paint

Controls the appearance.

### 4. Size

Tells you the available drawing area.

### 5. Offset

Represents positions and points.

### 6. save() / restore()

Control Canvas state.

### 7. Transformations

```dart
translate()
rotate()
scale()
```

allow you to manipulate the drawing coordinate system.

### 8. Animation

Animation values can control Canvas properties such as:

```text
Position
Rotation
Scale
Radius
Angle
Color
Progress
```

---

# 38. Final Takeaway

`Canvas` is Flutter's low-level drawing surface.

The most important relationship to remember is:

```text
CustomPainter
     ↓
paint()
     ↓
Canvas + Paint
     ↓
Drawing
```

Use Canvas when you need precise control over custom graphics.

Do not use Canvas as a replacement for normal Flutter widgets.

For simple UI, widgets are usually the better choice.

For advanced graphics, custom shapes, charts, and animations, Canvas gives you the control you need.

---

## Next Topic

After understanding Canvas, move to:

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

The next topic, **Path Animation**, will build on:

```text
Canvas
   +
Path
   +
AnimationController
   +
Animation
```
