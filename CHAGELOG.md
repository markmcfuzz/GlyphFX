# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Documentation of all developed shaders and parameters.

## [0.6.0] - 2026-07-16

### Added

- ``shader_transparent_generic.fx`` fully re-implemented and tested. Not tested neither documented yet.

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