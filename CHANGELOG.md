# Changelog

## v1.8 — Multi-Scale Detail Radiance

- First post-v1.4 release that intentionally changes the visible GI reconstruction instead of mostly adding controls and diagnostics.
- Increased the persistent world grid from 16×8×16 (2,048 cells) to 18×9×18 (2,916 cells).
- Added a 10-ray surface-local fine GI gather for nearby one-bounce color and spatial detail.
- Added a 12-ray smooth contact-visibility gather with continuous falloff.
- Blends fine local transport with the persistent world ledger according to local geometry coverage.
- Reduced the coarse rejection / dark-preservation multipliers that were producing rectangular dark slabs under geometry.
- Reduced exact direct-shadow origin bias for tighter contact edges.
- Added chroma-preserving tone mapping for richer warm/cool bounce separation.
- Added Fine GI Only, World GI Only, and Fine/World Difference debug renderers.
- Added Fine Surface GI, Fine GI Radius, and Color Retention controls.
- Added Fine-detail Torture Gallery with thin shelves, posts, small gaps, close walls, mixed materials, and a moving light.
- Kept pitch-black, moving-light, material, leak, doorway, color-bleed, volumetric, and occlusion-maze tests.

## v1.7
Visible emitter geometry and volumetric scattering.

## v1.6
Directional visibility moments.

## v1.5
Hybrid world ledger + near-field contact preservation.

## v1.4
Directional world radiance ledger.
