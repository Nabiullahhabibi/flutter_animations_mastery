# Phase 5 — Transition Animations

## Complete Senior-Level Guide

This phase covers Flutter's explicit transition widgets:

- FadeTransition
- ScaleTransition
- SlideTransition
- RotationTransition
- SizeTransition
- PositionedTransition
- DecoratedBoxTransition

The important thing is that these are not completely different animation systems.

They are specialized widgets that consume an existing `Animation<T>`.

---

# 1. The Big Picture

You already learned explicit animation in Phase 3:

```text
AnimationController
        ↓
Tween
        ↓
CurvedAnimation
        ↓
Animation<T>
        ↓
AnimatedBuilder / AnimatedWidget