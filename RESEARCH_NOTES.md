# ARL Research Notes

## Why v1.4–v1.7 looked too similar

The audit found that later releases were still reconstructing most indirect light from essentially the same low-frequency world probe field. More controls, visibility moments, volumetrics, and emitter presentation did not change the spatial bandwidth of the GI enough to produce a major visual jump.

The main remaining artifacts were:

- rectangular or slab-like dark regions near object bases;
- missing fine indirect detail around small gaps, trim, corners, and thin geometry;
- indirect light sometimes washing out dark contact regions;
- colored bounce losing saturation;
- source objects not reading strongly enough as emitters;
- shadow quality being inconsistent between authoritative direct visibility and coarse GI shaping.

## Research direction adopted in v1.8

### Multi-scale reconstruction

Sparse probe GI loses spatial detail when probes are widely spaced. Recent Split Radiance Cascades work explicitly attacks this by using higher spatial resolution for nearer transport and coarser spatial resolution farther away.

v1.8 uses a practical two-scale prototype:

1. **World ledger** — persistent directional probes for broad, stable, reusable GI.
2. **Fine surface gather** — short local rays evaluated at the shaded surface for small-scale one-bounce color and occlusion.

This is deliberately different from simply making the entire world probe grid extremely dense.

### Visibility and probe production lessons

Production DDGI/RTXGI work uses directional irradiance plus distance information, visibility-weighted interpolation, self-shadow bias, probe relocation, classification/state machines, and adaptive convergence.

ARL keeps those ideas where useful but adds Lighting Debt as the work scheduler.

### Direct shadow separation

Direct shadows are treated as authoritative geometry visibility. Fine GI is not allowed to invent a replacement direct shadow. The main ARL path therefore keeps crisp exact visibility, while area-light/reference modes remain available separately.

### Color retention

The previous ACES-like tonemapping path could make already-soft GI look even more neutral. v1.8 adds a modest chroma-preserving post-tone adjustment only to the new path.

## Next research

- true near/mid/far sparse radiance cascades;
- per-cell local-light reservoirs;
- richer directional representation than six lobes;
- GPU compute migration;
- temporal reuse for fine surface paths;
- specular / glossy indirect path separate from diffuse ARL.
