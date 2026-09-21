# ARL Lighting Lab v1.13 — Production-Path Reconstruction Pass

## Low-light reconstruction
- Removed the v1.12 one-way low-frequency GI lift that could only brighten dark regions.
- Replaced it with symmetric confidence-aware reconstruction that can brighten **or** darken toward the coarse field while clamping the correction.
- Reworked the shadow tone curve so zero radiance remains zero; nonzero dark detail gets a mild multiplicative gain instead of a forced black floor.
- Reduced output dithering to ~0.65 LSB.

## Spatial coherence
- Probe relaxation is now visibility-aware: neighboring probes do not smooth through blocking geometry.
- Relaxation is also radiance-edge-aware, so sharp real lighting discontinuities are preserved while low-frequency patchiness is reduced.
- Added a logical near/far GI reconstruction blend: near surfaces favor directional/fine GI while distant surfaces gradually favor the more stable low-frequency field.

## QA / engine validation
- Added **RUN ARL QA TOUR**.
- It automatically cycles major test presets, lets them settle, records residual, leak score, confidence, variability, update time, and update count, then prints a summary plus a console table.
- Preserved moving-light, mirror, Sunlit Courtyard, open-world sun, and chaos/explosion stress tests.

## Validation
- JavaScript syntax validation passed.
- The sandbox browser can execute the page bootstrap, but its headless Chromium environment reports WebGL2 unavailable. Final GPU/GLSL validation still requires the real Windows browser/GPU or the Windows PC connector.
