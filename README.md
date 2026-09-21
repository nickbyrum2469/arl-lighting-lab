# ARL Lighting Lab

ARL (Adaptive Radiance Ledger) is an experimental real-time lighting architecture for a custom game engine. The core idea is to treat lighting as persistent world knowledge with confidence, variability, age, and lighting debt, then spend update work where the solution is changing or uncertain instead of refreshing the entire light field every frame.

## Current build — v1.8 Multi-Scale Detail Radiance

v1.8 is intentionally a **real solver change**, not another UI pass. It combines:

- a persistent directional world radiance ledger for broad, stable GI;
- directional visibility moments and probe relocation/classification;
- a new short-range surface gather that traces local one-bounce transport at the shaded point to recover detail the coarse world grid cannot represent;
- smoother contact occlusion instead of multiplying the entire GI solution by coarse hard masks;
- increased world probe density (18×9×18 versus 16×8×16 in v1.7);
- chroma-preserving tone mapping for stronger warm/cool bounce separation;
- crisp exact direct shadows in the main ARL path;
- visible emissive light sources, moving lights, volumetric scattering, material/roughness tests, pitch-black tests, leak torture tests, and a fine-detail torture gallery.

### Run

On Windows, run `Launch_ARL_v1_8.bat`. It starts a local HTTP server at `http://127.0.0.1:8765/`.

You can also open `index.html` directly, but localhost avoids browser `file://` security quirks.

## Recommended comparisons

1. `Direct Baseline` vs `ARL v1.8 — Multi-Scale Hybrid`
2. `ARL v1.8 — Fine GI Only` vs `ARL v1.8 — World GI Only`
3. `ARL v1.8 — Fine/World Difference`
4. Preset: `Fine-detail torture gallery`
5. Preset: `Pitch-black light ramp`
6. Preset: `Thin-wall leak torture`
7. Preset: `Moving-light arena`

## Architecture direction

ARL is evolving away from a single uniform-probe answer toward a multi-scale renderer:

- authoritative direct visibility/shadows;
- fine near-field transport for contacts, gaps, corners, and local color bounce;
- persistent world-space radiance for room/building scale transport;
- adaptive lighting debt scheduling;
- visibility moments / classification / relocation;
- volumetric lighting as a separate participating-media representation.

The next major research directions are true hierarchical radiance cascades, local light reservoirs, richer directional encoding, and GPU compute migration.
