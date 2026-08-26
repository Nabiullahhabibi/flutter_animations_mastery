# PageRoute Animation

## 1. Introduction

`PageRoute` is the Flutter mechanism used to represent a route (screen/page) that can be pushed onto a `Navigator`.

When you navigate from one screen to another:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailsScreen(),
  ),
);
```

Flutter doesn't simply replace the current screen.

The new route is pushed onto the navigation stack, and the route can animate into view.

A common implementation of `PageRoute` is:

```dart
MaterialPageRoute
```

`MaterialPageRoute` is a concrete `PageRoute` implementation that provides a Material-style transition.

---

# 2. What Is PageRoute?

`PageRoute` is an abstract class in Flutter's navigation system.

Conceptually:

```text
Route
  ↓
ModalRoute
  ↓
TransitionRoute
  ↓
PageRoute
  ↓
MaterialPageRoute
```

`PageRoute` is responsible for a page-style route that:

* occupies the screen
* participates in the Navigator stack
* can animate when entering
* can animate when leaving
* can receive route lifecycle events
* can control whether the previous route remains visible
* can interact with the Navigator's route system

---

# 3. The Most Common PageRoute

In normal Flutter applications, you will commonly use:

```dart
MaterialPageRoute(
  builder: (context) => const DetailsScreen(),
)
```

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailsScreen(),
  ),
);
```

This creates a `MaterialPageRoute` and pushes it onto the Navigator.

---

# 4. What Happens During Navigation?

Suppose we have:

```text
HomeScreen
```

and navigate to:

```text
DetailsScreen
```

The Navigator stack changes:

```text
Before:

Navigator Stack
┌───────────────┐
│ HomeScreen    │
└───────────────┘
```

After pushing:

```text
Navigator Stack
┌───────────────┐
│ DetailsScreen │ ← New route
├───────────────┤
│ HomeScreen    │
└───────────────┘
```

The new route is animated into the screen.

When you call:

```dart
Navigator.pop(context);
```

the current route is removed and the previous route becomes visible again.

---

# 5. PageRoute vs MaterialPageRoute

`PageRoute` is an abstract concept.

You normally don't instantiate `PageRoute` directly.

Instead, you use an implementation such as:

```dart
MaterialPageRoute
```

For example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailsScreen(),
  ),
);
```

Think of it like this:

```text
PageRoute
    │
    └── defines page-route behavior

MaterialPageRoute
    │
    └── provides a Material implementation
```

---

# 6. Basic Example

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) {
      return const DetailsScreen();
    },
  ),
);
```

The `builder` determines which widget becomes the new page.

---

# 7. Understanding the Animation

A route has an animation that progresses approximately like:

```text
0.0 ───────────────────────> 1.0
start                         complete
```

When the route is pushed:

```text
0.0 → 1.0
```

When the route is removed:

```text
1.0 → 0.0
```

The route transition system uses this animation to control how the page enters and leaves.

With a standard `MaterialPageRoute`, Flutter provides the platform-appropriate transition behavior.

---

# 8. PageRoute Is Not the Same as PageRouteBuilder

These two concepts are related but should not be confused.

### MaterialPageRoute

```dart
MaterialPageRoute(
  builder: (_) => const DetailsScreen(),
);
```

Use this when you want Flutter's standard Material navigation transition.

### PageRouteBuilder

```dart
PageRouteBuilder(
  pageBuilder: (_, animation, secondaryAnimation) {
    return const DetailsScreen();
  },
  transitionsBuilder: (
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
);
```

`PageRouteBuilder` gives you much more control over the transition animation.

So:

```text
MaterialPageRoute
    ↓
Standard route transition

PageRouteBuilder
    ↓
Custom route transition
```

---

# 9. When Should You Use PageRoute?

Use `MaterialPageRoute` when:

* you want standard Flutter/Material navigation
* you don't need a custom transition
* you want simple and readable navigation code
* the application's navigation follows platform conventions

Example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const SettingsScreen(),
  ),
);
```

---

# 10. When Should You NOT Use Only MaterialPageRoute?

If you need a custom animation such as:

* fade
* scale
* rotation
* custom slide
* combination of multiple animations
* advanced transition choreography

then `PageRouteBuilder` is usually more appropriate.

Example:

```dart
FadeTransition(
  opacity: animation,
  child: child,
)
```

This will be covered separately in the `PageRouteBuilder` topic.

---

# 11. Route Stack

Flutter navigation uses a stack.

For example:

```text
Home
```

Push Details:

```text
Details
Home
```

Push Settings:

```text
Settings
Details
Home
```

Pop:

```text
Details
Home
```

Pop again:

```text
Home
```

The route animation occurs as routes are pushed and popped.

---

# 12. Returning Data From a PageRoute

A route can also return a result.

Example:

```dart
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (_) => const SelectionScreen(),
  ),
);
```

The second screen can return:

```dart
Navigator.pop(context, 'Flutter');
```

Then the first screen receives:

```dart
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (_) => const SelectionScreen(),
  ),
);

print(result);
```

This is useful when a screen behaves like a selection or form screen.

---

# 13. Route Lifecycle

A route has important lifecycle events.

Conceptually:

```text
Route created
     ↓
Route pushed
     ↓
Route becomes visible
     ↓
Another route pushed
     ↓
Route becomes inactive
     ↓
Route becomes visible again
     ↓
Route popped
     ↓
Route removed
```

This becomes particularly important when dealing with:

* animations
* resources
* focus
* streams
* route-aware state
* complex navigation

---

# 14. PageRoute and AnimationController

You generally do **not** need to manually create an `AnimationController` when using:

```dart
MaterialPageRoute
```

The route infrastructure manages the route transition animation.

This is an important distinction.

With custom explicit animations inside a widget, you might write:

```dart
AnimationController(
  vsync: this,
);
```

But for standard route transitions, Flutter's route system handles the transition animation.

---

# 15. Important Concepts

When learning `PageRoute`, understand these concepts:

### Navigator

Manages the route stack.

```dart
Navigator.push(...)
Navigator.pop(...)
```

### Route

Represents a navigation destination.

### PageRoute

Represents a route designed around a page/screen.

### MaterialPageRoute

A Material implementation of `PageRoute`.

### PageRouteBuilder

Allows custom route transition behavior.

### Route animation

Controls the transition between route states.

---

# 16. Common Mistakes

## Mistake 1 — Creating unnecessary custom animations

Don't use `PageRouteBuilder` just because you can.

If the default transition is enough:

```dart
MaterialPageRoute(...)
```

is simpler.

---

## Mistake 2 — Confusing PageRoute with Hero

`PageRoute` controls the route transition.

`Hero` creates a shared-element animation between matching widgets on two routes.

They can work together, but they solve different problems.

```text
PageRoute
    ↓
Screen-to-screen transition

Hero
    ↓
Widget-to-widget transition
```

---

## Mistake 3 — Creating AnimationControllers unnecessarily

For a normal `MaterialPageRoute`, you don't need to create your own controller just to animate navigation.

---

# 17. Senior-Level Understanding

At a senior Flutter level, don't think of `PageRoute` as simply:

> "A way to navigate to another screen."

Think of it as part of Flutter's **route transition architecture**.

The important relationship is:

```text
Navigator
   │
   ├── manages routes
   │
   ▼
Route
   │
   ▼
PageRoute
   │
   ├── route lifecycle
   ├── route animation
   ├── route visibility
   └── page transition
```

The Navigator manages the stack, while the route participates in the transition and lifecycle of the destination page.

---

# 18. Practical Rule

For normal navigation:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const DetailsScreen(),
  ),
);
```

For custom transitions:

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    ...
  ),
);
```

For shared-element animations:

```dart
Hero(
  tag: 'image',
  child: ...
)
```

These are related but should be learned as separate concepts.

---

# 19. Summary

`PageRoute` is a core part of Flutter's navigation system for page-based routes.

The most common implementation is:

```dart
MaterialPageRoute
```

Basic navigation:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const DetailsScreen(),
  ),
);
```

The key mental model is:

```text
Navigator
    ↓
Route Stack
    ↓
PageRoute
    ↓
Route Transition
    ↓
New Screen
```

For standard navigation, prefer `MaterialPageRoute`.

For custom transitions, learn `PageRouteBuilder`.

For widget-to-widget shared transitions, learn `Hero`.

---

# Related Topics

After mastering this topic, continue with:

1. `PageRouteBuilder`
2. `Hero`
3. Shared-element transitions
4. Nested navigation
5. Navigator 2.0 / Router API
6. Deep linking
