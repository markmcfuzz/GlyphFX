# Shader Types

GlyphFX covers all major shader types used in Halo Combat Evolved.
Each shader is a faithful port of the original rendering behavior,
adapted for real-time preview in 3ds Max's DirectX Shader material.

---

## shader_model

Used for `gbxmodel` tags.

**File:** `fx/shader_model.fx`  
**Status:** Complete

### Texture Slots

| Slot | Description |
|---|---|
| Base Map | RGB = diffuse color, A = alpha / opacity mask |
| Detail Map | RGB = detail blend, A = alpha / opacity mask |
| Multipurpose Map | R = auxiliary, G = self-illumination, B = specular, A = change color |
| Reflection Cube Map | 2D cross-layout environment capture |

### Key Parameters

| Parameter | Description |
|---|---|
| [Detail Function] | How the detail map blends with the base map |
| [Detail Mask] | Which multipurpose channel used as mask |
| Change Color | Tint color applied to areas defined by multipurpose alpha channel |
| Self Illumination Color | Color added to lit areas defined by multipurpose green channel |
| Perpendicular / Parallel Tint | Reflection tint at different view angles |

[Detail Function]: parameters\shader_model\detail_function.md "Detail Function parameter"
[Detail Mask]: parameters\shader_model\detail_mask.md "Detail Mask parameter"

### Shader Model Flags

| Flag | Description |
|---|---|
| Detail After Reflection | Applies detail on top of the lit and reflected result |
| Two Sided | Disables backface culling (only ingame) |
| Not Alpha Tested | Skips the alpha clip test |
| Alpha Blended Decal | Marks the surface as an alpha blended decal |
| True Atmospheric Fog | Enables planar atmospheric fog |
| Use Xbox Multipurpose Channel Order | R = specular, G = self-illumination, B = change color, A = auxiliary |

### Debug Parameters (disabled by default)
| Parameter | Description |
|---|---|
| Debug Mode | Inspect RGB and individual channels from multipurpose, base map (unlit), detail map (unlit), and reflection maps (no diffuse) |
| Debug Reflection Intensity | Adjust the intensity of the reflection map without affecting diffuse lighting |

---

## shader_environment

Used for level geometry — floors, walls, ceilings and terrain.

**File:** `fx/shader_environment.fx`  
**Status:** In progress

---

## shader_transparent_chicago

Used for simple transparent surfaces with a fixed pipeline of map stages.

**File:** `fx/shader_transparent_chicago.fx`  
**Status:** In progress



---

## shader_transparent_chicago_extended

Extended version of chicago with additional map stages.

**File:** `fx/shader_transparent_chicago_extended.fx`  
**Status:** In progress

---

## shader_transparent_generic

A flexible transparent shader driven entirely by tag parameters.

**File:** `fx/shader_transparent_generic.fx`  
**Status:** In progress

---

## shader_transparent_glass

Used for glass surfaces with reflection and refraction approximation.

**File:** `fx/shader_transparent_glass.fx`  
**Status:** In progress

---

## shader_transparent_meter

Used for HUD meter elements and energy bar surfaces.

**File:** `fx/shader_transparent_meter.fx`  
**Status:** In progress

---

## shader_transparent_plasma

Used for plasma and energy effect surfaces.

**File:** `fx/shader_transparent_plasma.fx`  
**Status:** In progress

---

## shader_transparent_water

Used for water surfaces with animated scrolling and transparency.

**File:** `fx/shader_transparent_water.fx`  
**Status:** In progress