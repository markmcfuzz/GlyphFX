# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Documentation of all developed shaders and parameters. Detailed 3ds max setup and usage instructions for each shader.

## [1.0.0] - 2026-11-08

### Added

- **OSL versions of `shader_model`, `shader_model_extended` and `shader_environment`** (`src/osl/`), with the same parameters as the `.fx`. Transparent objects no longer disappear behind opaque ones in the viewport.
  - Alpha test and alpha-blended decals work (e.g. the jackal's spikes are cut out).
  - New `Light From View` option to light from the camera. On by default in `shader_environment`, so large maps no longer look dark.
- **Animation Preview** plays the tag's animations in the viewport:
  - generic and chicago: texture animations (generic also the color animation);
  - water: ripples;
  - plasma: noise maps;
  - OSL `shader_model` / `shader_model_extended`: texture animation and self-illumination;
  - OSL `shader_environment`: texture scrolling and self-illumination.
- **Animation Loop Length** (every shader with Animation Preview) makes the preview loop with the 3ds Max timeline without a jump. Cosine, diagonal wave and slide, and the water and plasma scrolling, adjust their speed slightly to fit it; the random functions keep theirs.
- **Shader Transparent Generic:** four change colors (`Change Color A`..`D`) instead of one. Scenes saved with the old `Change Color` lose its value.

### Changed

- **OSL shaders:** the enum parameters (animation functions and sources, detail function and mask, material type, debug mode...) are dropdowns with their names instead of number sliders.
- **OSL `shader_model_extended`:** the viewport-only tuning parameters (`Specular Lighting Tightness`, `Reflection Blur`, the cubemap offsets and pitch, `Fix Mirrored UV Tangents`) are hidden.
- **All transparent shaders:** smooth transparency instead of a dither, blended as in game. Effects no longer look twice as bright (e.g. the jackal shield).
- **Two Sided** now works in generic, chicago, glass and meter.
- **Shader Transparent Generic / Chicago:**
  - One technique each; `Framebuffer Blend Function` picks the blend, as in the tag.
  - Much faster to load in 3ds Max (generic 4.9 s -> 0.5 s).
  - Map rotation follows the engine order.
- **Shader Transparent Chicago:** a map scale of 0 now means 1, as in the tag.

### Removed

- **Transparent shaders:** the dither parameters (`Viewport Blend` group and similar), no longer needed.

### Fixed

- **Shader Transparent Generic:** the lens flare fields are always available.
- **Shader Model:** `Animation Center X/Y` are back in their group.
- **Shader Transparent Chicago:** parameter order, a misnamed group and some wrong labels.

### Notes

- Tag fields can't be hidden in the DirectX Shader material, so in the `.fx` shaders all of them stay visible.

## [0.9.3] - 2026-11-03

### Added

- **Shader Transparent Generic / Chicago:**
  - New `Viewport Blend` parameter group (GlyphFX-only, not tag data) for the Add, Multiply and Double Multiply techniques: `Background Brightness` (default 0), `Dither Amount` (default 1; above 1 shows more background, dimmer), `Max Opacity` (default 1) and `Color Saturation` (default 1). Alpha Blend does not use them.
- **Docs:**
  - `docs/proposals/animation_preview.md`: proposal for previewing tag animations in 3ds Max (GlyphFX evaluates the animation, the Toolkit feeds scene time, the object's A-D outputs and change colors).

### Changed

- **Shader Transparent Generic / Chicago:**
  - Add, Multiply and Double Multiply now use the same coverage solve as `shader_transparent_water` (shared in `_coverage.fxh`), so the effect keeps its in-game brightness on average. Previously the color was drawn opaque with its luminance as coverage, which made dim additive effects (e.g. the jackal and field generator shields) show up only on a few scattered pixels and replace the background instead of adding to it.
  - When `Dither Amount` above 1 or `Max Opacity` below 1 lowers the coverage, the color now dims evenly instead of clipping its brightest channel, so the hue is kept (an orange shield no longer turns yellow-green).

### Fixed

- **Shader Transparent Generic:**
  - Combiner registers are now clamped to [-1, 1] after each stage's output mapping, as on the original hardware. A stage using `Scale by 2` or `Scale by 4` could previously pass values above 1 to the stages after it.

## [0.9.3] - 2026-11-02

### Added

- **Shader Transparent Generic:**
  - New `Change Color (Only for 3ds Max)` parameter (`ChangeColor`, default white). Stages whose `Color0 Source` is A-D now multiply their color0 RGB by it, as the engine does with the object's change color (e.g. the jackal shield uses change color C). One color per material, shared by all such stages.

## [0.9.2] - 2026-10-19

### Changed

- **Shader Model Extended:**
  - Reworked the reflection and specular lighting so the model no longer looks washed out and glossy all over. The perpendicular/parallel brightness and tint now follow the normal-mapped normal, the cube map is sampled along the true mirror direction, the highlight is a tighter Phong highlight from both the scene and fill lights and is added after the details, and the specular color map tints only the highlight. With `Detail After Reflection` on, the lit result is clamped before the details again, as in `shader_model`.
  - Detail maps 1 and 2 now tile on top of the base map's `Map U/V Scale`, as in the stock vertex shader.
  - New `Specular Lighting Tightness` debug parameter (default 2) that narrows the highlight in the viewport.

## [0.9.1] - 2026-10-08

### Fixed

- **Shader Model Extended:**
  - Fixed detail after reflection not working properly.

## [0.9.0] - 2026-10-08

### Added

- **Shader Model Extended:**
    - New `shader_model_extended.fx`: ringworld's extended `shader_model`, based on the OpenSauce model extension. Adds a base normal map whose alpha mixes two detail normal maps (0 = none, 85 = detail 1, 170 = detail 2, 255 = none), a specular color map that tints the reflection and highlight, specular lighting from the scene light, and a second detail map applied after the first. See `docs/parameters/shader_model_extended/bump_and_specular.md`.

## [0.8.0] - 2026-07-25

### Added

- **Shader Transparent Chicago / Shader Transparent Generic:**
    - Numeric Counter Plate parameters. With the `Numeric` flag on, Map 1 is treated as the digit plate the bitmap sequence was sliced from and a single digit (0-9) is cropped out of it, covering both horizontal and vertical plate layouts. See `docs/parameters/shader_transparent_chicago/numeric_counter.md`.

### Fixed

- **Shader Model:**
    - `Detail Map V Scale` is now a multiplier on top of `Detail Map Scale` instead of an absolute V value, matching the tag. The `detail map scale` field drives both axes, and the v-scale field only rescales V: with a scale of 10, a v-scale of 0 or 1 gives V 10, and 0.5 gives V 5. Previously the v-scale replaced the scale outright, so any value other than 0 broke the detail map's tiling.
- **Shader Transparent Chicago:**
    - Map color/alpha functions now blend the map with the one that FOLLOWS it, matching the tag. Map 1's function was previously ignored and Map 4's was applied even though nothing follows it. This is what makes tinting a map through a second map work. See `docs/parameters/shader_transparent_chicago/map_color_alpha_functions.md`.
    - Map color/alpha functions now implement all 13 tag values; subtract, and the four blend-by-alpha modes, were missing.

## [0.7.2] - 2026-07-22

### Fixed

- **Shader Transparent Water:**
    - Fixed some transparency issues.
- **Shader Environment:**
    - Fixed rescaled details and bump map flags like the game does based in the ratio scale from base map.

## [0.7.1] - 2026-07-21

### Changed

- Updated parameters order in all shaders and added some were missing.

## [0.7.0] - 2026-07-21

### Added

- `shader_transparent_plasma.fx` fully re-implemented and tested. Not documented yet.

### Changed

- Updated parameters for transparent shaders to represent the real tag fields.

## [0.6.0] - 2026-07-16

### Added

- ``shader_transparent_generic.fx`` fully re-implemented and tested. Not documented yet.

## [0.5.0] - 2026-04-20

### Added

- `shader_transparent_water.fx` fully re-implemented and tested. Not documented yet.

## [0.4.0] - 2026-04-19

### Added

- `shader_transparent_glass.fx` fully re-implemented and tested. Not documented yet.

## [0.3.1] - 2026-04-19

### Fixed

- **Shader Model:** 
    - Fixed `alpha-blended decal` functionality.

## [0.3.0] - 2026-04-17

### Added

- `shader_environment.fx` fully implemented. Not documented yet. Still needs to test the self-illumination/animation functions.

## [0.2.1] - 2026-04-17

### Changed

- Updated `shader_transparent_chicago.fx` params to match original shader order.
- Updated `_cubemap.fxh` to blend transitions more smoothly.

## [0.2.0] - 2026-04-15

### Added
- `shader_transparent_meter.fx` and `shader_transparent_chicago.fx` fully re-implemented and tested. Not documented yet.


## [0.1.3] - 2026-04-15

### Added
- Documentation for `shader_model` parameters "detail function" for blending the detail map with the base map.

### Changed
- Updated `cyborg.max` example scene to use the new `shader_model` parameters and techniques.
- Updated `shader_types.md` documentation.
- Moved asset cyborg files to `examples/cyborg` folder for better organization.

## [0.1.2] - 2026-04-09

### Changed

- **Shader Model:**
    - Adjusted parameters order to match original `shader_model` tag.
    - Hide debug parameters and ambient/light by default.
    - Renamed technique to `shader_model`

## [0.1.1] - 2026-04-01

### Added

- Documentation of `shader_model` parameters.
- Example 3ds Max 2023 scene with `shader_model` applied in the cyborg model.

### Fixed

- **Shader Model:**
    - Enhance reflection calculations in pixel shader by adjusting specular reflection mask and adding brightness boost for tinted reflections to match original shader_model.
    - Adjust light intensity amount for better initial setup.
    - Shader is more accurate to the original.

## [0.1.0] - 2026-04-01

### Added
- Initial development and shader conversions.
- `shader_model.fx` fully converted and implemented.

## [0.0.1] - 2026-03-31

### Added

- Initial release, readme and changelog created.