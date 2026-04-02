# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Research and Re-implementation of `shader_transparent_chicago.fx`, `shader_transparent_chicago_extended.fx` amd `shader_transparent_generic.fx`

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