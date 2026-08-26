# PageRouteBuilder Animation

## 1. Introduction

`PageRouteBuilder` is a Flutter class used to create a route with a completely custom page transition.

With `MaterialPageRoute`, Flutter provides the standard transition.

With `PageRouteBuilder`, you control the transition yourself.

For example, you can create:

* Fade transitions
* Slide transitions
* Scale transitions
* Rotation transitions
* Combined transitions
* Custom transition curves
* Different enter and exit behaviors

Basic structure:

```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
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
  ),
);
```

---

# 2. Why PageRouteBuilder Exists

`MaterialPageRoute` is convenient:

```dart
MaterialPageRoute(
  builder: (_) => const DetailsScreen(),
)
```

But you have limited control over the actual transition.

`PageRouteBuilder` gives you access to the route's animations.

Conceptually:

```text
MaterialPageRoute
       │
       ▼
Flutter controls transition
       │
       ▼
Standard transition
```

Whereas:

```text
PageRouteBuilder
       │
       ├── pageBuilder
       │
       └── transitionsBuilder
              │
              ▼
        You control animation
```

---

# 3. Basic Structure

A `PageRouteBuilder` normally contains two important builders:

```dart
PageRouteBuilder(
  pageBuilder: (
    context,
    animation,
    secondaryAnimation,
  ) {
    return const DetailsScreen();
  },

  transitionsBuilder: (
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    return ...;
  },
)
```

The two builders have different responsibilities.

---

# 4. pageBuilder

`pageBuilder` determines which page should be displayed.

Example:

```dart
pageBuilder: (
  context,
  animation,
  secondaryAnimation,
) {
  return const DetailsScreen();
},
```

The important point is that `pageBuilder` creates the actual route content.

Think:

```text
pageBuilder
     ↓
"What page am I navigating to?"
```

---

# 5. transitionsBuilder

`transitionsBuilder` determines how that page enters and leaves the screen.

Example:

```dart
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
```

Think:

```text
transitionsBuilder
       ↓
"How should this page appear?"
```

---

# 6. The animation Parameter

The `animation` parameter represents the primary route animation.

Its value generally progresses from:

```text
0.0 ───────────────────> 1.0
start                    complete
```

When the route enters:

```text
0.0 → 1.0
```

When the route is removed:

```text
1.0 → 0.0
```

This animation can be connected to many Flutter transition widgets.

For example:

```dart
FadeTransition(
  opacity: animation,
  child: child,
)
```

or:

```dart
ScaleTransition(
  scale: animation,
  child: child,
)
```

or:

```dart
SlideTransition(
  position: animation,
  child: child,
)
```

---

# 7. The child Parameter

The `child` parameter is the widget returned by `pageBuilder`.

For example:

```dart
pageBuilder: (_, animation, secondaryAnimation) {
  return const DetailsScreen();
},
```

Then:

```dart
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
```

Conceptually:

```text
pageBuilder
     │
     ▼
DetailsScreen
     │
     ▼
child
     │
     ▼
FadeTransition
     │
     ▼
Animated DetailsScreen
```

---

# 8. Fade Transition

A simple fade transition:

```dart
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
```

The page goes from:

```text
Invisible
   ↓
Partially visible
   ↓
Fully visible
```

---

# 9. Slide Transition

A slide transition requires an `Animation<Offset>`.

Example:

```dart
final slideAnimation = Tween<Offset>(
  begin: const Offset(1, 0),
  end: Offset.zero,
).animate(
  CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
  ),
);
```

Then:

```dart
SlideTransition(
  position: slideAnimation,
  child: child,
)
```

`Offset(1, 0)` means the widget starts one screen-width to the right.

The animation moves it toward:

```dart
Offset.zero
```

---

# 10. Scale Transition

You can also scale the page:

```dart
final scaleAnimation = Tween<double>(
  begin: 0.8,
  end: 1.0,
).animate(
  CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
  ),
);
```

Then:

```dart
ScaleTransition(
  scale: scaleAnimation,
  child: child,
)
```

The page starts smaller and grows to its normal size.

---

# 11. Rotation Transition

You can create a rotation animation:

```dart
final rotationAnimation = Tween<double>(
  begin: -0.1,
  end: 0.0,
).animate(
  CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
  ),
);
```

Then:

```dart
RotationTransition(
  turns: rotationAnimation,
  child: child,
)
```

---

# 12. Combining Animations

One of the most powerful features of `PageRouteBuilder` is that you can combine multiple animations.

For example:

```text
Page enters
     │
     ├── fades in
     │
     ├── slides upward
     │
     └── scales slightly
```

Example:

```dart
return FadeTransition(
  opacity: animation,
  child: SlideTransition(
    position: slideAnimation,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: child,
    ),
  ),
);
```

This creates a coordinated transition.

---

# 13. Tween

A `Tween` defines the beginning and ending values.

Example:

```dart
Tween<double>(
  begin: 0.0,
  end: 1.0,
)
```

means:

```text
0.0 → 1.0
```

For position:

```dart
Tween<Offset>(
  begin: const Offset(1, 0),
  end: Offset.zero,
)
```

means:

```text
Right side → Normal position
```

---

# 14. CurvedAnimation

You can control the timing of the transition using a curve.

Example:

```dart
CurvedAnimation(
  parent: animation,
  curve: Curves.easeOut,
)
```

Without a curve, the animation progresses linearly.

With a curve:

```text
Linear:

████████████████

Ease Out:

███████████████
              ██
                █
```

The visual result feels more natural.

---

# 15. Duration

You can control how long the route transition takes:

```dart
PageRouteBuilder(
  transitionDuration: const Duration(
    milliseconds: 600,
  ),
  ...
)
```

For example:

```text
300ms
```

is fast.

```text
600ms
```

is slower.

```text
1000ms
```

is usually quite slow for normal navigation.

For normal app navigation, keep transitions reasonably short.

---

# 16. reverseTransitionDuration

You can also specify the reverse duration:

```dart
PageRouteBuilder(
  transitionDuration: const Duration(
    milliseconds: 600,
  ),
  reverseTransitionDuration: const Duration(
    milliseconds: 400,
  ),
)
```

This means:

```text
Enter:
600ms

Exit:
400ms
```

This gives you independent control over entering and leaving.

---

# 17. secondaryAnimation

`PageRouteBuilder` provides:

```dart
animation
```

and:

```dart
secondaryAnimation
```

The primary animation generally describes the current route's transition.

The secondary animation is useful for controlling the route that is underneath the current route.

Conceptually:

```text
Current route
     ↑
 primaryAnimation

Previous route
     ↑
 secondaryAnimation
```

This becomes particularly useful for advanced navigation choreography.

---

# 18. Route Transition Example

Suppose:

```text
HomeScreen
```

pushes:

```text
DetailsScreen
```

During the transition:

```text
HomeScreen
     │
     │ secondaryAnimation
     ▼
DetailsScreen
     │
     │ animation
     ▼
```

You can therefore animate both the incoming route and the route underneath it.

---

# 19. MaterialPageRoute vs PageRouteBuilder

| Feature             | MaterialPageRoute       | PageRouteBuilder |
| ------------------- | ----------------------- | ---------------- |
| Standard navigation | Excellent               | Possible         |
| Custom transition   | Limited                 | Excellent        |
| Fade                | Not directly controlled | Yes              |
| Slide               | Not directly controlled | Yes              |
| Scale               | Not directly controlled | Yes              |
| Rotation            | Not directly controlled | Yes              |
| Custom curves       | Limited                 | Yes              |
| Custom duration     | Limited                 | Yes              |
| Complexity          | Low                     | Higher           |

The rule is simple:

```text
Normal navigation
       ↓
MaterialPageRoute

Custom navigation animation
       ↓
PageRouteBuilder
```

---

# 20. Common Mistakes

## Mistake 1 — Putting the animation in pageBuilder

This is conceptually wrong:

```dart
pageBuilder: (...) {
  return FadeTransition(...);
}
```

The responsibility of `pageBuilder` is to provide the page.

The transition belongs in:

```dart
transitionsBuilder
```

---

## Mistake 2 — Creating an unnecessary AnimationController

You usually don't need:

```dart
AnimationController
```

for the route transition.

`PageRouteBuilder` already gives you:

```dart
Animation<double> animation
```

Use that animation as the parent for your Tweens and CurvedAnimations.

---

## Mistake 3 — Forgetting the child

Instead of rebuilding the page repeatedly:

```dart
return FadeTransition(
  opacity: animation,
  child: child,
);
```

Use the provided `child`.

This is cleaner and can avoid unnecessary work during animation.

---

# 21. Performance Consideration

Animations execute frequently during frames.

Avoid expensive work inside:

```dart
transitionsBuilder
```

Don't perform things such as:

* network requests
* database queries
* heavy calculations
* unnecessary widget construction

The transition builder should primarily construct the animation tree.

Good:

```dart
return FadeTransition(
  opacity: animation,
  child: child,
);
```

---

# 22. When Should You Use PageRouteBuilder?

Use it when the application's navigation requires a custom visual transition.

Good examples:

### Fade

```text
Page A
  ↓
Fade
  ↓
Page B
```

### Slide

```text
Page B
→ → →
```

### Scale

```text
Small
 ↓
Normal
```

### Combined

```text
Fade
 +
Slide
 +
Scale
```

---

# 23. When Should You Avoid It?

Don't use custom route animations simply because they are possible.

If the default platform transition is appropriate:

```dart
MaterialPageRoute(...)
```

is usually preferable.

Custom animations should have a reason.

Examples:

* product design requires it
* brand identity requires it
* a particular interaction requires it
* navigation hierarchy needs visual explanation

---

# 24. Senior-Level Mental Model

At a senior level, think of `PageRouteBuilder` as a bridge between:

```text
Navigator
     ↓
Route lifecycle
     ↓
Animation<double>
     ↓
Tween
     ↓
Curve
     ↓
Transition Widget
     ↓
Rendered page
```

For example:

```text
Navigator.push()
       ↓
PageRouteBuilder
       ↓
animation
       ↓
CurvedAnimation
       ↓
Tween<Offset>
       ↓
SlideTransition
       ↓
DetailsScreen
```

This is the important architecture to understand.

---

# 25. Recommended Pattern

A clean custom route often looks like:

```dart
PageRouteBuilder(
  transitionDuration: const Duration(
    milliseconds: 500,
  ),

  pageBuilder: (
    context,
    animation,
    secondaryAnimation,
  ) {
    return const DetailsScreen();
  },

  transitionsBuilder: (
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    );

    final offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(curvedAnimation);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  },
)
```

This pattern is worth memorizing.

---

# 26. Summary

`PageRouteBuilder` allows you to build custom route transitions.

The most important properties are:

```dart
pageBuilder
```

Creates the page.

```dart
transitionsBuilder
```

Creates the visual transition.

```dart
transitionDuration
```

Controls forward transition duration.

```dart
reverseTransitionDuration
```

Controls reverse transition duration.

The most important animation concepts are:

```text
Animation
   ↓
CurvedAnimation
   ↓
Tween
   ↓
Transition Widget
```

For example:

```text
animation
   ↓
CurvedAnimation
   ↓
Tween<Offset>
   ↓
SlideTransition
```

---

# Related Topics

Continue with:

1. Hero
2. Shared-element transitions
3. Nested navigation
4. Navigator 2.0 / Router API
5. Deep linking
