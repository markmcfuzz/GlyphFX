# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Documentation of all developed shaders and parameters. Detailed 3ds max setup and usage instructions for each shader.

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