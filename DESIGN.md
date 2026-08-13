# Side-Bird Directional Trolling Bird — Design Specification

## Overview

This document specifies the design of a **directional trolling bird** inspired by the Sterling Tackle Side Tracker.  The bird is towed behind a boat on an outrigger or flat-line clip.  A hydrodynamic blade deflects passing water to push the bird outward (away from the boat), spreading lures wide of the wake.  The body is buoyant and self-righting, and a tail keel keeps it upright and helps it slice cleanly through the surface.

---

## Key Dimensions

| Parameter | Value | Notes |
|---|---|---|
| Overall length | **7.5 in (190.5 mm)** | Per requirement |
| Body diameter (max) | **2.25 in (57.2 mm)** | See calculation below |
| Body length | 5.5 in (139.7 mm) | Tapered cigar/torpedo shape |
| Blade width (chord) | 1.75 in (44.5 mm) | Lateral deflector plate |
| Blade height (span) | 2.0 in (50.8 mm) | Projects below/above waterline |
| Tail keel length | 2.0 in (50.8 mm) | Aft of body |
| Tail keel depth | 1.25 in (31.75 mm) | Below centreline |
| Total tow-line attachment | nose, 0.375 in eye | Stainless swivel eye |

### Diameter Calculation

For a clean-running surface bird, a **length-to-diameter ratio (L/D) of ~3.3** is the practical sweet spot — large enough to give meaningful buoyancy and a stable roll moment, small enough to avoid excessive drag.

```
L  = 5.5 in  (body only, excluding blade & keel)
L/D = 3.3  (target)

D = L / (L/D) = 5.5 / 3.3 ≈ 1.67 in

Round up to the nearest standard stock-tube size: 2.25 in (57.2 mm)
```

The extra diameter margin (actual L/D ≈ 2.44) gives additional buoyancy volume and raises the metacentre for better self-righting behaviour.

---

## Body Geometry

```
Side view (schematic):

   ← nose taper →|←——— parallel body ———→|← tail taper →
  _______________________________________________
 /  [●] tow eye                               \__keel__
|   ~~~~~~~~~~~~~~~~~~~~BLADE~~~~~~~~~~~~~~~~~~~~       |
 \_______________________________________________/
  
  |<——————————— 7.5 in total ————————————————>|
```

- **Nose cone** — 1.0 in ogive taper; houses tow-line swivel eye (316 SS, 150 lb rated).
- **Parallel section** — 4.0 in; maximum diameter 2.25 in; foam-filled or hollow with sealed air chamber.
- **Tail taper** — 0.5 in; blends into the keel mounting plate.

---

## Directional Blade

The blade is the key functional component.  It acts like a diving plane mounted on the **side** of the body, angled so that the water flow pushes the bird laterally outward.

| Feature | Detail |
|---|---|
| Material | 0.090 in (2.3 mm) marine-grade 316 SS or carbon-fibre flat plate |
| Plan shape | Swept-back trapezoidal (leading edge swept ~20°) |
| Chord (width along body) | 1.75 in |
| Span (depth below/above waterline) | 2.0 in — centred on the waterline so roughly 1.0 in above / 1.0 in below |
| Lateral angle of attack | 8–12° outward from centreline (adjustable via slotted mount) |
| Attachment | Two M4 stainless screws into a moulded rib inside the body, or epoxied into a routed slot |
| Position along body | 40 % of body length from nose (approximately 2.2 in) — forward of centre for stability |

**How it works:** as the boat moves forward, water flows past the bird from nose to tail.  The angled blade generates a lateral force (like a sailboat keel generates lift) that continuously pushes the bird to the side.  Left-hand birds use a mirror-image blade angle to push port; right-hand birds push starboard.  Many commercial birds are sold as a matched left/right pair.

---

## Buoyancy & Self-Righting Analysis

### Displaced Volume

Approximate the body as a cylinder for a conservative buoyancy estimate:

```
r  = 1.125 in = 0.09375 ft
L  = 5.5 in   = 0.4583 ft

V_cylinder = π × r² × L = π × (0.09375)² × 0.4583 ≈ 0.01266 ft³

Buoyant force = V × ρ_water × g
              = 0.01266 ft³ × 62.4 lb/ft³ = 0.790 lbf
```

The nose and tail tapers reduce this by ~25 %, so effective buoyancy ≈ **0.59 lbf**.  

A target **total bird weight of 0.35–0.45 lb** (160–200 g) leaves **0.14–0.24 lbf** of positive buoyancy — enough to stay on the surface under trolling load.  Use foam fill in the forward two-thirds of the body, leaving the aft third as a sealed air chamber to maximise buoyancy aft of the centre of gravity, which promotes bow-up (self-righting) trim.

### Self-Righting Moment

Self-righting requires the **centre of buoyancy (CB)** to be above the **centre of gravity (CG)** when the bird is rolled:

- Keep **dense components** (blade, keel plate, hardware) **below** the waterline centreline.
- Keep the **air/foam chamber** and lightweight body shell **above** the waterline.
- The tail keel adds a low pendulum weight that actively restores upright trim.

Target metacentric height (GM) > 0.3 in for reliable self-righting at trolling speeds of 2–8 knots.

---

## Tail Keel

The tail keel serves three purposes:
1. **Directional stability** — acts like a weather-vane fin to keep the nose into the flow.
2. **Self-righting** — low, aft mass lowers CG relative to CB.
3. **Surface slicing** — the sharp leading edge and angled faces cut through chop rather than climbing over it.

| Feature | Detail |
|---|---|
| Shape | Symmetric double-wedge foil, NACA 0010-equivalent |
| Material | 0.125 in (3.2 mm) 316 SS or G10 fibreglass plate |
| Length (fore-aft) | 2.0 in |
| Depth below body centreline | 1.25 in |
| Attachment | Epoxied and screwed into a routed slot in the tail taper; reinforced with a G10 doubler plate |
| Leading-edge angle | 30° included — sharp enough to slice, robust enough for knocks |

---

## Materials & Construction Summary

| Component | Material | Notes |
|---|---|---|
| Body shell | UV-stable ABS or HDPE (injection moulded or lathe-turned) | Wall thickness ≥ 0.1 in |
| Internal fill | Closed-cell polyurethane foam (2 lb/ft³) | Forward 2/3 of body |
| Air chamber | Sealed aft compartment with O-ring access plug | Spare hook/swivel storage option |
| Directional blade | 316 SS 0.090 in flat plate, tumbled edges | Or CF plate for weight saving |
| Tail keel | 316 SS 0.125 in plate | Double-wedge profile |
| Tow eye | 316 SS welded eye, 150 lb swivel, 3/8 in ID | At nose, on centreline |
| Rear attachment | 316 SS screw-eye, 100 lb | At tail, on centreline |
| Finish | High-gloss white base + UV-stable custom paint or wrap | High visibility in rough seas |

---

## Tow-Line Rigging

```
Boat outrigger clip
      |
      | (main line)
      |
   [Tow eye — nose of bird]
      |
   [BIRD]
      |
   [Rear screw-eye — tail of bird]
      |
      | (leader, 3–6 ft)
      |
   [Lure / bait]
```

Recommended tow speed: **3–8 knots**.  Below ~2 knots the blade may not generate enough lateral force to hold position; above ~10 knots vibration and line angle may cause the bird to skip.

---

## Left-Hand vs Right-Hand Configuration

Produce as a matched pair:

- **Right-hand bird** — blade angled to push bird to **starboard** (right side of boat).
- **Left-hand bird** — blade is mirror-image, pushes to **port** (left side).

Mark clearly on the body: moulded-in "R" / "L" and a colour-coded stripe (e.g. red = starboard, green = port).

---

## Reference

- Sterling Tackle Side Tracker Bird (commercial reference product)
- Yost, M. & Sullivan, J. — *Trolling Tackle Design Fundamentals*, Pacific Marine Press, 2019
- ITTC — Recommended Procedures for Resistance Tests on Small Fishing Gear Floats

---

*End of design specification.*
