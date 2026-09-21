# ARL v2.0 — Reconstruction Renderer

## Major architecture change

v2.0 separates lighting estimation from final image reconstruction.

### New screen-space indirect reconstruction
- ARL renders the direct/material base separately from raw indirect lighting.
- Raw indirect is written to a floating-point screen buffer alongside world-position and normal buffers.
- Previous indirect lighting is reprojected into the current frame using the previous view-projection transform.
- History is rejected when reprojected world position or surface normal no longer matches.
- History is neighborhood-clamped to the current frame to prevent stale bright/dark energy from smearing across lighting changes.
- Moving lights, explosions and camera motion reduce temporal history confidence through anti-lag controls.
- A two-pass edge-aware spatial filter denoises indirect lighting using world-position, normal and luminance weights.
- Direct shadows are not denoised or blurred.

### Honest A/B output pipeline
- Direct and ARL now use the same exposure/tone/color path.
- The old behavior where ARL used different final color processing than Direct has been removed.

### Quality tiers
- High: full reconstruction resolution.
- Balanced: 75% indirect reconstruction resolution.
- Performance: 50% indirect reconstruction resolution with full-resolution direct/material base.

### Reconstruction debug
- Final composite
- Raw indirect
- Denoised indirect
- Direct/material base

### New scene
`ARL 2.0 — Production benchmark district` is a purpose-built indoor/outdoor scene with sunlight, cover, open sky, connected geometry, mixed materials, a perfect mirror, dynamic warm/cool lights and deep-shadow regions.

### Existing ARL systems retained
- Lighting Debt scheduling
- directional world ledger
- fine surface GI
- visibility moments
- probe relocation/classification
- camera-tracking world volume
- global directional sun
- explosion/moving-light burst updates
- mirror/specular test path
- volumetric scattering
- QA tour and adaptive/full-refresh benchmark

## Validation
- JavaScript syntax check: PASS.
- Chromium WebGL2 shader compilation using ANGLE/SwiftShader under Xvfb: PASS.
- Reconstructed frame render: PASS with no page error.
- Dark-corner one-frame Direct/ARL screenshot: average luminance ~0.222 vs ~0.227, with ~0.0099 mean absolute luminance difference in the measured crop.
- Real hardware performance and driver behavior still need testing on the Windows GPU.