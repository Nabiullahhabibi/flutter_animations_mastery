# Shared-Element Transitions

## 1. Introduction

A **shared-element transition** is an animation where the same visual element appears to move from one screen to another.

For example:

```text
Product List                 Product Details

┌──────────┐
│          │
│  IMAGE   │ ───────────────► ┌────────────────┐
│          │                  │                │
└──────────┘                  │     IMAGE      │
                              │                │
                              └────────────────┘
```

Instead of:

```text
Screen A disappears
        ↓
Screen B appears
```

the user perceives:

```text
Element on Screen A
        ↓
travels
        ↓
Element on Screen B
```

This creates a strong visual relationship between the two screens.

---

# 2. Shared Element vs Normal Page Transition

A normal page transition animates the entire page.

For example:

```text
Screen A
    ↓
Fade
    ↓
Screen B
```

A shared-element transition focuses on a specific element:

```text
Screen A
    │
    └── Image
          ↓
       moves
          ↓
Screen B
    │
    └── Larger Image
```

You can also combine both:

```text
Page transition
      +
Shared element
      ↓
Complete navigation experience
```

---

# 3. Hero Is Flutter's Main Shared-Element Mechanism

Flutter provides the `Hero` widget for shared-element transitions.

Example:

```dart
Hero(
  tag: 'product-image',
  child: Image.asset(
    'assets/product.png',
  ),
)
```

The destination route uses the same tag:

```dart
Hero(
  tag: 'product-image',
  child: Image.asset(
    'assets/product.png',
  ),
)
```

Flutter recognizes the matching tags and performs the shared-element transition.

Therefore:

```text
Shared-element transition
          │
          ▼
       Hero widget
```

For most Flutter applications, `Hero` is the correct tool.

---

# 4. Why Have a Separate Shared-Element Topic?

You already learned `Hero`.

The difference is:

### Hero topic

Focuses on the Flutter API:

```dart
Hero(
  tag: '...',
  child: ...,
)
```

### Shared-element transition topic

Focuses on the **animation concept and architecture**:

```text
Source element
      ↓
Navigation
      ↓
Matching destination element
      ↓
Hero flight
      ↓
Destination element
```

This distinction is useful because shared-element transitions are a broader UI/UX concept, while `Hero` is Flutter's primary implementation.

---

# 5. The Shared-Element Pattern

The basic pattern is:

```text
Source Route
     │
     └── Shared Element A
              │
              │ matching identity
              ▼
Destination Route
     │
     └── Shared Element B
```

For Hero:

```text
Hero(tag: X)
       │
       │
       ▼
Hero(tag: X)
```

The matching `tag` tells Flutter that the two widgets represent the same visual element.

---

# 6. Example: Product Image

List screen:

```dart
Hero(
  tag: 'product-42',
  child: Image.network(
    product.imageUrl,
  ),
)
```

Details screen:

```dart
Hero(
  tag: 'product-42',
  child: Image.network(
    product.imageUrl,
  ),
)
```

The user sees:

```text
Small product image
        ↓
      grows
        ↓
Large product image
```

---

# 7. The Important Relationship

A shared-element transition usually has three pieces:

```text
1. Source element
        ↓
2. Navigation
        ↓
3. Destination element
```

For example:

```text
ProductCard
    │
    │ tap
    ▼
Navigator.push()
    │
    ▼
ProductDetails
```

The Hero system connects the visual elements across that navigation.

---

# 8. Shared Element Does Not Mean Identical Widget

The source and destination widgets don't have to be exactly the same size.

Example:

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
  width: 320,
  height: 320,
  child: ...
)
```

The important thing is that they represent the same visual element and have matching Hero identity.

---

# 9. Shared Element Can Change Layout

Suppose the source element is:

```text
┌──────────┐
│          │
│  IMAGE   │
│          │
└──────────┘
```

and the destination is:

```text
┌──────────────────────┐
│                      │
│        IMAGE         │
│                      │
└──────────────────────┘
```

The Hero flight interpolates the element's position and size.

This is what creates the shared-element illusion.

---

# 10. Shared Element With Different Context

A common pattern is:

```text
Home
 └── Product Card
       └── Image

          ↓ navigation

Details
 └── Product Header
       └── Image
```

The image exists in completely different layout structures.

The Hero system creates the visual connection.

This is one of the most powerful aspects of shared-element transitions.

---

# 11. Shared Element Architecture

Conceptually:

```text
┌──────────────────────┐
│      Navigator       │
└──────────┬───────────┘
           │
      Route transition
           │
     ┌─────▼─────┐
     │   Hero    │
     │ Controller│
     └─────┬─────┘
           │
      Hero Flight
           │
     ┌─────▼─────┐
     │  Overlay  │
     └───────────┘
```

The Hero flight is coordinated separately from the normal layout positions.

---

# 12. Hero Flight

The actual movement between the two locations is called a **Hero flight**.

Conceptually:

```text
Start
  │
  ▼
┌────────┐
│ IMAGE  │
└────────┘
  │
  │
  │ Hero flight
  │
  ▼
┌──────────────────┐
│      IMAGE       │
└──────────────────┘
  │
  ▼
End
```

During the flight, Flutter handles the visual transition between the two Hero locations.

---

# 13. Position Interpolation

Suppose the source is located at:

```text
x = 20
y = 100
```

and the destination is:

```text
x = 40
y = 250
```

The Hero transition interpolates between those positions.

Conceptually:

```text
Start position
      ↓
interpolation
      ↓
intermediate position
      ↓
interpolation
      ↓
destination position
```

This is why the element appears to physically travel through the UI.

---

# 14. Size Interpolation

The same concept applies to size.

For example:

```text
Start:

80 × 80

       ↓

160 × 160

       ↓

240 × 240

       ↓

320 × 320
```

The element smoothly grows during the transition.

---

# 15. Hero Flight and Curves

The transition can also use curves.

For example:

```dart
CurvedAnimation(
  parent: animation,
  curve: Curves.easeInOut,
)
```

The curve determines how the transition progresses over time.

Conceptually:

```text
Linear
████████████████

Ease In/Out
███████
      █████
           ████
```

This can make the movement feel more natural.

---

# 16. Custom Flight Widget

Flutter's Hero API allows you to customize the visual widget used during the flight.

The important API is:

```dart
flightShuttleBuilder
```

Example:

```dart
Hero(
  tag: 'product',
  flightShuttleBuilder: (
    flightContext,
    animation,
    flightDirection,
    fromHeroContext,
    toHeroContext,
  ) {
    return const Icon(
      Icons.shopping_bag,
      size: 100,
    );
  },
  child: ...,
)
```

Now the element shown during the flight can be different from the source and destination widgets.

---

# 17. Why Would You Customize the Flight?

Imagine:

```text
Source:
small image

Destination:
large image
```

You might want the flight to:

```text
Image
  ↓
Rounded image
  ↓
Image with shadow
  ↓
Large image
```

A custom flight widget allows more control over this experience.

---

# 18. Custom Shared-Element Pattern

A more advanced design can look like:

```text
Source
  │
  └── Small Card
        │
        ▼
   Hero Flight
        │
        ├── scale
        ├── position
        ├── opacity
        └── shape
        │
        ▼
Destination
  │
  └── Large Card
```

This can create highly polished application transitions.

---

# 19. Shared Element vs Explicit Animation

Explicit animation:

```text
AnimationController
       ↓
Tween
       ↓
Widget
```

Shared-element animation:

```text
Source route
       ↓
Matching element
       ↓
Navigator transition
       ↓
Destination route
```

The important difference is that shared-element transitions connect **two different route layouts**.

---

# 20. Shared Element vs PageRouteBuilder

`PageRouteBuilder` controls the page transition.

Example:

```text
Screen A
    ↓
Slide
    ↓
Screen B
```

Shared-element transition controls a specific element:

```text
Image A
   ↓
Hero flight
   ↓
Image B
```

They can be combined:

```text
PageRouteBuilder
       +
Hero
       ↓
Custom page + shared-element transition
```

---

# 21. Common Shared-Element Examples

Shared-element transitions are commonly used for:

### Images

```text
Thumbnail → Full-screen image
```

### Product cards

```text
Product card → Product details
```

### Profile avatars

```text
Small avatar → Large profile avatar
```

### Articles

```text
Article thumbnail → Article header image
```

### Media

```text
Video thumbnail → Video player
```

### Cards

```text
Small card → Full-screen card
```

---

# 22. Stable Identity

One of the most important engineering considerations is the identity of the shared element.

Bad:

```dart
Hero(
  tag: index,
  child: ...
)
```

Better:

```dart
Hero(
  tag: 'product-${product.id}',
  child: ...
)
```

The tag should represent the actual entity.

For example:

```text
Product ID 42
      ↓
product-42
```

This remains stable even if the list order changes.

---

# 23. Multiple Shared Elements

A single navigation transition can contain multiple shared elements.

For example:

```text
Product List
 ├── Image
 ├── Title
 └── Price

        ↓

Product Details
 ├── Image
 ├── Title
 └── Price
```

You could theoretically coordinate multiple Hero elements.

For example:

```dart
Hero(
  tag: 'product-image-42',
  child: ...,
)

Hero(
  tag: 'product-title-42',
  child: ...,
)
```

However, multiple Hero transitions should be used carefully.

Too many moving elements can make navigation feel noisy.

---

# 24. Common Mistakes

## Mistake 1 — Different tags

Source:

```dart
Hero(
  tag: 'product-1',
  child: ...,
)
```

Destination:

```dart
Hero(
  tag: 'product-2',
  child: ...,
)
```

These do not match.

They need the same identity.

---

## Mistake 2 — Duplicate tags

Don't do:

```dart
Hero(
  tag: 'image',
  child: ...
)

Hero(
  tag: 'image',
  child: ...
)
```

when both are active within the same route.

---

## Mistake 3 — Using unstable IDs

Avoid using list indexes as the identity when data can reorder.

Prefer:

```dart
product.id
```

---

## Mistake 4 — Using Hero everywhere

Not every navigation needs a shared-element animation.

Use it where the visual relationship is meaningful.

---

# 25. Nested Navigation

Shared-element transitions become more complicated with nested Navigators.

Example:

```text
Root Navigator
      │
      ├── Home Navigator
      │
      ├── Search Navigator
      │
      └── Profile Navigator
```

A Hero transition generally needs the source and destination to participate in the same relevant navigation hierarchy.

This is important when building applications with:

* bottom navigation
* tab navigation
* nested navigation
* shell routes
* multiple navigation stacks

---

# 26. Performance

Shared-element transitions happen during navigation and should remain lightweight.

Be careful with:

* huge images
* complex widget trees
* expensive custom painting
* expensive effects
* unnecessary rebuilds

For images, consider appropriate image sizing and caching.

For example, don't unnecessarily animate a full-resolution multi-megapixel image if a smaller version is sufficient for the transition.

---

# 27. UX Considerations

A shared-element transition should communicate a relationship.

Good:

```text
Product thumbnail
       ↓
Same product's large image
```

Bad:

```text
Random icon
       ↓
Completely unrelated screen element
```

The user should understand:

> "This is the same thing moving to the next screen."

That is the purpose of the pattern.

---

# 28. Senior-Level Mental Model

At senior level, don't think:

> "Hero makes an image bigger."

Think:

> "A shared-element transition establishes a visual identity across two route states."

The architecture is:

```text
Route A
   │
   └── Element Identity X
             │
             │
       Navigator transition
             │
             ▼
        Hero system
             │
             ▼
         Hero flight
             │
             ▼
Route B
   │
   └── Element Identity X
```

This is much more powerful than simply thinking about scaling an image.

---

# 29. Practical Implementation

The simplest implementation is still:

```dart
Hero(
  tag: 'product-${product.id}',
  child: ProductImage(
    product: product,
  ),
)
```

on both screens.

Navigation:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) {
      return ProductDetailsScreen(
        product: product,
      );
    },
  ),
);
```

Flutter handles the shared-element transition.

---

# 30. When to Use Shared-Element Transitions

Use them when:

* the same object appears on both screens
* the relationship should be visually obvious
* the transition improves navigation understanding
* the design benefits from continuity

Examples:

```text
Gallery → Photo Details
Product List → Product Details
Feed → Post Details
Users → Profile
Video List → Video Player
```

---

# 31. When Not to Use Them

Avoid them when:

* the screens are unrelated
* there is no meaningful shared element
* the animation makes navigation slower
* there are too many competing animations
* the transition distracts from the content

Navigation should remain clear and fast.

---

# 32. Final Mental Model

Remember:

```text
Shared Element
       │
       ▼
Same visual identity
       │
       ▼
Two different routes
       │
       ▼
Matching Hero tags
       │
       ▼
Hero Controller
       │
       ▼
Hero Flight
       │
       ▼
Destination element
```

In Flutter:

```text
Shared-element transition
          ↓
        Hero
          ↓
    matching tag
          ↓
      Hero flight
```

`Hero` is therefore not a completely separate animation system from shared-element transitions. It is Flutter's primary implementation of the shared-element transition pattern.

---

# Summary

A shared-element transition visually connects an element between two routes.

The most important ideas are:

* Source element
* Destination element
* Stable identity
* Matching Hero tags
* Hero flight
* HeroController
* Custom flight widgets
* Route coordination
* Nested Navigator considerations
* Performance
* UX purpose

The most important rule is:

```text
Same conceptual element
+
Matching Hero identity
+
Different route positions
=
Shared-element transition
```

---

# Related Topics

You have now covered:

1. `PageRoute`
2. `PageRouteBuilder`
3. `Hero`
4. Shared-element transitions

The next logical navigation topics are:

5. Nested Navigation
6. Navigator 2.0 / Router API
7. Deep Linking
