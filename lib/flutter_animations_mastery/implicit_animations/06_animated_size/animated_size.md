# AnimatedSize

> Flutter Animation Mastery — Implicit Animations

---

## 1. What is AnimatedSize?

`AnimatedSize` is an **implicit animation widget** that automatically animates changes to the size of its child.

Instead of manually creating an `AnimationController`, `Tween`, listener, and animation lifecycle, you simply change the child's size and Flutter animates the transition.

Conceptually:

```text
Child size changes
       ↓
AnimatedSize detects the change
       ↓
Flutter animates between old size and new size
       ↓
Child smoothly grows/shrinks
```

For example:

```text
Before:

┌──────────────┐
│              │
│    Button    │
│              │
└──────────────┘


After:

┌──────────────────────────────┐
│                              │
│        Larger Button         │
│                              │
└──────────────────────────────┘
```

The important point is:

> **AnimatedSize does not decide the child's new size. It animates the size change that your child already has.**

---

# 2. Why does AnimatedSize exist?

Without animation, when a widget's size changes, Flutter normally changes the layout immediately.

For example:

```dart
if (expanded) {
  return const Text(
    'A lot of additional content...',
  );
}
```

The layout may suddenly change:

```text
Small
┌─────────────┐
│ Title       │
└─────────────┘

        ↓

Large
┌─────────────┐
│ Title       │
│ Description │
│ More text   │
│ Actions     │
└─────────────┘
```

This can feel abrupt.

With `AnimatedSize`:

```text
Small
   ↓
Small +
   ↓
Medium
   ↓
Large
```

The layout transition becomes smooth.

---

# 3. AnimatedSize is an Implicit Animation

Flutter animations can broadly be divided into:

```text
Flutter Animations
│
├── Implicit Animations
│   ├── AnimatedContainer
│   ├── AnimatedOpacity
│   ├── AnimatedPadding
│   ├── AnimatedAlign
│   ├── AnimatedSize
│   └── TweenAnimationBuilder
│
└── Explicit Animations
    ├── AnimationController
    ├── Animation<T>
    ├── Tween
    ├── AnimatedBuilder
    └── etc.
```

`AnimatedSize` belongs to:

```text
Implicit Animation
```

That means Flutter manages most of the animation machinery for you.

You provide:

```dart
duration
```

and optionally:

```dart
curve
```

Then you simply change the child's size.

---

# 4. Basic Syntax

A basic `AnimatedSize` looks like this:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: YourWidget(),
)
```

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Container(
    width: expanded ? 300 : 100,
    height: expanded ? 200 : 50,
  ),
)
```

When `expanded` changes:

```text
100 × 50
   ↓
300 × 200
```

`AnimatedSize` animates the size transition.

---

# 5. The Most Important Concept

The most important thing to understand is:

> **AnimatedSize animates the size of its child.**

It does not directly animate:

* color
* opacity
* position
* padding
* border radius
* rotation

Those are handled by other animation widgets.

For example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  width: expanded ? 300 : 100,
)
```

animates the `Container` property.

But:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: ...
)
```

animates the **resulting size of the child**.

This distinction is extremely important at senior level.

---

# 6. AnimatedSize vs AnimatedContainer

These two widgets are commonly confused.

## AnimatedContainer

`AnimatedContainer` animates specific properties of a container.

Example:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  width: expanded ? 300 : 100,
  height: expanded ? 200 : 50,
  color: expanded ? Colors.blue : Colors.red,
  padding: EdgeInsets.all(
    expanded ? 24 : 8,
  ),
)
```

It can animate:

```text
width
height
padding
margin
color
alignment
borderRadius
decoration
constraints
transform
etc.
```

---

## AnimatedSize

`AnimatedSize` observes the child's actual size.

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: expanded
      ? const Text(
          'This is a much larger amount of content.',
        )
      : const Text(
          'Short text',
        ),
)
```

The text itself determines the size.

```text
AnimatedContainer

You control the size
        ↓
width / height


AnimatedSize

Child determines the size
        ↓
AnimatedSize animates it
```

---

# 7. AnimatedSize with Text

One of the best uses of `AnimatedSize` is expanding text.

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Text(
    expanded
        ? longDescription
        : shortDescription,
  ),
)
```

When the text changes from one line to multiple lines:

```text
Collapsed

This is a short description.


Expanded

This is a short description that contains
additional information and therefore takes
more vertical space.
```

The height transition is animated.

---

# 8. AnimatedSize with Conditional Widgets

Another extremely common use is conditionally showing widgets.

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Column(
    children: [
      const Text('Profile'),

      if (expanded)
        const Text('Additional profile information'),
    ],
  ),
)
```

When:

```dart
expanded = false
```

the child is smaller.

When:

```dart
expanded = true
```

the child becomes larger.

`AnimatedSize` animates the transition.

---

# 9. Important: The Child Must Actually Change Size

This will not magically animate something that does not change its layout size.

For example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: const Icon(Icons.favorite),
)
```

There is no size change.

Therefore:

```text
No size change
      ↓
No meaningful AnimatedSize animation
```

Something inside the child must cause its layout dimensions to change.

---

# 10. How AnimatedSize Works Internally

Conceptually:

```text
Parent
  │
  ▼
AnimatedSize
  │
  ├── observes child's size
  │
  ├── previous size
  │
  ├── new size
  │
  └── animates between them
          │
          ▼
       RenderObject
```

When the child's layout changes:

```text
Old Size
   ↓
AnimatedSize detects difference
   ↓
Animation starts
   ↓
New Size
```

This happens during Flutter's layout/rendering process.

At a senior level, understand that `AnimatedSize` is not simply changing `width` and `height` itself.

It is a layout-aware animation.

---

# 11. Why AnimatedSize is Powerful

Consider an expandable card.

Without `AnimatedSize`:

```text
┌───────────────────────┐
│ Product               │
└───────────────────────┘

             ↓

┌───────────────────────┐
│ Product               │
│ Price                 │
│ Description           │
│ Rating                │
│ Actions               │
└───────────────────────┘
```

With `AnimatedSize`:

```text
┌───────────────────────┐
│ Product               │
└───────────────────────┘
          ↓
┌───────────────────────┐
│ Product               │
│ Price                 │
└───────────────────────┘
          ↓
┌───────────────────────┐
│ Product               │
│ Price                 │
│ Description           │
│ Rating                │
└───────────────────────┘
```

This produces a much more natural UI.

---

# 12. Important Properties

The most important properties are:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  alignment: Alignment.center,
  clipBehavior: Clip.hardEdge,
  child: ...
)
```

Let's understand them.

---

# 13. duration

Controls how long the size animation takes.

Example:

```dart
duration: const Duration(milliseconds: 300)
```

Common values:

```text
150ms
↓
Very fast

200ms
↓
Fast

300ms
↓
Common UI animation

400ms
↓
Slower

600ms+
↓
Usually noticeable/slow
```

For most UI interactions:

```dart
200ms - 350ms
```

is a reasonable starting point.

But duration should depend on the amount of movement and the interaction.

---

# 14. curve

Controls the motion behavior.

Example:

```dart
curve: Curves.easeInOut
```

Without thinking about curves:

```text
linear:

████████████████████
```

With easing:

```text
slow → fast → slow
```

Common choices:

```dart
Curves.easeInOut
Curves.easeOut
Curves.easeIn
Curves.fastOutSlowIn
Curves.decelerate
```

For UI expansion:

```dart
Curves.easeInOut
```

is often a good starting point.

---

# 15. alignment

`alignment` controls how the child is aligned while its size is being animated.

Example:

```dart
alignment: Alignment.topCenter
```

For vertical expansion, this can be especially useful.

For example:

```dart
alignment: Alignment.topCenter
```

means the expansion visually happens from the top.

Common choices:

```dart
Alignment.center
Alignment.topCenter
Alignment.bottomCenter
Alignment.centerLeft
Alignment.centerRight
```

---

# 16. clipBehavior

Controls whether content is clipped during the animation.

Example:

```dart
clipBehavior: Clip.hardEdge
```

Possible values include:

```dart
Clip.none
Clip.hardEdge
Clip.antiAlias
Clip.antiAliasWithSaveLayer
```

Use clipping intentionally.

For most normal UI cases:

```dart
Clip.hardEdge
```

or the default behavior is sufficient.

Avoid unnecessarily expensive clipping.

---

# 17. reverseDuration

Depending on your Flutter SDK version, `AnimatedSize` can provide a separate reverse duration.

Conceptually:

```text
Expand:

300ms


Collapse:

200ms
```

This can be useful when you want expansion and collapse to feel different.

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  reverseDuration: const Duration(milliseconds: 200),
  child: ...
)
```

This is useful for:

```text
Expand → slightly slower
Collapse → slightly faster
```

But don't use different durations just because you can.

Animation consistency matters more than unnecessary customization.

---

# 18. AnimatedSize and `if`

A very common pattern is:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Column(
    children: [
      title,

      if (expanded)
        details,
    ],
  ),
)
```

This is extremely useful.

When `expanded` changes:

```text
false:

Column
 └── title


true:

Column
 ├── title
 └── details
```

The overall size changes.

`AnimatedSize` animates it.

---

# 19. AnimatedSize and `Visibility`

You can combine `AnimatedSize` with `Visibility`.

However, understand what you are doing.

If the widget is completely removed from layout:

```dart
Visibility(
  visible: expanded,
  child: details,
)
```

then its size becomes zero when hidden.

Wrapping the whole structure with `AnimatedSize` can animate that transition.

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Visibility(
    visible: expanded,
    child: details,
  ),
)
```

This can be useful for expandable sections.

---

# 20. AnimatedSize and ListView

This is an important real-world scenario.

Suppose you have:

```text
ListView
 ├── Card
 ├── Card
 ├── Card
 ├── Card
 └── Card
```

A card expands.

Without animation:

```text
Card 1
Card 2
Card 3
Card 4
```

then suddenly:

```text
Card 1
Card 2
   ↓ expanded
Card 3
Card 4
```

With `AnimatedSize`, surrounding content moves smoothly.

This can create a very polished experience.

---

# 21. AnimatedSize and Accordion UI

Accordion components are one of the best real-world use cases.

Example:

```text
FAQ

What is Flutter?
────────────────────
Flutter is a UI toolkit...


What is Dart?
────────────────────
Dart is a programming language...


How does animation work?
────────────────────
Animation creates the perception of motion...
```

When an item expands:

```text
Question
   ↓
Answer appears
   ↓
Container grows
```

`AnimatedSize` handles the size transition.

---

# 22. AnimatedSize and FAQ

A typical implementation:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Column(
    children: [
      question,

      if (isExpanded)
        answer,
    ],
  ),
)
```

This is simple and effective.

For a production FAQ system, you may combine it with:

```text
AnimatedSize
+
AnimatedRotation
+
AnimatedOpacity
```

For example:

```text
Chevron rotates
+
Answer fades in
+
Container expands
```

---

# 23. AnimatedSize and Dropdown-like Content

AnimatedSize can be useful for custom dropdowns where the content itself determines the size.

For example:

```text
Select language

English
Spanish
French
German
```

When opened, the content appears and the container grows.

However, if you need sophisticated overlay positioning, Flutter's dedicated menu/dropdown systems may be more appropriate.

Don't use `AnimatedSize` simply because something visually expands.

Choose the correct architecture.

---

# 24. AnimatedSize and Error Messages

This is an excellent production use case.

Imagine a login form.

Normal:

```text
Email
[____________]

Password
[____________]

[ Login ]
```

Validation error:

```text
Email
[____________]
Invalid email address

Password
[____________]

[ Login ]
```

The error message increases the form's height.

With `AnimatedSize`:

```text
Form height
    ↓
smoothly expands
```

This prevents the UI from jumping abruptly.

---

# 25. AnimatedSize and Validation

For example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 250),
  child: Column(
    children: [
      TextField(),

      if (hasError)
        const Text(
          'Invalid email',
        ),
    ],
  ),
)
```

This is a very practical use.

---

# 26. AnimatedSize and Loading States

Suppose a button changes from:

```text
[ Submit ]
```

to:

```text
[ Loading... ]
```

If the content causes a size difference, `AnimatedSize` can smoothly adapt.

But for a fixed-width button, `AnimatedContainer` may be more appropriate.

The principle is:

> Choose AnimatedSize when the child's natural size is what you want to animate.

---

# 27. AnimatedSize and Empty States

Imagine:

```text
Cart

No items
```

Then the user adds an item.

The layout changes:

```text
Cart

Product
Price
Quantity
Total
```

If the surrounding layout should smoothly adapt, `AnimatedSize` can be useful.

---

# 28. AnimatedSize and Dynamic Content

This is one of the biggest strengths.

Suppose an API returns different amounts of text.

```text
API response
     ↓
Widget height changes
     ↓
AnimatedSize
     ↓
Smooth layout transition
```

Examples:

```text
Descriptions
Comments
Notifications
Error messages
Product details
User profiles
Chat messages
```

---

# 29. AnimatedSize and Chat UI

Consider a chat message.

Short message:

```text
┌─────────────────┐
│ Hello           │
└─────────────────┘
```

Long message:

```text
┌─────────────────┐
│ Hello, I wanted │
│ to tell you     │
│ something about │
│ the project...  │
└─────────────────┘
```

When content changes dynamically, `AnimatedSize` can make the layout transition smoother.

However, be careful with large chat lists because unnecessary layout animations can become expensive.

---

# 30. AnimatedSize and Notification Cards

A notification may initially display:

```text
New update
```

and then expand:

```text
New update

Flutter 3.x introduces...
Read more
```

`AnimatedSize` can animate the additional content.

---

# 31. AnimatedSize and "Read More"

This is one of the most common practical patterns.

Collapsed:

```text
Flutter is a framework for building beautiful,
natively compiled applications...
Read more
```

Expanded:

```text
Flutter is a framework for building beautiful,
natively compiled applications for mobile, web,
desktop and embedded platforms. It provides a
rich widget system and powerful rendering engine.

Read less
```

`AnimatedSize` can animate the height difference.

---

# 32. AnimatedSize and Product Cards

A product card can start as:

```text
┌─────────────────────────┐
│ Product Image           │
│ Product Name            │
│ $20                     │
└─────────────────────────┘
```

After expansion:

```text
┌─────────────────────────┐
│ Product Image           │
│ Product Name            │
│ $20                     │
│ Description             │
│ Rating                  │
│ Quantity                │
│ Add to Cart             │
└─────────────────────────┘
```

This is a perfect example of content-driven size animation.

---

# 33. AnimatedSize and Bottom Sheets

`AnimatedSize` can be useful inside custom bottom sheet content.

For example:

```text
Bottom Sheet
──────────────

Basic information
```

then:

```text
Bottom Sheet
──────────────

Basic information

Advanced options
Additional settings
More controls
```

The content grows.

However, for a draggable/resizable bottom sheet, use Flutter's appropriate sheet APIs rather than relying solely on `AnimatedSize`.

---

# 34. AnimatedSize and Settings Screens

A settings screen might contain:

```text
Notifications
```

When enabled:

```text
Notifications
   ├── Sound
   ├── Vibration
   ├── Preview
   └── Notification style
```

`AnimatedSize` can smoothly reveal these controls.

---

# 35. AnimatedSize and Authentication Forms

Real-world examples:

```text
Login
Register
Forgot password
OTP
Two-factor authentication
```

For example:

```text
Enter phone number
       ↓
OTP fields appear
       ↓
Form becomes taller
```

AnimatedSize can smooth the transition.

---

# 36. AnimatedSize and Onboarding

Onboarding screens sometimes contain dynamically changing content:

```text
Step 1
Short explanation
```

then:

```text
Step 2
Longer explanation
Additional controls
```

If the content height changes, `AnimatedSize` can smooth it.

---

# 37. AnimatedSize and Responsive UI

AnimatedSize can also work with responsive layouts.

For example:

```text
Mobile:

Title
Description


Tablet:

Title
Description
Actions
```

When the layout changes, the resulting size may change.

However:

> Do not use AnimatedSize to hide a fundamentally incorrect responsive layout.

Responsive layout and animation solve different problems.

---

# 38. AnimatedSize with AnimatedOpacity

This combination is very common.

Example:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: AnimatedOpacity(
    duration: const Duration(milliseconds: 200),
    opacity: expanded ? 1 : 0,
    child: details,
  ),
)
```

Now you get:

```text
Size animation
+
Fade animation
```

Visually:

```text
collapsed
    ↓
fade in
    +
expand
    ↓
expanded
```

This is much more polished than simply inserting the widget.

---

# 39. AnimatedSize with AnimatedRotation

Perfect for accordion/FAQ UI.

```text
Chevron:

▼

when expanded:

▲
```

Combine:

```text
AnimatedSize
+
AnimatedRotation
```

Result:

```text
Answer expands
+
Chevron rotates
```

---

# 40. AnimatedSize with AnimatedSwitcher

Another useful combination:

```text
AnimatedSwitcher
        +
AnimatedSize
```

For example:

```text
Loading
   ↓
Success
```

The content changes and the overall size changes.

`AnimatedSwitcher` handles the child transition.

`AnimatedSize` handles the resulting size transition.

---

# 41. AnimatedSize vs AnimatedSwitcher

These are different.

### AnimatedSize

Animates:

```text
size
```

### AnimatedSwitcher

Animates:

```text
old child
      ↓
new child
```

For example:

```text
AnimatedSwitcher
```

can produce:

```text
Login
  ↓
Loading
  ↓
Success
```

while:

```text
AnimatedSize
```

handles:

```text
small layout
  ↓
large layout
```

They can work together.

---

# 42. AnimatedSize vs AnimatedPositioned

`AnimatedPositioned` is mainly about:

```text
position
```

inside a `Stack`.

`AnimatedSize` is about:

```text
size
```

of the child.

Example:

```text
AnimatedPositioned
    ↓
x / y / top / left / right / bottom


AnimatedSize
    ↓
child size
```

Different responsibilities.

---

# 43. AnimatedSize vs AnimatedPadding

`AnimatedPadding` animates:

```text
padding
```

If padding changes, the widget's resulting size can change.

You could potentially use:

```dart
AnimatedPadding(...)
```

or:

```dart
AnimatedSize(
  child: Padding(...),
)
```

But they solve different problems.

Use the most direct abstraction.

---

# 44. When Should You Use AnimatedSize?

Use `AnimatedSize` when:

* the child's natural size changes
* content appears/disappears
* text changes length
* validation messages appear
* cards expand/collapse
* FAQ answers appear
* details sections open
* dynamic content changes
* a widget's height changes because of its content
* surrounding layout should smoothly adapt

---

# 45. When Should You NOT Use AnimatedSize?

Don't use it just because you want an animation.

Avoid it when:

* you need precise control over animation progress
* you need gestures controlling animation progress
* you need multiple synchronized animations
* you need a physics simulation
* you need custom animation timelines
* you need an explicit `AnimationController`
* the actual thing changing is opacity, color, rotation, etc.

In those situations, consider:

```text
AnimationController
Tween
AnimatedBuilder
CustomPainter
Physics simulation
Hero
etc.
```

---

# 46. AnimatedSize and Performance

AnimatedSize is convenient, but it is still a layout animation.

During the animation, Flutter needs to repeatedly handle layout changes.

Conceptually:

```text
Frame 1
Layout
Paint

Frame 2
Layout
Paint

Frame 3
Layout
Paint

...
```

Therefore, avoid animating huge parts of the widget tree unnecessarily.

---

# 47. Performance Rule

Prefer:

```text
small localized AnimatedSize
```

over:

```text
entire screen AnimatedSize
```

For example:

Good:

```text
Screen
 ├── Header
 ├── ProductCard
 │    └── AnimatedSize
 └── Footer
```

Less ideal:

```text
AnimatedSize
 └── Entire Screen
      ├── Header
      ├── List
      ├── Footer
      └── Everything
```

The larger the layout affected, the more work Flutter may need to perform.

---

# 48. AnimatedSize Inside ListView

Be careful when many items use `AnimatedSize`.

Example:

```text
ListView
 ├── AnimatedSize
 ├── AnimatedSize
 ├── AnimatedSize
 ├── AnimatedSize
 ├── AnimatedSize
 └── AnimatedSize
```

If many items animate simultaneously, layout work can increase.

For a small number of expandable items, this is usually fine.

For large/high-frequency lists:

* keep animations localized
* avoid unnecessary rebuilds
* use stable keys where appropriate
* profile if performance becomes a concern

---

# 49. Keys and AnimatedSize

Keys become important when dynamically changing lists.

For example:

```dart
ListView.builder(
  itemBuilder: (context, index) {
    return AnimatedSize(
      key: ValueKey(items[index].id),
      ...
    );
  },
)
```

Stable keys help Flutter correctly associate widgets with their corresponding data.

Don't add keys randomly.

Use them when widget identity matters.

---

# 50. AnimatedSize and State Management

`AnimatedSize` itself does not manage your application state.

For example:

```dart
bool expanded = false;
```

The state determines:

```text
expanded?
```

`AnimatedSize` determines:

```text
how the size transition happens
```

Think:

```text
State Management
      ↓
"What should the UI look like?"

AnimatedSize
      ↓
"How should the size change?"
```

This separation is extremely important.

---

# 51. Architectural Thinking

At senior level, don't put business logic inside animation widgets.

Bad:

```dart
AnimatedSize(
  child: ...
)
```

with lots of:

```text
API logic
database logic
business rules
authentication
etc.
```

Instead:

```text
State
 ↓
UI decision
 ↓
AnimatedSize
 ↓
Visual transition
```

Animation should remain a presentation concern.

---

# 52. Example Architecture

A clean architecture might look like:

```text
ProductController
       │
       ▼
isExpanded
       │
       ▼
ProductCard
       │
       ▼
AnimatedSize
       │
       ▼
ProductDetails
```

The controller doesn't need to know how the expansion is animated.

The UI decides that.

---

# 53. Common Mistake #1

Using `AnimatedSize` when you actually need explicit animation.

Example requirement:

```text
User drags card upward
      ↓
animation follows finger
      ↓
release
      ↓
physics decides final position
```

`AnimatedSize` is not the right tool.

Use:

```text
GestureDetector
+
AnimationController
+
physics
```

---

# 54. Common Mistake #2

Using `AnimatedSize` to animate width when `AnimatedContainer` is more appropriate.

If you explicitly control:

```dart
width: expanded ? 300 : 100
```

then:

```dart
AnimatedContainer
```

may be clearer.

If the width is naturally determined by child content:

```dart
AnimatedSize
```

may be better.

---

# 55. Common Mistake #3

Animating huge layouts.

Avoid:

```dart
AnimatedSize(
  child: EntireApplicationScreen(),
)
```

unless you have a very specific reason.

Prefer localized animations.

---

# 56. Common Mistake #4

Using extremely long durations.

For example:

```dart
duration: const Duration(seconds: 3)
```

For a small accordion interaction, this usually feels terrible.

Use durations appropriate for the interaction.

---

# 57. Common Mistake #5

Combining too many animations

For example:

```text
Size
+
Opacity
+
Rotation
+
Scale
+
Slide
+
Color
+
Blur
```

for a simple FAQ expansion.

This can make the interface feel over-engineered.

Senior UI engineering is not:

> "Use more animation."

It is:

> "Use the minimum animation necessary to communicate state and preserve spatial continuity."

---

# 58. Senior Rule: Animate Layout Changes Intentionally

When something appears or disappears, ask:

```text
Does the surrounding layout move?
```

If yes, `AnimatedSize` may be useful.

If no, perhaps:

```text
AnimatedOpacity
AnimatedScale
AnimatedSwitcher
```

is more appropriate.

---

# 59. Decision Tree

Use this mental model:

```text
Something changes
       │
       ▼
Does its layout size change?
       │
       ├── NO
       │    │
       │    ├── opacity → AnimatedOpacity
       │    ├── color → AnimatedContainer
       │    ├── position → AnimatedPositioned
       │    ├── alignment → AnimatedAlign
       │    └── transform → AnimatedContainer
       │
       └── YES
            │
            ▼
     Is the size naturally
     determined by the child?
            │
            ├── YES
            │     ↓
            │  AnimatedSize
            │
            └── NO
                  ↓
             AnimatedContainer
```

This is a very useful senior-level decision rule.

---

# 60. Real-World Use Cases

`AnimatedSize` is particularly useful for:

### Content

* Read more / Read less
* expandable descriptions
* dynamic text
* comments
* notifications
* API-driven content

### Forms

* validation messages
* password requirements
* optional fields
* OTP fields
* registration steps
* authentication flows

### Cards

* expandable product cards
* profile cards
* notification cards
* order cards
* transaction cards
* dashboard cards

### Navigation/UI

* accordion menus
* FAQ sections
* settings sections
* expandable navigation groups
* custom dropdown content

### Applications

* chat interfaces
* shopping apps
* banking dashboards
* admin dashboards
* social media feeds
* education apps
* task management apps
* profile screens

---

# 61. Real-World Example: FAQ

A typical architecture:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  child: Column(
    children: [
      QuestionHeader(),

      if (expanded)
        Answer(),
    ],
  ),
)
```

Add:

```text
AnimatedRotation
```

for the arrow.

Result:

```text
Question
    ↓
Arrow rotates
    +
Answer appears
    +
Container expands
```

---

# 62. Real-World Example: Form Error

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 250),
  child: Column(
    children: [
      EmailField(),

      if (emailError != null)
        ErrorMessage(
          message: emailError!,
        ),
    ],
  ),
)
```

This is one of the best practical applications.

---

# 63. Real-World Example: Read More

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Text(
    expanded
        ? fullDescription
        : shortDescription,
  ),
)
```

This gives you a very simple content expansion animation.

---

# 64. Real-World Example: Product Details

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 350),
  child: Column(
    children: [
      ProductHeader(),

      if (expanded)
        ProductDetails(),
    ],
  ),
)
```

The product card naturally grows based on the content.

---

# 65. Real-World Example: Settings

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: Column(
    children: [
      NotificationSetting(),

      if (notificationsEnabled)
        NotificationOptions(),
    ],
  ),
)
```

This is cleaner than manually calculating heights.

---

# 66. Testing AnimatedSize

When testing UI containing `AnimatedSize`, remember that the animation takes time.

For widget tests, you may need to advance time:

```dart
await tester.pump(
  const Duration(milliseconds: 150),
);
```

Then complete:

```dart
await tester.pumpAndSettle();
```

Be careful with:

```dart
pumpAndSettle()
```

when animations can continuously repeat.

---

# 67. Debugging AnimatedSize

If the animation doesn't work, check:

### 1. Is the child actually changing size?

```text
Old size == New size
```

means there is nothing to animate.

### 2. Is the child condition actually changing?

Check your state.

### 3. Is the parent constraining the size?

Sometimes the parent gives the child fixed constraints.

### 4. Are you using the correct widget?

Maybe you actually need:

```text
AnimatedContainer
AnimatedSwitcher
AnimatedOpacity
```

### 5. Is another widget controlling the layout?

Understand the constraint chain.

---

# 68. Constraints Matter

Flutter's layout model is:

```text
Constraints go down
Sizes go up
Parent sets position
```

`AnimatedSize` works within this layout system.

Therefore, if a parent imposes a strict constraint:

```text
Parent
  ↓
Fixed height
  ↓
Child
```

the child may not be able to freely change size.

This is one reason understanding Flutter constraints is essential before mastering layout animations.

---

# 69. AnimatedSize and Unbounded Constraints

Be careful with unbounded layouts.

For example, complex combinations involving:

```text
Column
+
ListView
+
AnimatedSize
```

can expose constraint problems.

If you see errors such as:

```text
Vertical viewport was given unbounded height
```

the problem is not necessarily `AnimatedSize`.

It may be the surrounding layout constraints.

Always debug the layout hierarchy first.

---

# 70. Senior Mental Model

Think of `AnimatedSize` as:

```text
"Animate the result of layout."
```

Not:

```text
"Animate a width property."
```

This distinction is extremely important.

---

# 71. AnimatedSize vs Explicit Animation

Implicit:

```dart
AnimatedSize(
  duration: const Duration(milliseconds: 300),
  child: content,
)
```

Explicit:

```text
AnimationController
        ↓
Tween
        ↓
Animation
        ↓
AnimatedBuilder
        ↓
custom layout
```

Implicit animation:

```text
Simple
Less code
Automatic lifecycle
Good for standard UI transitions
```

Explicit animation:

```text
More control
More complexity
Gesture control
Synchronization
Custom timelines
Advanced interactions
```

---

# 72. When AnimatedSize is the Best Choice

Choose `AnimatedSize` when the requirement sounds like:

> "This content appears/disappears and I want the surrounding layout to smoothly resize."

Examples:

```text
FAQ expands
Form error appears
Card details appear
Read more expands
Settings section opens
Dynamic content changes height
```

That sentence should immediately make you think:

```text
AnimatedSize
```

---

# 73. When Another Animation is Better

Requirement:

> "I want the widget to fade."

Use:

```text
AnimatedOpacity
```

Requirement:

> "I want the widget to move."

Use:

```text
AnimatedPositioned
AnimatedSlide
```

Requirement:

> "I want the widget to rotate."

Use:

```text
AnimatedRotation
RotationTransition
```

Requirement:

> "I want to control animation with a gesture."

Use:

```text
AnimationController
```

Requirement:

> "I want physics."

Use:

```text
AnimationController
SpringSimulation
FrictionSimulation
etc.
```

---

# 74. Production Checklist

Before using `AnimatedSize`, ask:

* Does the child naturally change size?
* Does the surrounding layout need to move smoothly?
* Is the animation localized?
* Is the duration appropriate?
* Is the curve appropriate?
* Are the constraints valid?
* Is the widget inside a large scrolling list?
* Could another implicit animation be more appropriate?
* Do I need explicit animation control?
* Is the animation improving UX rather than distracting?

---

# 75. Final Summary

`AnimatedSize` is one of Flutter's most useful implicit animations for **content-driven layout changes**.

The core idea is:

```text
Child changes size
       ↓
AnimatedSize detects change
       ↓
Flutter interpolates the size
       ↓
Layout changes smoothly
```

Remember:

```text
AnimatedContainer
    ↓
Animate known properties


AnimatedSize
    ↓
Animate resulting child size
```

The most important real-world applications are:

```text
FAQ
Accordion
Read More
Validation errors
Expandable cards
Dynamic content
Product details
Settings sections
Notification panels
Authentication forms
Chat content
Dashboard cards
```

And the most important senior-level principle is:

> **Use AnimatedSize when the layout itself needs to transition smoothly because the child's natural size changed.**
