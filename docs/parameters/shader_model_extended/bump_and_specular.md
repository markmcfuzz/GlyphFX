# Bump and Specular Properties
`shader_model_extended` adds normal mapping and specular controls on top of `shader_model`. They come from ringworld's `shader_model_extended`, which is based on the OpenSauce model extension and adds a second detail map.

`Enable Extended` (3ds Max only) turns all of these additions on or off at once. With it off, the material renders exactly like `shader_model`, which is handy for comparing the two.

Values written as `0 = 1` keep the raw tag value in the material. The shader treats 0 as 1, which is what OpenSauce does when it builds the map.

---

### Base Normal Map
The base normal map uses the same UVs as the base map (`Map U/V Scale`).

- `RGB` = tangent-space normal.
- `Alpha` = chooses which detail normal map shows. It does not affect the base normal itself.

| Alpha | Value | Detail normals shown |
|---|---|---|
| 0 | 0.000 | None |
| 0 → 85 | 0.000 → 0.333 | Detail normal 1 fades in |
| 85 | 0.333 | Detail normal 1 at full strength |
| 85 → 170 | 0.333 → 0.666 | Mix: detail normal 1 fades out while detail normal 2 fades in |
| 170 | 0.666 | Detail normal 2 at full strength |
| 170 → 255 | 0.666 → 1.000 | Detail normal 2 fades out |
| 255 | 1.000 | None |

Use `Debug Mode 10` to see the weights: red = detail normal 1, green = detail normal 2.

Without a base normal map, detail normal 1 is applied on its own at full strength and detail normal 2 is not used.

### Coefficients
| Parameter | Effect |
|---|---|
| Base Normal Coefficient (0 = 1) | Multiplies the slope of the base normal. Above 1 it also flattens the normal's Z by `1 / coefficient`, which makes the relief stronger |
| Detail Normal 1/2 Coefficient (0 = 1) | Multiplies the slope that detail normal adds |
| Detail Normal 1/2 Scale (0 = 1) | Tiling of the detail normal, on both axes |
| Detail Normal 1/2 V Scale (0 = 1) | Multiplier on top of the scale, for V only |

The final normal is used for the scene light, the fill light, the cube map reflection direction and specular lighting. The perpendicular/parallel reflection brightness and tint keep using the mesh normal, as in the stock shader where they are computed per vertex. That way the normal map bends the reflection without darkening it.

**Mirrored UVs.** In-game, the tangent frame comes from the UVs, so a normal map baked on a mirrored (symmetric) model reads correctly on both halves. The tangents 3ds Max provides do not always follow the mirroring, which shows as a seam down the middle of the model when the light comes from the side. `Fix Mirrored UV Tangents` (debug parameters, on by default) rebuilds the direction of the tangent and binormal from the UVs per pixel. `Debug Mode 16` shows where it acts: red = tangent flipped, green = binormal flipped. On a mirrored model, only one half should be colored.

Normal maps are sampled with anisotropic filtering to keep their relief from turning into noise at oblique angles. If the relief still reads too strong, lower `Bump Strength` in the debug parameters.

Turn off the `Enable` flag of any map slot left empty: an empty slot reads as black, so a black specular map removes the reflection and a black detail map turns the model black.

---

### Specular Color Map
The specular color map uses the same UVs as the base map.

- `RGB` = tints the specular result, per pixel. The tint applies to both the cube map reflection and specular lighting. Computed as `pow(rgb, Specular Color Exponent) × Specular Color Coefficient`, both `0 = 1`, then clamped to 0-1. The coefficient raises a dark specular map up to full strength; it never makes the reflection brighter than the stock `shader_model` one.
- `Alpha` = when **Alpha as Exponent Mask** is set, it scales the specular lighting exponent. Low alpha gives a broad, soft highlight; high alpha gives a tight one.

### Specular Lighting
A highlight from the scene light, masked by the multipurpose reflection mask (`Blue` on PC) and tinted by the specular color map.

| Parameter | Effect |
|---|---|
| Specular Lighting Exponent | Highlight tightness. **0 turns specular lighting off** |
| Specular Lighting Coefficient (0 = 1) | Highlight intensity |

`Do Not Use DLMs (BSP)` disables the BSP's directional lightmaps in-game and has no effect in the viewport.

---

### Detail Map 2
Works like the detail map, with its own `Function`, `Mask`, `Scale` and `V Scale`. It is applied right after the detail map, both before and after reflection (`Detail After Reflection`).

With `Detail After Reflection` on, the lit and reflected result is not clamped before the details are applied, only at the end. `shader_model` clamps it first; doing that here flattened bright surfaces to white and wiped out the normal-map relief.

---

### What comes from OpenSauce and what is assumed
ringworld's source for this shader is not available yet, and OpenSauce ships its pixel shaders compiled and encrypted. These rules are taken from OpenSauce's tag definition and C++, which ringworld's shader is based on:

- the `0 = 1` defaults,
- the Z flattening of the base normal coefficient,
- detail normal 2 needing a base normal map,
- specular lighting being off when its exponent is 0,
- the specular color map multiplying the specular result.

These parts are **assumptions**, each one line to change if the game looks different:

- Base and detail normals are combined by adding their slopes (XY), keeping the base Z.
- Alpha as Exponent Mask multiplies the exponent by alpha (never below 1).
- The specular color is clamped to 0-1. Without the clamp, the helljumper infection form (coefficient 5) rendered as chrome, which the game does not show.
- The highlight uses the multipurpose reflection mask, but not the perpendicular/parallel brightness and tint.
- Detail map 2 is applied after the detail map.
