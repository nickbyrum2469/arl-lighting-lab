# ARL v3.0 — Receiver-First Transport

## Why

The recurring dark-wall / blue-slab artifact could not be solved reliably by filtering alone. The root issue was authority: a broad stable world-probe estimate could still dominate a visible receiver even when local transport evidence disagreed.

## Changes

### Receiver-first authority
- visible-surface local transport now gets first authority;
- world probes are fallback memory rather than equal contributors;
- world authority drops when local/world transport disagree.

### Wider receiver gather
- the existing 24-ray fine gather now spans both near-detail and wider room-scale receiver evidence;
- no additional ray count was added for this step.

### Transport agreement
- ARL compares local and world luminance;
- ARL compares normalized local/world chroma;
- agreement directly affects world authority and temporal-history confidence.

### Chroma confidence
- unsupported colored world GI is partially neutralized on dark receivers;
- verified local colored bounce retains its color.

### Dark receiver energy cap
- broad world energy on a dark receiver is capped by locally supported transport when disagreement is high.

### Predictive Lighting Debt
- moving lights invalidate the old position, current position, and a predicted future influence position.

### Progressive warm-up
- initial probe budget ramps over the first frames;
- early coherence relaxation is staggered;
- direct lighting remains usable while ARL converges.

### Debug
- `DEBUG — Receiver GI`
- `DEBUG — Receiver/World Authority`

## Validation
- JS syntax: PASS
- WebGL2 shader compile/link under Chromium ANGLE/SwiftShader: surface PASS, temporal PASS, spatial PASS, composite PASS.
- Full local scene navigation remains blocked in the sandbox browser by administrator policy, so final visual verification is on the Windows GPU.