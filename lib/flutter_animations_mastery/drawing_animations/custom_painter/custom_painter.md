# CustomPainter

`CustomPainter` is a Flutter API that allows you to create custom drawings using the `Canvas` and `Paint` APIs.

It is useful when normal Flutter widgets are not enough to create the visual effect you need.

---

## 1. What is CustomPainter?

Normally, Flutter UI is created using widgets:

```dart
Container()
Text()
Icon()
Row()
Column()
Stack()
```

But sometimes you need to draw things that do not have a normal widget.

For example:

* Custom charts
* Circular progress indicators
* Graphs
* Waves
* Signatures
* Custom shapes
* Loading animations
* Radar charts
* Graph visualizations
* Custom backgrounds
* Game graphics

For these situations, Flutter provides:

```dart
CustomPainter
```

`CustomPainter` allows you to draw directly onto a `Canvas`.

---

# 2. Basic Structure

A `CustomPainter` normally looks like this:

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Drawing code
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return false;
  }
}
```

The two most important methods are:

```dart
paint()
```

and:

```dart
shouldRepaint()
```

---

# 3. Using CustomPainter

You normally use `CustomPainter` with:

```dart
CustomPaint(
  painter: MyPainter(),
)
```

Example:

```dart
CustomPaint(
  size: const Size(300, 300),
  painter: MyPainter(),
)
```

The relationship is:

```text
CustomPaint
     │
     ▼
CustomPainter
     │
     ▼
Canvas
     │
     ▼
Paint
```

---

# 4. CustomPaint

`CustomPaint` is the widget that places your painter into the Flutter widget tree.

Example:

```dart
CustomPaint(
  size: const Size(300, 300),
  painter: BackgroundPainter(),
)
```

There are two important painter properties:

```dart
painter:
foregroundPainter:
```

## painter

Draws behind the child.

```dart
CustomPaint(
  painter: BackgroundPainter(),
  child: MyWidget(),
)
```

## foregroundPainter

Draws in front of the child.

```dart
CustomPaint(
  foregroundPainter: ForegroundPainter(),
  child: MyWidget(),
)
```

---

# 5. The paint() Method

The main drawing logic goes inside:

```dart
@override
void paint(Canvas canvas, Size size) {
}
```

Flutter gives you two important objects:

```dart
Canvas canvas
Size size
```

### Canvas

`Canvas` is where you draw.

### Size

`Size` tells you the available drawing area.

Example:

```dart
@override
void paint(Canvas canvas, Size size) {
  print(size.width);
  print(size.height);
}
```

---

# 6. Canvas

`Canvas` provides methods for drawing.

Some important methods are:

```dart
canvas.drawCircle()
canvas.drawLine()
canvas.drawRect()
canvas.drawRRect()
canvas.drawOval()
canvas.drawPath()
canvas.drawArc()
canvas.drawPoints()
canvas.drawImage()
canvas.drawParagraph()
```

Canvas itself does not define how something looks.

That is the job of:

```dart
Paint
```

---

# 7. Paint

`Paint` controls the appearance of your drawing.

Example:

```dart
final paint = Paint()
  ..color = Colors.blue
  ..strokeWidth = 5
  ..style = PaintingStyle.stroke;
```

Important properties include:

```dart
color
strokeWidth
style
strokeCap
strokeJoin
shader
blendMode
isAntiAlias
```

---

# 8. PaintingStyle

There are two common styles:

```dart
PaintingStyle.fill
PaintingStyle.stroke
```

## Fill

Fills the shape.

```dart
final paint = Paint()
  ..style = PaintingStyle.fill;
```

## Stroke

Only draws the outline.

```dart
final paint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 4;
```

---

# 9. Drawing a Circle

```dart
final paint = Paint()
  ..color = Colors.blue;

canvas.drawCircle(
  const Offset(150, 150),
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

# 10. Drawing a Line

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

# 11. Drawing a Rectangle

```dart
final paint = Paint()
  ..color = Colors.green;

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

The rectangle contains:

```text
x
y
width
height
```

---

# 12. Drawing a Rounded Rectangle

```dart
final paint = Paint()
  ..color = Colors.blue;

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

---

# 13. Drawing an Oval

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

# 14. Coordinate System

Canvas uses a coordinate system.

```text
(0,0)
  ┌──────────────────────────► X
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

means:

```text
100 pixels right
50 pixels down
```

---

# 15. Using Size Correctly

Avoid hardcoding the center:

```dart
Offset(150, 150)
```

Instead, calculate it from the available size:

```dart
final center = Offset(
  size.width / 2,
  size.height / 2,
);
```

This makes your painter more responsive.

---

# 16. shouldRepaint()

This method tells Flutter whether the painter needs to repaint.

Example:

```dart
@override
bool shouldRepaint(covariant MyPainter oldDelegate) {
  return false;
}
```

If your painter has no changing values, returning:

```dart
false
```

is usually correct.

---

# 17. Repainting Based on Data

Suppose your painter has a value:

```dart
class MyPainter extends CustomPainter {
  final double progress;

  MyPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Use progress.
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
```

Now Flutter repaints when `progress` changes.

This is very important for animations.

---

# 18. CustomPainter + Animation

`CustomPainter` becomes especially powerful when combined with animations.

The basic relationship is:

```text
AnimationController
        │
        ▼
   Animation value
        │
        ▼
   CustomPainter
        │
        ▼
      Canvas
        │
        ▼
 updated drawing
```

For example:

```dart
CustomPaint(
  painter: CirclePainter(
    progress: animation.value,
  ),
)
```

The painter can use:

```dart
progress
```

to calculate the current drawing state.

---

# 19. AnimatedBuilder

A clean way to connect an animation to `CustomPainter` is:

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

This rebuilds the `CustomPaint` when the animation changes.

---

# 20. CustomPainter vs Widgets

Flutter widgets:

```text
Container
Text
Image
Icon
ListView
```

are high-level UI components.

Canvas drawing:

```text
drawCircle
drawLine
drawRect
drawPath
drawArc
```

is lower-level rendering.

Think of it like:

```text
Widgets
   │
   │ High level
   ▼
Flutter UI
   │
   ▼
CustomPainter
   │
   │ Low level
   ▼
Canvas
```

---

# 21. When Should You Use CustomPainter?

Use `CustomPainter` when you need custom graphics.

## Charts

```text
Line Chart
Bar Chart
Pie Chart
Radar Chart
```

## Custom UI

```text
Waves
Curves
Decorations
Custom backgrounds
```

## Animations

```text
Circular progress
Loading indicators
Particle effects
Custom transitions
```

## Drawing Applications

```text
Signature pad
Whiteboard
Drawing app
Sketching
```

---

# 22. When NOT to Use CustomPainter

Do not use `CustomPainter` just because you can.

For normal UI, prefer widgets.

For example, don't draw a simple button with Canvas.

Use:

```dart
ElevatedButton()
```

instead.

Use `CustomPainter` when normal widgets become inefficient, impractical, or incapable of producing the required visual.

---

# 23. Performance

`CustomPainter` can be very performant, but it needs to be used correctly.

## Avoid unnecessary repainting

If nothing changed:

```dart
return false;
```

Do not always return:

```dart
return true;
```

unless the painter really needs to repaint.

---

# 24. RepaintBoundary

For expensive custom drawings, consider:

```dart
RepaintBoundary(
  child: CustomPaint(
    painter: MyPainter(),
  ),
)
```

`RepaintBoundary` can isolate repainting from other parts of the UI.

Use it based on profiling rather than adding it everywhere.

---

# 25. Keep Painting Logic Inside the Painter

Avoid putting drawing logic inside your widget.

Prefer:

```text
Screen
   │
   ▼
CustomPaint
   │
   ▼
MyPainter
   │
   └── paint()
```

instead of mixing drawing code with UI code.

This keeps responsibilities separated.

---

# 26. Canvas State

Canvas has a state.

You can save it:

```dart
canvas.save();
```

modify it:

```dart
canvas.translate(100, 100);
canvas.rotate(0.5);
```

and restore it:

```dart
canvas.restore();
```

Example:

```dart
canvas.save();

canvas.translate(100, 100);
canvas.rotate(0.5);

canvas.drawRect(
  const Rect.fromLTWH(
    0,
    0,
    100,
    100,
  ),
  paint,
);

canvas.restore();
```

This is important when creating advanced drawings and animations.

---

# 27. Transformations

Canvas supports transformations such as:

```dart
canvas.translate()
canvas.rotate()
canvas.scale()
```

These are useful for animations.

Example:

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

---

# 28. CustomPainter and Path

`CustomPainter` can also draw paths:

```dart
final path = Path();

path.moveTo(0, 100);
path.lineTo(100, 0);
path.lineTo(200, 100);

canvas.drawPath(
  path,
  paint,
);
```

Path is especially important for:

* Curves
* Waves
* Custom shapes
* SVG-like drawings
* Path animations

Path animation is covered separately in:

```text
path_animation/
```

---

# 29. Common Mistakes

## Mistake 1 — Returning true unnecessarily

```dart
return true;
```

This can cause unnecessary repainting.

---

## Mistake 2 — Hardcoding dimensions

Avoid:

```dart
Offset(150, 150)
```

when the drawing should adapt to different sizes.

Prefer:

```dart
Offset(
  size.width / 2,
  size.height / 2,
)
```

---

## Mistake 3 — Creating unnecessary objects repeatedly

Avoid excessive allocation inside `paint()` for expensive drawings.

For complex painters, optimize carefully after profiling.

---

## Mistake 4 — Using CustomPainter for normal UI

Don't replace widgets with Canvas unless there is a good reason.

---

# 30. Mental Model

Remember this:

```text
CustomPaint
     │
     ▼
CustomPainter
     │
     ▼
paint(Canvas, Size)
     │
     ├── Canvas
     │      ├── drawCircle
     │      ├── drawLine
     │      ├── drawRect
     │      ├── drawPath
     │      └── drawArc
     │
     └── Paint
            ├── color
            ├── style
            ├── strokeWidth
            ├── strokeCap
            └── shader
```

For animation:

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

# 31. Senior-Level Takeaway

The important thing is not memorizing:

```dart
drawCircle()
drawLine()
drawRect()
```

The important concept is understanding the rendering model:

```text
Widget Tree
     ↓
CustomPaint
     ↓
CustomPainter
     ↓
paint()
     ↓
Canvas + Paint
     ↓
Pixels
```

`CustomPainter` gives you lower-level control over rendering.

Use it when you need custom graphics that are difficult or inefficient to express using standard Flutter widgets.

---

# 32. Demo in This Folder

The accompanying demo demonstrates:

* `CustomPaint`
* `CustomPainter`
* `Canvas`
* `Paint`
* `drawCircle`
* `drawLine`
* `drawRect`
* `PaintingStyle`
* `Size`
* `Offset`
* `shouldRepaint`
* `AnimationController`
* `AnimatedBuilder`
* Animated custom drawing

Next topics are kept separate:

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
