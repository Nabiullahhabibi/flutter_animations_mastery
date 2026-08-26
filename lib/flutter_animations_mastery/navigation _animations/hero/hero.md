# Hero Animation

## 1. Introduction

`Hero` is a Flutter widget that creates a **shared-element transition** between two routes.

It allows a widget on one screen to visually move, resize, or transform into a corresponding widget on another screen.

For example:

```text
Home Screen                 Details Screen

┌───────────┐               ┌────────────────────┐
│           │               │                    │
│   Image   │ ────────────► │       Image        │
│           │               │                    │
└───────────┘               └────────────────────┘
```

Instead of the image disappearing from the first screen and appearing on the second screen, Flutter animates the image between the two locations.

This creates the feeling that the same object is moving from one page to another.

---

# 2. What Is a Hero?

`Hero` is a Flutter widget:

```dart
Hero(
  tag: 'product-image',
  child: Image.network(...),
)
```

The important property is:

```dart
tag
```

The tag identifies the shared element.

For a Hero animation to work, the source and destination routes need matching Hero widgets with the same tag.

Example:

```dart
Hero(
  tag: 'image-1',
  child: Image.asset('assets/image.png'),
)
```

On the second screen:

```dart
Hero(
  tag: 'image-1',
  child: Image.asset('assets/image.png'),
)
```

Flutter recognizes that these two widgets belong to the same Hero transition.

---

# 3. The Basic Mental Model

Think about Hero as:

```text
Route A
   │
   │ Hero(tag: "image")
   │
   ▼
Navigator.push()
   │
   ▼
Route B
   │
   │ Hero(tag: "image")
   │
   ▼
Flutter animates between them
```

The same tag connects the two widgets.

---

# 4. Basic Example

First screen:

```dart
Hero(
  tag: 'profile-image',
  child: CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(imageUrl),
  ),
)
```

Second screen:

```dart
Hero(
  tag: 'profile-image',
  child: CircleAvatar(
    radius: 150,
    backgroundImage: NetworkImage(imageUrl),
  ),
)
```

When navigating:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const ProfileScreen(),
  ),
);
```

Flutter animates the Hero between the two routes.

---

# 5. Why Is It Called Hero?

The name represents the idea that an element appears to travel between two screens.

For example:

```text
Product List
     │
     │
     │   🖼
     │
     ▼
Product Details
     │
     │
     │       🖼
     │
     ▼
```

The product image visually travels from its position on the list to its larger position on the details page.

---

# 6. Hero Requires Two Routes

A Hero animation normally involves:

```text
Source Route
     ↓
Navigator.push()
     ↓
Destination Route
```

There is a Hero on both routes.

For example:

```text
HomeScreen
┌─────────────────────┐
│                     │
│     Hero            │
│   ┌─────────┐       │
│   │ Image   │       │
│   └─────────┘       │
│                     │
└─────────────────────┘
          │
          │ navigation
          ▼
DetailsScreen
┌─────────────────────┐
│                     │
│                     │
│      Hero           │
│   ┌─────────────┐   │
│   │    Image    │   │
│   └─────────────┘   │
│                     │
└─────────────────────┘
```

---

# 7. The Hero Tag

The `tag` is extremely important.

Example:

```dart
Hero(
  tag: 'product-1',
  child: ...
)
```

The destination must use the same tag:

```dart
Hero(
  tag: 'product-1',
  child: ...
)
```

Think of the tag as an identifier:

```text
"product-1"
      │
      ├── Source Hero
      │
      └── Destination Hero
```

---

# 8. Tags Must Be Unique

Within a route, Hero tags need to uniquely identify the participating Hero widgets.

This is a common mistake:

```dart
Hero(
  tag: 'image',
  child: ...
),

Hero(
  tag: 'image',
  child: ...
),
```

This can cause a Hero tag conflict.

Instead:

```dart
Hero(
  tag: 'product-1',
  child: ...
),

Hero(
  tag: 'product-2',
  child: ...
),
```

For lists, generate tags from stable identifiers:

```dart
Hero(
  tag: 'product-${product.id}',
  child: ...
)
```

---

# 9. Hero and Navigator

Hero works with route transitions.

For example:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const DetailsScreen(),
  ),
);
```

Flutter detects matching Hero widgets between the routes and performs the shared-element animation during the route transition.

Therefore:

```text
Navigator
    ↓
Route transition
    ↓
Hero detection
    ↓
Hero animation
```

---

# 10. Hero Is Different From PageRouteBuilder

These concepts are related but solve different problems.

### PageRouteBuilder

Controls the transition of the page itself.

For example:

```text
Page A
   ↓
fade / slide / scale
   ↓
Page B
```

### Hero

Controls the transition of a shared element.

For example:

```text
Small image
    ↓
moves + resizes
    ↓
Large image
```

They can also work together.

```text
PageRouteBuilder
      +
Hero
      ↓
Custom page transition
+
Shared element transition
```

---

# 11. Hero Animation Direction

When pushing a route:

```text
Source
  ↓
Destination
```

the Hero moves from its position on the source route to its position on the destination route.

When popping:

```text
Destination
  ↓
Source
```

the Hero travels back.

So Hero transitions are naturally bidirectional.

---

# 12. What Does Flutter Actually Animate?

Flutter does not simply rebuild the original widget in a different location.

During the Hero flight, Flutter creates a visual representation of the Hero and animates it between the source and destination locations.

Conceptually:

```text
Source Hero
    │
    ▼
Hero Flight
    │
    ├── position
    ├── size
    ├── transform
    └── visual appearance
    │
    ▼
Destination Hero
```

The animation happens inside the Navigator's overlay during the transition.

---

# 13. Hero Flight

The animation between the source and destination is commonly called the **Hero flight**.

Example:

```text
Start

┌───────┐
│ IMAGE │
└───────┘

      ↓

   ┌────────┐
   │ IMAGE  │
   └────────┘

      ↓

    ┌─────────────┐
    │    IMAGE    │
    └─────────────┘

      ↓

Final destination
```

The Hero can change:

* position
* size
* shape
* clipping
* transform

depending on the source and destination widgets.

---

# 14. Basic Hero Demo

Source:

```dart
Hero(
  tag: 'avatar',
  child: CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(imageUrl),
  ),
)
```

Destination:

```dart
Hero(
  tag: 'avatar',
  child: CircleAvatar(
    radius: 150,
    backgroundImage: NetworkImage(imageUrl),
  ),
)
```

The same tag connects them:

```text
avatar
  │
  ├── Source
  │
  └── Destination
```

---

# 15. Hero With Images

One of the most common uses of Hero is image navigation.

For example:

```text
Product List
     │
     │ small image
     ▼
Product Details
     │
     │ large image
     ▼
```

This is excellent for:

* e-commerce apps
* galleries
* profile pages
* news applications
* photo applications
* social media
* media browsers

---

# 16. Hero With Different Widget Sizes

The source and destination widgets don't need to have the same size.

For example:

Source:

```dart
SizedBox(
  width: 80,
  height: 80,
  child: ...
)
```

Destination:

```dart
SizedBox(
  width: 300,
  height: 300,
  child: ...
)
```

Hero interpolates the transition between them.

This is one of the main reasons Hero animations feel natural.

---

# 17. Hero With Different Shapes

You can also have different visual shapes.

For example:

Source:

```text
┌─────────┐
│         │
│  IMAGE  │
│         │
└─────────┘
```

Destination:

```text
    ╭─────╮
   │ IMAGE │
    ╰─────╯
```

However, changing shape between routes can require more careful control depending on the widgets involved.

For advanced shape transitions, additional animation techniques may be needed.

---

# 18. HeroController

Flutter manages Hero animations using a `HeroController`.

A `HeroController` coordinates Hero transitions for routes managed by a Navigator.

Conceptually:

```text
Navigator
    │
    ▼
HeroController
    │
    ▼
Hero transitions
```

You normally do not need to create a `HeroController` yourself for ordinary Flutter applications.

The default navigation system handles it for you.

---

# 19. HeroControllerScope

Flutter uses a `HeroControllerScope` to make Hero coordination available to the relevant navigation hierarchy.

This becomes more important when working with:

* nested Navigators
* custom navigation
* complex navigation architecture
* multiple navigation stacks

For basic Hero usage, you normally don't need to interact with it directly.

---

# 20. HeroMode

`HeroMode` allows you to enable or disable Hero animations for a subtree.

Example:

```dart
HeroMode(
  enabled: false,
  child: MyWidget(),
)
```

This can be useful when you have a complex widget tree and don't want a particular subtree to participate in Hero transitions.

---

# 21. flightShuttleBuilder

You can customize what is displayed during the Hero flight using:

```dart
flightShuttleBuilder
```

Example:

```dart
Hero(
  tag: 'avatar',
  flightShuttleBuilder: (
    flightContext,
    animation,
    flightDirection,
    fromHeroContext,
    toHeroContext,
  ) {
    return const Icon(
      Icons.person,
      size: 100,
    );
  },
  child: ...,
)
```

This allows you to create a custom widget specifically for the flight.

Conceptually:

```text
Source widget
     ↓
Custom flight widget
     ↓
Destination widget
```

This is an advanced Hero technique.

---

# 22. placeholderBuilder

You can customize what remains in the original Hero's location while the Hero is flying.

Example:

```dart
Hero(
  tag: 'image',
  placeholderBuilder: (
    context,
    size,
    child,
  ) {
    return SizedBox(
      width: size.width,
      height: size.height,
    );
  },
  child: ...,
)
```

This is useful when the default placeholder behavior isn't appropriate.

---

# 23. transitionOnUserGestures

Hero can also participate in transitions driven by user gestures in navigation systems that support them.

Example:

```dart
Hero(
  tag: 'image',
  transitionOnUserGestures: true,
  child: ...,
)
```

This is particularly relevant for platform-style interactive route transitions.

---

# 24. Hero and Nested Navigators

This is an important advanced topic.

If you have multiple Navigators:

```text
Root Navigator
      │
      ├── Navigator A
      │
      └── Navigator B
```

Hero transitions normally occur within the relevant navigation context.

A Hero in one Navigator does not automatically transition with a Hero in an unrelated Navigator.

This matters when building:

* tab navigation
* nested navigation
* shell layouts
* modal navigation
* complex application flows

---

# 25. Hero and Lists

A common pattern is:

```dart
ListView.builder(
  itemBuilder: (context, index) {
    final product = products[index];

    return Hero(
      tag: 'product-${product.id}',
      child: ProductCard(
        product: product,
      ),
    );
  },
);
```

The destination can use:

```dart
Hero(
  tag: 'product-${product.id}',
  child: ProductImage(
    product: product,
  ),
)
```

The stable ID is important.

Don't use the list index as the identity when the underlying data can change.

Prefer:

```dart
product.id
```

rather than:

```dart
index
```

---

# 26. Hero and Unique Tags

This is one of the most important rules:

> Every participating Hero must have a meaningful matching tag.

Good:

```dart
Hero(
  tag: 'product-${product.id}',
  child: ...
)
```

Bad:

```dart
Hero(
  tag: index,
  child: ...
)
```

if the index doesn't represent a stable identity.

---

# 27. Common Error

A common error is having duplicate Hero tags.

For example:

```dart
Hero(
  tag: 'product',
  child: ProductCard(),
)

Hero(
  tag: 'product',
  child: AnotherProductCard(),
)
```

Flutter may report a Hero tag conflict because multiple Heroes in the same route have the same tag.

Use unique identifiers.

---

# 28. Hero and MaterialPageRoute

Hero does not replace your route.

You still need navigation:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const DetailsScreen(),
  ),
);
```

The Hero operates during that route transition.

So:

```text
MaterialPageRoute
        │
        ├── navigates between pages
        │
        └── Hero
              │
              └── animates shared element
```

---

# 29. Hero With PageRouteBuilder

You can combine them.

For example:

```text
PageRouteBuilder
    │
    ├── Fade page
    │
    └── Hero image
```

This can create a sophisticated transition:

```text
Page A
   │
   ├── page fades
   │
   └── image travels
   │
   ▼
Page B
```

This is a powerful technique, but don't add it unless the design needs it.

---

# 30. Performance Considerations

Hero animations run during route transitions, so the Hero subtree should be reasonably efficient.

Avoid making the Hero widget perform unnecessary expensive work.

For example, avoid putting heavy computations inside widgets that rebuild during the transition.

Good:

```dart
Hero(
  tag: product.id,
  child: Image.network(product.imageUrl),
)
```

Be careful with:

* very large images
* complex widget trees
* expensive custom painting
* unnecessary rebuilds
* heavy effects during flight

---

# 31. Hero vs Explicit Animation

Hero:

```text
Route A
   ↓
Route B
   ↓
Shared element automatically transitions
```

Explicit animation:

```text
AnimationController
   ↓
Tween
   ↓
Animated widget
```

Hero is specialized for **cross-route shared-element transitions**.

Explicit animation is general-purpose.

---

# 32. Hero vs AnimatedContainer

`AnimatedContainer`:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  width: width,
  height: height,
)
```

animates changes within the same widget tree.

Hero:

```dart
Hero(
  tag: 'image',
  child: ...
)
```

animates an element across routes.

Think:

```text
AnimatedContainer
    ↓
same route/tree

Hero
    ↓
between routes
```

---

# 33. Hero vs PageRouteBuilder

Use:

```text
PageRouteBuilder
```

when you want to animate the page transition.

Use:

```text
Hero
```

when you want to animate a shared element.

Use both when you need both effects.

---

# 34. Senior-Level Mental Model

At a senior level, think about Hero as a coordinated transition between two route subtrees.

The architecture is approximately:

```text
Navigator
   │
   ├── Route A
   │     │
   │     └── Hero(tag: X)
   │
   └── Route B
         │
         └── Hero(tag: X)
                 │
                 ▼
           HeroController
                 │
                 ▼
            Hero Flight
                 │
                 ▼
             Overlay
```

The key idea is:

> Hero temporarily coordinates the visual element between the outgoing and incoming routes rather than simply animating a widget inside one route.

---

# 35. Practical Example

Source:

```dart
Hero(
  tag: 'profile-avatar',
  child: CircleAvatar(
    radius: 40,
    backgroundImage: NetworkImage(imageUrl),
  ),
)
```

Navigation:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const ProfileScreen(),
  ),
);
```

Destination:

```dart
Hero(
  tag: 'profile-avatar',
  child: CircleAvatar(
    radius: 150,
    backgroundImage: NetworkImage(imageUrl),
  ),
)
```

Flutter connects:

```text
profile-avatar
      │
      ▼
┌─────────────┐
│ Small Hero  │
└─────────────┘
      │
      │ animation
      ▼
┌─────────────────┐
│   Large Hero    │
└─────────────────┘
```

---

# 36. Best Practices

### 1. Use stable tags

```dart
Hero(
  tag: 'product-${product.id}',
  child: ...,
)
```

### 2. Keep Hero subtrees reasonably lightweight

### 3. Use Hero for meaningful visual relationships

Don't add Hero animations everywhere.

### 4. Keep source and destination semantically related

A product image should transition to the product image.

### 5. Don't use Hero as a replacement for normal animations

Hero has a specific purpose.

### 6. Test both push and pop

A good Hero transition should normally feel natural in both directions.

---

# 37. Summary

`Hero` is Flutter's built-in shared-element transition mechanism.

The core pattern is:

```dart
Hero(
  tag: 'unique-id',
  child: widget,
)
```

The source and destination routes use the same tag:

```text
Route A
Hero(tag: X)
      │
      │
      ▼
Route B
Hero(tag: X)
```

Flutter then creates the Hero flight between them.

The most important concepts are:

* `Hero`
* `tag`
* Hero flight
* `HeroController`
* `HeroControllerScope`
* `flightShuttleBuilder`
* `placeholderBuilder`
* `transitionOnUserGestures`
* nested Navigator considerations

The most important mental model is:

```text
Navigator
    ↓
Two routes
    ↓
Matching Hero tags
    ↓
HeroController
    ↓
Hero flight
    ↓
Shared-element transition
```

---

# Related Topics

After Hero, continue with:

1. Shared-element transitions
2. Nested navigation
3. Navigator 2.0 / Router API
4. Deep linking
5. Advanced route transitions
