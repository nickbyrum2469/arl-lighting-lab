# ARL Lighting Lab

ARL (Adaptive Radiance Ledger) is an experimental real-time lighting architecture for a custom game engine.

The core idea is to treat lighting as persistent world knowledge — radiance, confidence, variability, age, visibility and **Lighting Debt** — then spend GPU/CPU work where the lighting solution is changing or uncertain instead of refreshing everything every frame.

## Current build — ARL v2.0 Reconstruction Renderer

v2.0 is the first build where ARL stops rendering the final image directly from the world probe field.

The current renderer is layered:

- authoritative direct lighting and crisp direct shadows;
- persistent directional world radiance;
- fine short-range surface GI for local bounce/contact detail;
- visibility moments and exact near-field rejection;
- camera-tracking world volume for open-world testing;
- moving-light and explosion debt scheduling;
- mirror/specular path kept separate from diffuse GI;
- **screen-space spatio-temporal reconstruction** for indirect lighting;
- history reprojection using world position and surface normal validation;
- history/variance clamp to prevent stale-light smearing;
- edge-aware spatial denoising that filters indirect light only;
- shared Direct/ARL exposure, tone mapping and color processing for honest A/B tests;
- High / Balanced / Performance reconstruction resolutions;
- global directional sun, volumetric scattering, mirror tests and open-world stress scenes;
- automated QA tour and adaptive-vs-full-refresh benchmark.

### New benchmark scene

`ARL 2.0 — Production benchmark district` is a connected indoor/outdoor test environment with interior/outdoor transitions, open sunlight, deep cover, continuous geometry, warm and cool dynamic lights, mixed materials, a near-perfect mirror, moving lights, and camera-tracking GI.

### Reconstruction debug views

The reconstruction section can show Final composite, Raw indirect, Denoised indirect, or Direct/material base. This makes it possible to tell whether an artifact comes from light transport or reconstruction.

## Architecture

Direct lighting stays authoritative. Persistent world radiance plus fine local surface GI produce a raw indirect buffer. That buffer is temporally reprojected with world-position/normal rejection, history-clamped, edge-aware filtered, and then recombined with the direct/material base through the same final tone/color path used by the Direct baseline.

Lighting Debt remains the scheduler for persistent world updates and is intended to expand into the scheduler for screen probes, radiance-cache entries, reflections, volumetrics and future light/path reservoirs.

## Validation

The v2.0 source passes JavaScript syntax validation. It has also been loaded in Chromium with WebGL2 through ANGLE/SwiftShader in an Xvfb test environment. The surface shader, temporal reconstruction shader, spatial denoiser and composite shader all compile and a reconstructed frame renders without a page error.

The real Windows GPU remains the authoritative performance/driver test.

## Next research targets

- true near / room / world / far radiance cascades;
- richer directional probe representation than the current six-lobe field;
- world radiance hit cache / surfel cache;
- many-light importance reservoirs;
- proper motion vectors for animated geometry;
- dedicated rough-specular reconstruction;
- GPU-compute migration.