# ARL v1.10 Recovery

This file records the work recovered after the interrupted/error turn.

## Recovered motion-stability work
- Deterministic fine-GI and contact-ray patterns to eliminate visible spatial-hash checkerboard changes.
- 24 fine-GI rays and 20 contact rays.
- Motion-priority probe refresh with burst budgets around moving lights.
- Strong Lighting Debt invalidation without destructive confidence resets.
- Much faster convergence in high-debt motion regions.
- Tighter direct/contact ray biases.
- Near-field exact visibility for nearby probe interpolation.
- Zero fake GI fallback for current ARL dark/uncovered regions.

## Recovered game-engine stress work
- 240×240 open-world test map.
- Camera-tracking / scrolling ARL probe volume so the system does not require probes over the whole world.
- Global directional sun with azimuth and elevation controls.
- Open-world sun stress preset.
- Chaos preset with four fast-moving lights, repeated explosion bursts, volumetrics, a live sun, and crisis refresh scheduling.
- Extended camera far plane for world-scale testing.

## Recovered diagnostics
- Geometry ID Colors.
- Direct Shadow Mask.
- Fine/World Blend.
- GI tracking-center metric.
- Chaos-state metric.

## Important
The WebGL/JavaScript syntax has been checked. This environment cannot initialize a WebGL/EGL display, so the final GPU shader compile still has to be verified in the Windows/browser test harness.
