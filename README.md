# ARL Lighting Lab

ARL (Adaptive Radiance Ledger) is an experimental real-time lighting architecture for a custom game engine.

The core idea is to treat lighting as persistent world knowledge — radiance, confidence, variability, age, visibility and **Lighting Debt** — then spend GPU/CPU work where lighting is changing or uncertain instead of refreshing everything every frame.

## Current build — ARL v3.0 Receiver-First Transport

v3.0 changes the lighting authority hierarchy rather than only adding more denoising.

### Main change

Visible receiver-local transport now gets first authority. Broad world probes are fallback memory.

When receiver-local transport and world-probe transport disagree:

- local/receiver evidence gets priority;
- world authority is reduced;
- unsupported broad energy is capped on dark receivers;
- uncertain world chroma is partially neutralized;
- temporal history confidence is reduced so a wrong stable cache result is not preserved forever.

### Current stack

- authoritative direct lighting and crisp direct shadows;
- persistent directional world radiance;
- widened 24-ray receiver-local surface gather (near + room-scale evidence);
- receiver/world transport agreement test;
- receiver/world chroma agreement test;
- receiver-first authority blending;
- visibility moments and exact near-field rejection;
- camera-tracking world volume;
- predictive Lighting Debt for moving lights;
- moving-light and explosion burst scheduling;
- screen-space spatio-temporal indirect reconstruction;
- edge-aware indirect denoising;
- global directional sun;
- mirror/specular path;
- volumetric scattering;
- open-world and chaos stress tests.

### New debug views

- `DEBUG — Receiver GI`
- `DEBUG — Receiver/World Authority`

The authority debug encodes receiver authority in red, transport agreement in green, and world-probe authority in blue.

### Startup behavior

v3.0 also ramps initial probe work over the first frames and staggers early coherence relaxation so direct lighting can appear immediately while ARL warms up instead of front-loading all cache work at startup.

## Validation

- JavaScript parse: PASS
- WebGL2 context via Chromium ANGLE/SwiftShader: PASS in a minimal shader harness
- surface shader compile/link: PASS
- temporal reconstruction shader compile/link: PASS
- spatial reconstruction shader compile/link: PASS
- composite shader compile/link: PASS

The sandbox browser currently blocks full local/file navigation by administrator policy, so the complete interactive scene could not be walked there. The Windows GPU/browser remains the authoritative visual/performance test.

## Next research targets

- surface-attached / hashed world radiance cache;
- true near / room / world / far radiance cascades;
- richer octahedral directional probe representation;
- screen-probe final gather;
- many-light reservoirs;
- separate persistent/transient radiance memories;
- proper animated-geometry motion vectors;
- dedicated rough-specular reconstruction;
- global Lighting Debt work auction across GI, reflections, volumetrics and direct-light reservoirs.